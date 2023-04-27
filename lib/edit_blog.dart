import 'package:blog_post/home_screen.dart';
import 'package:blog_post/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBlog extends StatefulWidget {
  final String uuid;
  final String title;
  final String description;
  const EditBlog(
      {required this.uuid,
      required this.title,
      required this.description,
      super.key});

  @override
  State<EditBlog> createState() => _EditBlogState();
}

class _EditBlogState extends State<EditBlog> {
  GlobalKey<FormState> formKey = GlobalKey();
  late String _title;
  late String _description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit your Blog"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Image.asset("assets/create_blog.png"),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.title,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: const BorderSide()),
                      labelText: "Blog Title",
                      labelStyle: GoogleFonts.baloo2(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    initialValue: widget.description,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field Cannot be empty';
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      label: const Text("Blog Description"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(),
                      ),
                      labelStyle: GoogleFonts.baloo2(),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.all(12)),
                      onPressed: () async {
                        final validity = formKey.currentState!.validate();
                        FocusScope.of(context).unfocus();
                        if (validity) {
                          formKey.currentState!.save();
                          var response = await BlogProvider()
                              .editBlog(widget.uuid, _title, _description);
                          if (response.statusCode == 200) {
                            dynamic snack = const SnackBar(
                              content: Text('Blog Edited'),
                              duration: Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
