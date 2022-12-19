import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:the_app/controller/getC.dart';
import 'package:the_app/screens/user/home.dart';

class Posts extends StatefulWidget {
  const Posts({super.key});

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _content = TextEditingController();
    DateTime now = DateTime.now();
    int num = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Success Stories'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 200,
            child: TextFormField(
              controller: _content,
              maxLines: 10,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Write Your Success Story...',
                fillColor: Colors.grey[300],
                filled: true,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              User? user = FirebaseAuth.instance.currentUser;
              setState(() {
                DateTime now = DateTime.now();
              });
              FirebaseFirestore.instance.collection('posts').doc('${now}').set({
                'uid': user!.uid,
                'uname': user.displayName,
                'content': _content.text,
              }).whenComplete(() {
                _content.clear();
                Get.snackbar('Posted', 'successfully posted');
              });
            },
            child: Text('Submit'),
          ),
           ElevatedButton(onPressed: (){
            Get.to(HomePage());
          }, child: Text('Home'))
        ],
      ),
    );
  }
}
