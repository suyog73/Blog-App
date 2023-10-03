import 'package:hive/hive.dart';

import 'blog_model.dart';

class BlogModelAdapter extends TypeAdapter<BlogModel> {
  @override
  final int typeId = 0;

  @override
  BlogModel read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();
    return BlogModel(
      id: fields['id'] as String,
      imageUrl: fields['imageUrl'] as String,
      title: fields['title'] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BlogModel obj) {
    writer.writeMap({
      'id': obj.id,
      'imageUrl': obj.imageUrl,
      'title': obj.title,
    });
  }
}
