import 'dart:math';
import 'package:blog_post/constants.dart';
import 'package:blog_post/screens/edit_blog.dart';
import 'package:blog_post/styles.dart';
import 'package:blog_post/utils/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogDetails extends StatefulWidget {
  final String title;
  final String description;
  final String uuid;
  final String uid;
  const BlogDetails(
      {required this.title,
      required this.description,
      required this.uuid,
      required this.uid,
      super.key});

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  BlogProvider blogProvider = BlogProvider();
  Styles style = Styles();
  Random random = Random();
  List<Color> backgroundColor = [
    Styles().orange,
    Styles().yellow,
  ];
  randomColorSelector() {
    return backgroundColor[random.nextInt(backgroundColor.length)];
  }

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser!.uid);
    print(widget.uid);

    return Scaffold(
      appBar: AppBar(
        actions: [
          FirebaseAuth.instance.currentUser!.uid == widget.uid
              ? Container(
                  padding: const EdgeInsets.all(6),
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.pen,
                      color: style.whiteColor,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditBlog(
                            uuid: widget.uuid,
                            title: widget.title,
                            description: widget.description,
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Container(),
        ],
        title: const Text("Blog"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: w,
                child: Text(
                  widget.title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                      fontSize: 42, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: randomColorSelector(),
                ),
                padding: const EdgeInsets.all(14),
                width: double.maxFinite,
                child: Text(
                  widget.description,
                  style: GoogleFonts.baloo2(fontSize: 18),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              FirebaseAuth.instance.currentUser!.uid == widget.uid
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 150,
                          child: TextButton.icon(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: style.purple,
                              padding: const EdgeInsets.all(8),
                            ),
                            icon: const FaIcon(
                              FontAwesomeIcons.trash,
                              size: 32,
                            ),
                            onPressed: () async {
                              var response =
                                  await BlogProvider().deleteBlog(widget.uuid);
                              if (response.statusCode == 200) {
                                dynamic snack = const SnackBar(
                                  content: Text('Blog Deleted'),
                                  duration: Duration(seconds: 3),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snack);
                                Navigator.of(context).pop();
                              }
                            },
                            label: Text(
                              "Delete",
                              style: GoogleFonts.baloo2(fontSize: 24),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
