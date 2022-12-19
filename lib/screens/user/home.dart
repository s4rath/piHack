import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:the_app/components/expandablefab.dart';
import 'package:the_app/login/loginp.dart';
import 'package:the_app/screens/chat.dart';
import 'package:the_app/screens/user/allproblm.dart';
import 'package:the_app/screens/user/posts.dart';
import 'package:the_app/screens/user/problems.dart';
import '../../services/firebase_services.dart';


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    setState(() {
      
    });
    // TODO: implement initState
    super.initState();
  }
  final db = FirebaseFirestore.instance;

  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  final user = FirebaseAuth.instance.currentUser;

  late CollectionReference _referencePosts;

  late Future<QuerySnapshot> _future;

  @override
  Widget build(BuildContext context) {
    _referencePosts = FirebaseFirestore.instance.collection('posts');
    _future = _referencePosts.get();

    return Scaffold(
      body: SliderDrawer(
        appBar: SliderAppBar(
            appBarHeight: 90,
            appBarColor: Colors.greenAccent,
            title: Text('Home',
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.w700))
                    ),
              
        key: _sliderDrawerKey,
        sliderOpenSize: 179,
        slider: _SliderView(
          onItemClick: (title) {
            _sliderDrawerKey.currentState!.closeSlider();
          },
        ),
        child: Container(
          color: Colors.grey,
          child: Column(
            children: [
              Container(child: Center(child: Text('Success Stories')),height: 30),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error:${snapshot.error}'));
                    }
              
                    if (snapshot.hasData) {
                      QuerySnapshot data = snapshot.data!;
                      List<QueryDocumentSnapshot> documents = data.docs;
                      List<Map> items =
                          documents.map((e) => {'content': e['content']}).toList();
              
                      return ListView.builder(
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            Map thisItem = items[index] as Map;
                            return Card(
                              shadowColor: Colors.grey,
                                child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25,
                                          backgroundImage: AssetImage('images/blank_profile.jpg'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width - 90,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text('unknown'),
                                                    // Text(
                                                    //   'innala raavile'
                                                    //   ' •🌎',
                                                    //   style: TextStyle(
                                                    //       color: Colors.grey[700]),
                                                    // )
                                                  ],
                                                ),
                                                // IconButton(
                                                //     onPressed: () => print('menu'),
                                                //     icon:
                                                //         const Icon(Icons.more_horiz))
                                              ]),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 15),
                                    child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: Text(thisItem['content'])),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // if (posts[index].imageUrl != null)
                                  //   Image.network(
                                  //     height: 300,
                                  //     width: MediaQuery.of(context).size.width,
                                  //     posts[index].imageUrl!,
                                  //     fit: BoxFit.cover,
                                  //   ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 10, top: 5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                              ),
                                              child: const Icon(
                                                Icons.thumb_up_sharp,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text("0"),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            // Text(
                                            //     '67'),
                                            const SizedBox(width: 10),
                                            // Text(
                                            //     '{posts[index].shares.toString()} shares'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () => print('like'),
                                            icon: const Icon(Icons.thumb_up_outlined),
                                          ),
                                          const Text('Like')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.messenger_outline),
                                            onPressed: () => print('comments'),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          const Text('comments'),
                                        ],
                                      ),
                                      // Row(
                                      //   children: [
                                      //     IconButton(
                                      //       onPressed: () => print('Share'),
                                      //       icon: const Icon(Icons.share),
                                      //     ),
                                      //     const Text('Share')
                                      //   ],
                                      // )
                                    ],
                                  )
                                ],
                              ),
                            )
                            );
                            // Card(
                            //   child: ListTile(
              
                            //     onTap: (){
                            //       // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Detail(thisItem)));
                            //     },
                            //     title: Text(thisItem['content']),),
                            // );
                          });
                    }
              
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        // ignore: sort_child_properties_last
        children: [
          ActionButton(
              icon: Icon(Icons.smart_toy_outlined),
              onPressed: () async {
                Get.to(Chat());
              }),
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
              backgroundImage:
                  Image.network((FirebaseAuth.instance.currentUser!.photoURL)!)
                      .image,
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
              title: Text('Success Story',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.mood, color: Colors.black),
              onTap: () => Get.to(Posts())),
          ListTile(
              title: Text('Difficulties',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.add_circle, color: Colors.black),
              onTap: () => Get.to(Problm())),
          ListTile(
              title: Text('Tough Feelings',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.mood_bad, color: Colors.black),
              onTap: () => Get.to(AllPrblm())),
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
                    FirebaseAuth.instance
                        .signOut()
                        .then((value) => {Get.to(LoginScreen())})
                  }),
        ],
      ),
    );
  }
}
