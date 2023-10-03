import 'dart:async';
import 'package:blogger/model/blog_model.dart';
import 'package:blogger/screens/blog_description_screen.dart';
import 'package:blogger/services/blog_api.dart';
import 'package:blogger/widgets/no_blogs_message.dart';
import 'package:blogger/widgets/shimmer_widget.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/favorite_provider.dart';
import '../widgets/blog_card.dart';

class FavoriteScreen extends StatefulWidget {
  static const route = '/FavoriteScreen';

  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
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
      appBar: AppBar(title: const Text("Favorite Blogs")),
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
                bool isFavAvailable = Provider.of<FavoriteProvider>(context)
                    .isFavoriteAvailable();

                if (isFavAvailable == false) {
                  return const NoBlogsMessage(isFav : true);
                }

                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: blogs.length,
                  itemBuilder: (context, index) {
                    BlogModel blogModel = blogs[index];

                    bool isFavorite = Provider.of<FavoriteProvider>(context)
                        .getIsFavorite(blogModel.id);

                    if (isFavorite) {
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
                    } else {
                      return Container();
                    }
                  },
                );
              }
            } else {
              return const Center(child: Text('No blogs available.'));
            }
          },
        ),
      ),
    );
  }
}
