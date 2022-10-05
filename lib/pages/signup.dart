// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_final_fields, unused_field, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myownapp/model/user_model.dart';
import 'package:myownapp/pages/home.dart';
import 'package:myownapp/pages/login.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  var name = "";
  var email = "";
  var password = "";
  var confirmpassword = "";
  TextEditingController _usernamecontroller = TextEditingController();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  TextEditingController _confirmpasswordcontroller = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _checked = false;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _usernamecontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    super.dispose();
  }

  registration() async {
    if (password == confirmpassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        print(userCredential);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Registered Successfully. Please Login..",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print("Password Provided is too Weak");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          print("Account Already exists");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
            ),
          );
        }
      }
    } else {
      print("Password and Confirm Password doesn't match");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            "Password and Confirm Password doesn't match",
            style: TextStyle(fontSize: 16.0, color: Colors.black),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            "assets/signup.jpg",
            width: MediaQuery.of(context).size.width,
            height: 180,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "Create a New Account",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Color.fromARGB(255, 36, 22, 222),
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Let's get started with your 30 days free trial",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 204, 204, 208),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
              child: Column(
            key: _formkey,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _usernamecontroller,
                  cursorColor: Color.fromARGB(255, 36, 22, 222),
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 240, 240))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 36, 22, 222),
                        )),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 12, left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _emailcontroller,
                  cursorColor: Color.fromARGB(255, 36, 22, 222),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 240, 240))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 36, 22, 222),
                        )),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 12, left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _passwordcontroller,
                  obscureText: true,
                  cursorColor: Color.fromARGB(255, 36, 22, 222),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 240, 240))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 36, 22, 222),
                        )),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(top: 12, left: 20.0, right: 20.0),
                child: TextFormField(
                  controller: _passwordcontroller,
                  obscureText: true,
                  cursorColor: Color.fromARGB(255, 36, 22, 222),
                  decoration: InputDecoration(
                    hintText: 'Confirm Password',
                    filled: true,
                    fillColor: Color.fromARGB(255, 240, 240, 240),
                    border: InputBorder.none,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                            color: Color.fromARGB(255, 240, 240, 240))),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 36, 22, 222),
                        )),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CheckboxListTile(
                title:
                    Text("I agree to the Terms of Service and Privacy Policy"),
                controlAffinity: ListTileControlAffinity.leading,
                value: _checked,
                onChanged: (value) {
                  setState(() {
                    _checked = value!;
                  });
                },
                activeColor: Color.fromARGB(255, 36, 22, 222),
                checkColor: Colors.white,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color.fromARGB(255, 36, 22, 222),
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      signup(_emailcontroller.text, _passwordcontroller.text);
                      print("ok");
                      // FirebaseAuth.instance
                      //     .createUserWithEmailAndPassword(
                      //         email: _emailcontroller.text,
                      //         password: _passwordcontroller.text)
                      //     .then((value) {
                      //   print("Created new account");
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => HomePage()));
                      // }).onError((error, stackTrace) {
                      //   print('Error ${error.toString()}');
                      // });
                    },
                    child: Text('Create Account'),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color.fromARGB(255, 36, 22, 222),
                          padding: const EdgeInsets.all(16.0),
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Color.fromARGB(255, 36, 22, 222)),
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => HomePage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("assets/google.png"),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Sign up with Google'),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 204, 204, 208),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => LoginPage()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 36, 22, 222),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  void signup(String email, String password) async {
    // if (_formkey.currentState!.validate()) {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {postDetailsToFirestore()})
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
    //}
  }

  postDetailsToFirestore() async {
    //calling our firestore
    //calling our user model
    //sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    UserModel userModel = UserModel();

    //writing aa the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.name = _usernamecontroller.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :)");

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
  }
}
