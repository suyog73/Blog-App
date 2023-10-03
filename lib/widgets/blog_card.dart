
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/blog_model.dart';
import '../provider/favorite_provider.dart';
import 'image_widget.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blogModel,
    required this.isConnectedToInternet,
    required this.isFavorite,
  });

  final BlogModel blogModel;
  final bool isConnectedToInternet;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 200.0,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                if (isConnectedToInternet)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                ImageWidget(blogModel: blogModel),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    blogModel.title,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
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
          ),
        ],
      ),
    );
  }
}
