// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, use_build_context_synchronously, avoid_returning_null_for_void, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:myownapp/imageupload/image_upload.dart';
import 'package:myownapp/imageupload/show_images.dart';
import 'package:myownapp/model/user_model.dart';
import 'package:myownapp/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedinuser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then(
      (value) {
        this.loggedinuser = UserModel.fromMap(value.data());
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Text(
                  "Welcome Back",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${loggedinuser.name}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "${loggedinuser.email}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Text(
                  "${loggedinuser.uid}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ImageUpload()));
                    },
                    child: Text("Upload Image")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ShowImage()));
                    },
                    child: Text("Show Image"))
              ],
            ),
          ),
        ));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => LoginPage())));
  }

  _appBar() {
    //getting the size of our appbar
    final appbarheight = AppBar().preferredSize.height;
    return PreferredSize(
        child: AppBar(
          title: Text("Profile"),
          actions: [
            IconButton(
                onPressed: () {
                  logout(context);
                },
                icon: Icon(Icons.logout))
          ],
        ),
        preferredSize: Size.fromHeight(appbarheight));
  }
}
