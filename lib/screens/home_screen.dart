import 'package:blog_post/screens/blog_details.dart';
import 'package:blog_post/constants.dart';
import 'package:blog_post/screens/create_blog.dart';
import 'package:blog_post/styles.dart';
import 'package:blog_post/utils/authentication.dart';
import 'package:blog_post/utils/provider.dart';
// ignore: unused_import
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

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<BlogProvider>(context, listen: false).fetchBlogs();
    });
  }

  Styles style = Styles();
  List? blogs = [];
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
          child: FaIcon(
            FontAwesomeIcons.plus,
            color: style.whiteColor,
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
          ? Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: style.whiteColor,
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
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: style.whiteColor,
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
                          color: index % 2 == 0 ? style.orange : style.yellow,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                width: w,
                                child: Text(
                                  blogs![index]["title"],
                                  style: GoogleFonts.baloo2(
                                    color: style.whiteColor,
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
                                      fontSize: 18, color: style.whiteColor),
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
