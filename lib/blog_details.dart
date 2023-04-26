import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
