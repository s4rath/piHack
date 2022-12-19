import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AllPrblm extends StatefulWidget {
  const AllPrblm({super.key});
  

  @override
  State<AllPrblm> createState() => _AllPrblmState();
}

class _AllPrblmState extends State<AllPrblm> {
  final user = FirebaseAuth.instance.currentUser;

  late CollectionReference _referencePosts;

  late Future<QuerySnapshot> _future;
  @override
  Widget build(BuildContext context) {
    _referencePosts = FirebaseFirestore.instance.collection('Problm');
    _future = _referencePosts.get();
    return Scaffold(
      appBar: AppBar(title: Text('Problems'),),
      body: Container(
          color: Colors.grey,
          child: Column(
            children: [
              Container(child: Center(child: Text('Difficult Stories')),height: 30),
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
                                  // Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  //   children: [
                                  //     // Row(
                                  //     //   children: [
                                  //     //     IconButton(
                                  //     //       onPressed: () => print('like'),
                                  //     //       icon: const Icon(Icons.thumb_up_outlined),
                                  //     //     ),
                                  //     //     const Text('Like')
                                  //     //   ],
                                  //     // ),
                                  //     // Row(
                                  //     //   children: [
                                  //     //     IconButton(
                                  //     //       icon: const Icon(Icons.messenger_outline),
                                  //     //       onPressed: () => print('comments'),
                                  //     //     ),
                                  //     //     const SizedBox(
                                  //     //       width: 5,
                                  //     //     ),
                                  //     //     const Text('comments'),
                                  //     //   ],
                                  //     // ),
                                  //     // Row(
                                  //     //   children: [
                                  //     //     IconButton(
                                  //     //       onPressed: () => print('Share'),
                                  //     //       icon: const Icon(Icons.share),
                                  //     //     ),
                                  //     //     const Text('Share')
                                  //     //   ],
                                  //     // )
                                  //   ],
                                  // )
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
    );
  }
}