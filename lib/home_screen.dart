import 'package:blog_post/authentication.dart';
import 'package:blog_post/blog_details.dart';
import 'package:blog_post/constants.dart';
import 'package:blog_post/create_blog.dart';
import 'package:blog_post/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List? blogs = [];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
    });
  }

  Authentication authentication = Authentication();
  @override
  Widget build(BuildContext context) {
    Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
    bool isLoading = Provider.of<BlogProvider>(context, listen: true).isLoading;
    blogs = Provider.of<BlogProvider>(context, listen: true).fetchedBlogs;

    if (blogs!.isEmpty) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateBlog(),
              ),
            );
          },
          tooltip: "Create a New Blog",
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
        ),
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              "Nothing To show, Why not create a new Blog ?",
              textAlign: TextAlign.center,
              softWrap: true,
              style: GoogleFonts.baloo2(
                fontSize: 24,
              ),
            ),
          ),
        ),
      );
    } else {
      return isLoading
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4.0,
                ),
              ),
            )
          : Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateBlog(),
                    ),
                  );
                },
                tooltip: "Create a New Blog",
                child: const FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
              ),
              appBar: AppBar(
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 10, 0),
                    child: InkWell(
                      child:
                          const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                      onTap: () {
                        authentication.signOut();
                      },
                    ),
                  )
                ],
                title: const Text("Blog Post"),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: blogs!.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlogDetails(
                                  title: blogs![index]["title"],
                                  description: blogs![index]["description"],
                                  uuid: blogs![index]["_uuid"],
                                  uid: blogs![index]["userId"]),
                            ),
                          );
                        },
                        child: Card(
                          color: index % 2 == 0
                              ? Color.fromARGB(255, 238, 143, 127)
                              : Color.fromARGB(255, 233, 174, 11),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: w,
                                child: Text(
                                  blogs![index]["title"],
                                  style: GoogleFonts.baloo2(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: w,
                                child: Text(
                                  blogs![index]["description"],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: true,
                                  style: GoogleFonts.baloo2(
                                      fontSize: 18, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            );
    }
  }
}
