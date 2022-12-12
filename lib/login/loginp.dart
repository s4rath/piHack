import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/home.dart';
import '../services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _textFieldController = TextEditingController();
  final List toklist = [
    'CMPTmLrgfYC',
    'GK73YKE2XD',
    'kfcVXjcFkvNQQ',
    'eVhdeHqUrM'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 3,
              child: Image.asset('images/umatterlogo.png'),
            ),
          ),
          Center(child: Text('UMatter',style: TextStyle(fontSize: 20),),),
          Center(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Click here to '),
                  Container(
                    color: Colors.black,
                    child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Token ID'),
                                  content: TextField(
                                    //  onChanged: (value) {
                                    //    setState(() {
                                    //      valueText = value;
                                    //    });
                                    //  },
                                    controller: _textFieldController,
                                    decoration: InputDecoration(
                                        hintText: "Enter your Token ID.."),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      //  color: Colors.black,
                                      //  textColor: Colors.white,
                                      child: Text('OK'),
                                      onPressed: () async {
                                        var myListFiltered = toklist.where((e) =>
                                            e == _textFieldController.text);
                                        if (myListFiltered.length > 0) {
                                          await FirebaseServices()
                                              .signInWithGoogle('counselor');
                                          Get.to(HomePage());
                                          // Do stuff with myListFiltered.first
                                        } else {
                                          Get.to(LoginScreen());
                                          Get.snackbar('TokenID Error',
                                              'Please enter correct ID');
                                          // Element is not found
                                        }

                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                );
                              });
                        },
                        child: Container(child: Text('Doctors'),color: Colors.black,)),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const Text(
                      //   'Email',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: Colors.black,
                      //   ),
                      //   child: TextFormField(
                      //     controller: _email,
                      //     style: TextStyle(color: Colors.white),
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       prefixIcon: Icon(
                      //         Icons.email,
                      //         color: Colors.white,
                      //       ),
                      //       hintText: 'Email',
                      //       hintStyle: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 15),
                      // const Text(
                      //   'Password',
                      //   style: TextStyle(
                      //     color: Colors.black,
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 15),
                      // Container(
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(12),
                      //     color: Colors.black,
                      //   ),
                      //   child: TextFormField(
                      //     controller: _password,
                      //     style: TextStyle(color: Colors.white),
                      //     decoration: InputDecoration(
                      //       border: InputBorder.none,
                      //       prefixIcon: Icon(
                      //         Icons.lock,
                      //         color: Colors.white,
                      //       ),
                      //       hintText: 'Password',
                      //       hintStyle: TextStyle(color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(height: 35),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => HomePage()));
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(30),
                      //       color: Colors.black,
                      //     ),
                      //     child: const Center(
                      //       child: Padding(
                      //         padding: EdgeInsets.all(10.0),
                      //         child: Text(
                      //           ' Log In',
                      //           style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 30,
                      //             fontWeight: FontWeight.w500,
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          '- Sign In with Google -',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await FirebaseServices().signInWithGoogle('user');
                              Get.to(HomePage());
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white38,
                              ),
                              child: Image.asset('images/google.png'),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
