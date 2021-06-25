import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blog_app/data/Api.dart';

class CreatePost extends StatefulWidget {
  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  clearFormData() {
    formData['title'] = '';
    formData['description'] = '';
    formData['img'] = '';
    formData['category'] = '';
  }

  Map formData = {
    'title': '',
    'description': '',
    'img': '',
    'date': '',
    'category': ''
  };

  bool isAdding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create new post'),
        backgroundColor: Colors.blueGrey,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SvgPicture.asset(
                'assets/undraw_Content_re_33px.svg',
                height: 150,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Title is required';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        formData['title'] = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter title here', labelText: 'Title'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Description is required';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        formData['description'] = value;
                      },
                      maxLines: 5,
                      decoration: InputDecoration(
                          hintText: 'Enter description here',
                          labelText: 'Description'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Image path is required';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        formData['img'] = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter image path here',
                          labelText: 'Image Path'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Category is required';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        formData['category'] = value;
                      },
                      decoration: InputDecoration(
                          hintText: 'Enter category here',
                          labelText: 'Category'),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isAdding = true;
                          });
                          if (_formKey.currentState!.validate()) {
                            try {
                              var response = await Api.addPost(formData);
                              if (response.statusCode == 200) {
                                clearFormData();
                                Navigator.pop(context, response);
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                          setState(() {
                            isAdding = false;
                          });
                        },
                        style:
                            ElevatedButton.styleFrom(primary: Colors.blueGrey),
                        child: isAdding
                            ? CircularProgressIndicator()
                            : Text('Add Post'),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
