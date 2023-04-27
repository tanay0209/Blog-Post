import 'dart:convert';
import 'package:blog_post/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogProvider extends ChangeNotifier {
  bool isLoading = true;
  List fetchedBlogs = [];

  // API call for creating blog
  createBlog(String title, String description) async {
    var response = await http.post(
      Uri.parse("https://crudapi.co.uk/api/v1/Blog"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apikey"
      },
      body: jsonEncode([
        {
          "title": title,
          "description": description,
          "userId": FirebaseAuth.instance.currentUser?.uid,
        }
      ]),
    );
    notifyListeners();
    return response;
  }

  // API call for fetching blogs from database
  fetchBlogs() async {
    var response = await http.get(
      Uri.parse("https://crudapi.co.uk/api/v1/Blog"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apikey"
      },
    );
    var data = jsonDecode(response.body);
    fetchedBlogs = data["items"];
    isLoading = false;
    notifyListeners();
  }

  // API call to delete a blog
  deleteBlog(String uuid) async {
    var response = await http
        .delete(Uri.parse("https://crudapi.co.uk/api/v1/Blog/$uuid"), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $apikey"
    });

    notifyListeners();
    return response;
  }

  // API call to edit an exisiting blog
  editBlog(String uuid, String title, String description) async {
    var response = await http.put(
      Uri.parse("https://crudapi.co.uk/api/v1/Blog/$uuid"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apikey"
      },
      body: jsonEncode({
        "title": title,
        "description": description,
      }),
    );
    notifyListeners();
    return response;
  }
}
