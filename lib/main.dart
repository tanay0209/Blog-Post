import 'package:blog_post/auth_screen.dart';
import 'package:blog_post/home_screen.dart';
import 'package:blog_post/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const BlogPost());
}

class BlogPost extends StatelessWidget {
  const BlogPost({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => BlogProvider(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.purple,
            primaryColor: const Color.fromARGB(255, 28, 136, 230)),
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
