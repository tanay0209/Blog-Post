import 'package:blog_post/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  GlobalKey<FormState> formKey = GlobalKey();
  late String _title;
  late String _description;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create A Blog"),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0))),
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.all(12)),
                      onPressed: () async {
                        final validity = formKey.currentState!.validate();
                        FocusScope.of(context).unfocus();
                        if (validity) {
                          formKey.currentState!.save();
                          var response = await BlogProvider()
                              .createBlog(_title, _description);
                          if (response.statusCode == 201) {
                            dynamic snack = const SnackBar(
                              content: Text('Blog Created'),
                              duration: Duration(seconds: 3),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snack);
                            Navigator.of(context).pop();
                          }
                        }
                      },
                      child: const Text("Create Blog"),
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
