import 'package:blogger/helpers/constants.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import '../model/blog_model.dart';

class BlogApi {
  Dio dio = Dio();

  Future<List<BlogModel>?> fetchBlogs() async {
    try {
      final customHeader = {'x-hasura-admin-secret': kHeader};

      final response =
          await dio.get(kBASEURL, options: Options(headers: customHeader));

      if (response.statusCode == 200) {
        final dynamic responseData = await response.data;

        final List<dynamic> data = responseData['blogs'];
        final bloggerBox = Hive.box(kBloggerBox);

        // bloggerBox.clear();

        List<BlogModel> blogs = data.map((json) {
          return BlogModel.fromJson(json);
        }).toList();

        for (final blog in blogs) {
          if (!bloggerBox.containsKey(blog.id)) {
            bloggerBox.put(blog.id, blog);
          }
        }

        return blogs;
      } else {
        const errorMessage = 'Failed to load blogs. Please try again later.';

        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<BlogModel>> getBlogsFromHive() async {
    final bloggerBox = await Hive.openBox(kBloggerBox);
    final List<BlogModel> blogs = bloggerBox.values.cast<BlogModel>().toList();
    return blogs;
  }
}
