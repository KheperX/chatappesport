import 'package:app/eSports/authentication/models/helper_function.dart';
import 'package:app/eSports/home/home.dart';
import 'package:app/eSports/profile/views/profile.dart';
import 'package:app/eSports/profile/views/styles.dart';
import 'package:app/shared/constants..dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'cartoon/show_cartoon_list.dart';

import 'eSports/newblog/views/newblog.dart';
import 'eSports/reccomend/views/GamesRec.dart';
import 'flutter_firebase_test1/data.dart';
import 'eSports/blogchat/views/blogchat.dart';
import 'eSports/newblog/views/newblog_post.dart';
import 'eSports/gamer/gamers.dart';
import 'eSports/news/views/news.dart';
import 'eSports/reccomend/views/reccomend.dart';
import 'eSports/sponsor/sponsors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:app/eSports/authentication/views/LoginPage.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'dart:async';

// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  getUserLoggedInStatus() async {
    await HelperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Constants().primaryColor,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? const HomeScreen() : const LoginPage(),
    );
  }
}
