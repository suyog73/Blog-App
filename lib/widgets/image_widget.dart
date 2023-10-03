import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/blog_model.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    required this.blogModel,
  });

  final BlogModel blogModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CachedNetworkImage(
        imageUrl: blogModel.imageUrl,
        placeholder: (context, url) => const CircularProgressIndicator(),
        errorWidget: (context, url, error) => Column(
          children: [
            const Icon(Icons.error, color: Colors.red),
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.5,
              child: const Text(
                "You're offline. Please connect to internet to load images",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
