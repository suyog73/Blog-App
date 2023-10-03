import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.deepPurple.withOpacity(0.25),
      highlightColor: Colors.deepPurple.withOpacity(0.1),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(12.0),
            height: 250.0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: Colors.white),
          );
        },
      ),
    );
  }
}
