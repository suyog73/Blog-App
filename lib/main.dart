import 'package:blogger/helpers/constants.dart';
import 'package:blogger/provider/favorite_provider.dart';
import 'package:blogger/screens/landing_screen.dart';
import 'package:blogger/services/app_routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

import 'model/blog_model_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await dotenv.load(fileName: ".env");

  Hive.registerAdapter(BlogModelAdapter());

  await Hive.initFlutter();
  await Hive.openBox(kBloggerBox);
  await Hive.openBox(kFavoriteBox);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FavoriteProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Blogger',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: LandingScreen.route,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
