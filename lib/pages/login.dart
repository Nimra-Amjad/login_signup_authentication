// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_field, prefer_const_literals_to_create_immutables, unnecessary_string_escapes, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myownapp/pages/home.dart';
import 'package:myownapp/pages/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailtextcontroller = TextEditingController();
  TextEditingController _passwordtextcontroller = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var email = "";
  var password = "";

  userLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailtextcontroller.text,
          password: _passwordtextcontroller.text);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Something went wrong",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _emailtextcontroller.dispose();
    _passwordtextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            "assets/login.png",
            width: MediaQuery.of(context).size.width,
            height: 300,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "User Login",
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
            "Hey, Enter your details to get login to your account",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 204, 204, 208),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: TextFormField(
                      onSaved: (newValue) {
                        _emailtextcontroller.text = newValue!;
                      },
                      controller: _emailtextcontroller,
                      cursorColor: Color.fromARGB(255, 36, 22, 222),
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Color.fromARGB(255, 240, 240, 240),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
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
                      onSaved: (newValue) {
                        _passwordtextcontroller.text = newValue!;
                      },
                      controller: _passwordtextcontroller,
                      obscureText: true,
                      cursorColor: Color.fromARGB(255, 36, 22, 222),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Color.fromARGB(255, 240, 240, 240),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240))),
                        focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 36, 22, 222),
                            )),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: Container()),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, right: 20.0),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot password?",
                            style: TextStyle(
                              color: Color.fromARGB(255, 36, 22, 222),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "__ Or Sign in with __ ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 204, 204, 208),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 50,
                        height: 40,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 240, 240, 240),
                              foregroundColor: Color.fromARGB(255, 36, 22, 222),
                              padding: const EdgeInsets.all(16.0),
                              textStyle: const TextStyle(fontSize: 15),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {},
                          child: Image.asset(
                            "assets/google.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SizedBox(
                            width: 50,
                            height: 40,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 240, 240, 240),
                                  foregroundColor:
                                      Color.fromARGB(255, 36, 22, 222),
                                  padding: const EdgeInsets.all(16.0),
                                  textStyle: const TextStyle(fontSize: 15),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () {},
                              child: Image.asset(
                                "assets/facebook.png",
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SizedBox(
                          width: 50,
                          height: 40,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 240, 240, 240),
                                foregroundColor:
                                    Color.fromARGB(255, 36, 22, 222),
                                padding: const EdgeInsets.all(16.0),
                                textStyle: const TextStyle(fontSize: 15),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {},
                            child: Image.asset(
                              "assets/twitter.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Color.fromARGB(255, 36, 22, 222),
                            padding: const EdgeInsets.all(16.0),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = _emailtextcontroller.text;
                              password = _passwordtextcontroller.text;
                            });
                            userLogin();
                          }
                        },
                        child: Text('Login'),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don\'t have an account?",
                        style: TextStyle(
                          color: Color.fromARGB(255, 204, 204, 208),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => Signup()));
                        },
                        child: Text(
                          "Create",
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
}
