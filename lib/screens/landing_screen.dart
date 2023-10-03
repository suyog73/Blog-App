import 'dart:async';

import 'package:blogger/model/blog_model.dart';
import 'package:blogger/screens/blog_description_screen.dart';
import 'package:blogger/services/blog_api.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../helpers/constants.dart';
import '../provider/favorite_provider.dart';
import '../widgets/blog_card.dart';
import '../widgets/shimmer_widget.dart';
import 'favorite_screen.dart';

class LandingScreen extends StatefulWidget {
  static const route = '/';

  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  ConnectivityResult _connectivityResult = ConnectivityResult.none;

  Future<void> initConnectivity() async {
    final ConnectivityResult result = await Connectivity().checkConnectivity();
    setState(() {
      _connectivityResult = result;
    });
  }

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        _connectivityResult = result;
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  bool isConnectedToInternet() {
    return (_connectivityResult == ConnectivityResult.wifi ||
        _connectivityResult == ConnectivityResult.mobile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(kAppName),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, FavoriteScreen.route);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.red,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: const Text(
                  "Favorite",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: FutureBuilder<List<BlogModel>?>(
          future: (isConnectedToInternet())
              ? BlogApi().fetchBlogs()
              : BlogApi().getBlogsFromHive(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                isConnectedToInternet()) {
              return const ShimmerWidget();
            } else if (snapshot.hasError) {
              return Center(
                child:
                    Lottie.asset("assets/lottie/problem.json", repeat: false),
              );
            } else if (snapshot.hasData) {
              List<BlogModel>? blogs = snapshot.data;

              if (blogs == null) {
                return const CircularProgressIndicator();
              } else {
                blogs.sort((blog1, blog2) => blog1.id.compareTo(blog2.id));

                if (blogs.isEmpty) {
                  return Center(
                    child: Lottie.asset("assets/lottie/problem.json",
                        repeat: false),
                  );
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    BlogModel blogModel = blogs[index];

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          BlogDescriptionScreen.route,
                          arguments: blogModel,
                        );
                      },
                      child: BlogCard(
                        blogModel: blogModel,
                        isConnectedToInternet: isConnectedToInternet(),
                        isFavorite: Provider.of<FavoriteProvider>(context)
                            .getIsFavorite(blogModel.id),
                      ),
                    );
                  },
                );
              }
            } else {
              return const Center(
                child: Text('No blogs available.'),
              );
            }
          },
        ),
      ),
    );
  }
}
