import 'dart:convert';
import 'package:blog_post/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BlogProvider extends ChangeNotifier {
  bool isLoading = true;
  List fetchedBlogs = [];

  createBlog(String title, String description) async {
    var response = await http.post(
      Uri.parse("https://crudapi.co.uk/api/v1/Blog"),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer 2AVcwvs1FFjxIIqghRiq-DRkiFl0eJJCX9RXp8Xeibq0PgEpkw"
      },
      body: jsonEncode([
        {
          "title": title,
          "description": description,
          "userId": userId,
        }
      ]),
    );
    notifyListeners();
    return response;
  }

  fetchBlogs() async {
    var response = await http.get(
      Uri.parse("https://crudapi.co.uk/api/v1/Blog"),
      headers: {
        "Content-Type": "application/json",
        "Authorization":
            "Bearer 2AVcwvs1FFjxIIqghRiq-DRkiFl0eJJCX9RXp8Xeibq0PgEpkw"
      },
    );
    var data = jsonDecode(response.body);
    fetchedBlogs = data["items"];
    isLoading = false;
    notifyListeners();
  }
}
