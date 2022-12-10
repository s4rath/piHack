import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class Controller extends GetxController{
  final user = FirebaseAuth.instance.currentUser!.photoURL.obs;
}