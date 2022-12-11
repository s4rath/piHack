import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:the_app/components/expandablefab.dart';
import 'package:the_app/login/loginp.dart';
import 'package:the_app/screens/posts.dart';
import '../../services/firebase_services.dart';
import '../controller/getC.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final db = FirebaseFirestore.instance;
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
      final user= FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SliderDrawer(
          appBar: SliderAppBar(
              appBarHeight: 75,
              appBarColor: Colors.greenAccent,
              title: Text('Home',
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w700))),
          key: _sliderDrawerKey,
          sliderOpenSize: 179,
          slider: _SliderView(
            onItemClick: (title) {
              _sliderDrawerKey.currentState!.closeSlider();
            },
          ),
          child: Container()
          // StreamBuilder<QuerySnapshot>(
          //   stream: FirebaseFirestore.instance.collection("posts").snapshots(),
          //   builder: ((BuildContext context,AsyncSnapshot snapshot) {
          //     if(!snapshot.hasData){
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return Container(
          //       child: ListView(
          //         children: try(snapshot.data.docs.map),
          //       ).toList(),
          //     );
              // else{
              //     children: snapshot.data!.docs.map((doc) {
              //   return Card(
              //     child: ListTile(
              //       title: Text(doc.data().toString()),
              //     ),
              //   );
              // }).toList();
            
              // }
              // return Column();
          //   }
          //   ),
          // )
          // Container(
          //   color: Colors.amber,
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   child: Text('Container'),
          // )

          ),
           
          floatingActionButton: ExpandableFab(
          // ignore: sort_child_properties_last
          children: [
            ActionButton(
                icon: Icon(Icons.smart_toy_outlined),
                onPressed: () async {
                  
                 
          }

                 
                ),
            ActionButton(
              icon: Icon(Icons.psychology_outlined),
              onPressed: () async {
                
                // List<File> _imageList;
                // gallery = _imageList.map<File>((Xfile) => File(Xfile.path)).cast<d.XFile>().toList();
                // Navigator.push(context,MaterialPageRoute(builder: (context) => FileView(imgObjs: gallery)));
              },
            )
          ],
          distance: 112,
        ),
    );
  }
}

class _SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: ListView(
        children: <Widget>[
          const SizedBox(
            height: 30,
          ),
          CircleAvatar(
            radius: 65,
            backgroundColor: Colors.grey,
            child: CircleAvatar(
              radius: 60,
              backgroundImage:Image.network((FirebaseAuth.instance.currentUser!.photoURL)!).image,
                  
            ),
          ),
          const SizedBox(
            height: 20,
          ),
           Text(
            (FirebaseAuth.instance.currentUser!.displayName!),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
              title: Text('Home',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.home, color: Colors.black),
              onTap: () => null),
          ListTile(
              title: Text('Add Post',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.add_circle, color: Colors.black),
              onTap: () => Get.to(Posts())),
          ListTile(
              title: Text('Notification',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.notifications_active, color: Colors.black),
              onTap: () => null),
          // ListTile(
          //     title: Text('Likes',
          //         style: const TextStyle(
          //             color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
          //     leading: Icon(Icons.favorite, color: Colors.black),
          //     onTap: () => null),
          // ListTile(
          //     title: Text('Setting',
          //         style: const TextStyle(
          //             color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
          //     leading: Icon(Icons.settings, color: Colors.black),
          //     onTap: () => null),
          ListTile(
              title: Text('LogOut',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.arrow_back_ios, color: Colors.black),
              onTap: () => {
                FirebaseAuth.instance.signOut().then((value) => {
                  Get.to(LoginScreen())
                })
              }),
          
        ],
      ),
    );
  }
}

 