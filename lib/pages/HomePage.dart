import 'dart:convert';

import 'package:blog_app/components/PostCard.dart';
import 'package:blog_app/pages/CreatePost.dart';
import 'package:blog_app/pages/Post.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/data/Api.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var posts = [];

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    var data = await Api.getData();
    setState(() {
      posts = data.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text('MyBlog'),
      ),
      body: posts.length > 0
          ? ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    var res = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Post(
                            post: posts[index],
                          );
                        },
                      ),
                    );
                    if (res == 'success') {
                      setState(() {
                        posts.removeAt(index);
                      });
                    } else if (res == 'failed') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Something went wrong your post can not be deleted'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: PostCard(
                    post: posts[index],
                  ),
                );
              },
            )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () async {
          var res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CreatePost();
              },
            ),
          );
          if (res !=null && res.statusCode == 200) {
            var data = jsonDecode(res.body);
            setState(() {
              posts.insert(0, data);
            });
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
