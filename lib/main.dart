import 'package:blog_post/screens/home_screen.dart';
import 'package:blog_post/styles.dart';
import 'package:blog_post/utils/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'authentication/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BlogPost());
}

class BlogPost extends StatelessWidget {
  const BlogPost({super.key});

  @override
  Widget build(BuildContext context) {
    Styles style = Styles();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BlogProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: style.primaryPurple,
          primaryColor: style.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, userSnapShot) {
              if (userSnapShot.hasData) {
                return const HomeScreen();
              } else {
                return const AuthScreen();
              }
            }),
      ),
    );
  }
}
