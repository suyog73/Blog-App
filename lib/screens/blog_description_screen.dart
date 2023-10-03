import 'package:blogger/helpers/constants.dart';
import 'package:blogger/model/blog_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_provider.dart';
import '../widgets/image_widget.dart';

class BlogDescriptionScreen extends StatelessWidget {
  static const route = '/BlogDescriptionScreen';

  final BlogModel blogModel;

  const BlogDescriptionScreen({super.key, required this.blogModel});

  @override
  Widget build(BuildContext context) {
    bool isFavorite =
        Provider.of<FavoriteProvider>(context).getIsFavorite(blogModel.id);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 26, right: 26),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        blogModel.title,
                        style: const TextStyle(fontSize: 24),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        // Toggle the favorite status
                        Provider.of<FavoriteProvider>(context, listen: false)
                            .toggleFavorite(blogModel.id);
                      },
                    ),
                  ],
                ),
                const LineBreak(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
                  child: ImageWidget(blogModel: blogModel),
                ),
                const LineBreak(),
                const Text(
                  "Description",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Text(
                  kDescription,
                  style: TextStyle(fontSize: 16),
                ),
                const LineBreak(),
                Text(
                  "Date:- ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const LineBreak(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LineBreak extends StatelessWidget {
  const LineBreak({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }
}
