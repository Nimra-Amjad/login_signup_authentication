// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
//image picker for picking the image
//firebase storage for uploading the image to firebase storage
//cloud firestore for saving the url for uploaded image to our application
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({super.key});

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  //some initialization code
  AssetImage? _image;
  final imagepicker = ImagePicker();

  //image picker
  Future imagepickerMethod() async {
    // picking the file
    final pick = await imagepicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _image = AssetImage(pick.path);
      } else {
        //showing a snackbar with error
        showSnackBar("No file selected", Duration(milliseconds: 400));
      }
    });
  }

  //snackbar for showing errors
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Upload"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          //for round rectangle clip
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: SizedBox(
              height: 550,
              width: double.infinity,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text("Upload Image"),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 320,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.red,
                          )),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: _image == null
                                    ? Center(
                                        child: Text("No image selected"),
                                      )
                                    : Image.asset("$_image")),
                            ElevatedButton(
                                onPressed: () {
                                  imagepickerMethod();
                                },
                                child: Text("Select Image")),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text("Upload Image")),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
