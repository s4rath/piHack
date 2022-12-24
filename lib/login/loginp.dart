import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_app/login/doclogin.dart';
import 'package:file_picker/file_picker.dart';
import '../screens/user/home.dart';
import '../services/firebase_services.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final TextEditingController _email = TextEditingController();
  // final TextEditingController _password = TextEditingController();
  // final TextEditingController _textFieldController = TextEditingController();
  // final List toklist = [
  //   'CMPTmLrgfYC',
  //   'GK73YKE2XD',
  //   'kfcVXjcFkvNQQ',
  //   'eVhdeHqUrM'
  // ];
  

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
          Center(
            child: Text(
              'UMatter',
              style: TextStyle(
                color: Colors.black,
                fontSize: 50,
                fontWeight: FontWeight.w500,
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
                      const SizedBox(height: 35),
                      const Center(
                        child: Text(
                          '- Login -',
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
                              child: Image.asset('images/user.png'),
                            ),
                          ),
                          SizedBox(width: 90),
                          GestureDetector(
                            onTap: () {
                              Get.to(DocLogin());
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white38,
                              ),
                              child: Image.asset('images/doctor.png'),
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
