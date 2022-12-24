import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

  signInWithGoogle(String role) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount!= null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential =GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        await _auth.signInWithCredential(authCredential).then((value) async {
          User? user = FirebaseAuth.instance.currentUser;
          FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
            'email':user.email,
            'role': role,

            

          });

        });
      }
    }on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }
    docsignInWithGoogle(String role,String imgURL) async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount!= null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential =GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        await _auth.signInWithCredential(authCredential).then((value) async {
          User? user = FirebaseAuth.instance.currentUser;
          if (imgURL!=''){
              FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
            'email':user.email,
            'role': role,
            'image': imgURL
            

          });
          

          }else{return;}
        

        });
      }
    }on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

}
