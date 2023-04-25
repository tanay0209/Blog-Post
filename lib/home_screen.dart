import 'package:blog_post/authentication.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
            child: InkWell(
              child: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
              onTap: () {
                authentication.signOut();
              },
            ),
          )
        ],
        title: const Text("Blog Post"),
      ),
    );
  }
}
