import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoBlogsMessage extends StatelessWidget {
  final bool isFav;
  const NoBlogsMessage({super.key, this.isFav = false});

  @override
  Widget build(BuildContext context) {
    String text = isFav ? "No favorite blogs available" : "No Blogs available";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset("assets/lottie/problem.json", repeat: false),
        Text(text,style: const TextStyle(fontSize: 22),),
      ],
    );
  }
}
