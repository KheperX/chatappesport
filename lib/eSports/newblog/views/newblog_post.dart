import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:app/eSports/newblog/models/blog_post_model.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

class BlogPostWidget extends StatefulWidget {
  const BlogPostWidget({super.key});

  @override
  State<BlogPostWidget> createState() => _BlogPostWidgetState();
}

class _BlogPostWidgetState extends State<BlogPostWidget> {
  List<BlogPost> blogPosts = [
    BlogPost(
        title: "My First Blog Post",
        content: "This is the content of my first blog post.",
        image: Image.asset('images/Cypher.jpg')),
    BlogPost(
        title: "My Second Blog Post",
        content: "This is the content of my second blog post.",
        image: Image.asset('images/BTier.jpg')),
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  Future<String?> _showTextInputDialog(
      BuildContext context, String title, String initialValue) async {
    String? result;
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        final textController = TextEditingController(text: initialValue);
        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                result = textController.text;
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
    return result;
  }

  Future<File?> _showImagePickerDialog(BuildContext context) async {
    final picker = ImagePicker();
    final image = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select an image"),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () async {
                  final pickedImage =
                      await picker.getImage(source: ImageSource.camera);
                  Navigator.pop(context, pickedImage?.path);
                },
              ),
              IconButton(
                icon: Icon(Icons.photo_library),
                onPressed: () async {
                  final pickedImage =
                      await picker.getImage(source: ImageSource.gallery);
                  Navigator.pop(context, pickedImage?.path);
                },
              ),
            ],
          ),
        );
      },
    );
    if (image == null) {
      return null;
    } else {
      return File(image);
    }
  }

  void _addBlogPost(BuildContext context) async {
    final title = await _showTextInputDialog(context, "Enter blog title:", "");
    final content =
        await _showTextInputDialog(context, "Enter blog content:", "");
    final image = await _showImagePickerDialog(context);

    if (title != null && content != null) {
      setState(() {
        blogPosts.add(
          BlogPost(
            title: title,
            content: content,
            image: image != null
                ? Image.file(image)
                : Image.asset('assets/images/default-image.jpg'),
          ),
        );
      });
    }
  }

  void _editBlogPost(BuildContext context, int index) async {
    final title = await _showTextInputDialog(
        context, "Enter updated blog title:", blogPosts[index].title);
    final content = await _showTextInputDialog(
        context, "Enter updated blog content:", blogPosts[index].content);
    final image = await _showImagePickerDialog(context);

    setState(() {
      blogPosts[index] = BlogPost(
        title: title!,
        content: content!,
        image: image == null ? blogPosts[index].image : Image.file(image),
      );
    });
  }

  void _deleteBlogPost(BuildContext context, int index) {
    setState(() {
      blogPosts.removeAt(index);
    });
  }

//connects to firebase

  // FirebaseService firebaseService = FirebaseService();

  // void addBlogPost(String title, String content, String imageUrl) async {
  //   await firebaseService.addBlogPost(title, content, imageUrl);
  // }

  // void updateBlogPost(
  //     String postId, String title, String content, String imageUrl) async {
  //   await firebaseService.updateBlogPost(postId, title, content, imageUrl);
  // }

  // void deleteBlogPost(String postId) async {
  //   await firebaseService.deleteBlogPost(postId);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blog Posts"),
      ),
      body: ListView.builder(
        itemCount: blogPosts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: blogPosts[index].image,
                  title: Text(blogPosts[index].title),
                  subtitle: Text(blogPosts[index].content),
                ),
                ButtonBar(
                  children: <Widget>[
                    TextButton(
                      child: const Text('EDIT'),
                      onPressed: () {
                        _editBlogPost(context, index);
                      },
                    ),
                    TextButton(
                      child: const Text('DELETE'),
                      onPressed: () {
                        _deleteBlogPost(context, index);
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }, // <-- Closing parentheses for itemBuilder
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addBlogPost(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class FirebaseService {
  final databaseRef = FirebaseDatabase.instance.reference();

  // Add new blog post
  Future<void> addBlogPost(
      String title, String content, String imageUrl) async {
    final newPostRef = databaseRef.child('esports/blog_posts').push();
    await newPostRef.set({
      'title': title,
      'content': content,
      'image': imageUrl,
    });
  }

  // Update existing blog post
  Future<void> updateBlogPost(
      String postId, String title, String content, String imageUrl) async {
    final postRef = databaseRef.child('esports/blog_posts/$postId');
    await postRef.update({
      'title': title,
      'content': content,
      'image': imageUrl,
    });
  }

  // Delete a blog post
  Future<void> deleteBlogPost(String postId) async {
    final postRef = databaseRef.child('esports/blog_posts/$postId');
    await postRef.remove();
  }
}
