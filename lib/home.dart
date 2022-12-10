import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:get/get.dart';
import 'package:the_app/login/loginp.dart';
import '../services/firebase_services.dart';
import 'controller/getC.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

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
          child: Container(
            color: Colors.amber,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Text('Container'),
          )),
    );
  }
}

class _SliderView extends StatelessWidget {
  final Function(String)? onItemClick;

  const _SliderView({Key? key, this.onItemClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    print("user url-----------------${c.user}");
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
              backgroundImage:Image.asset('images/blank_profile.jpg').image,
              //  Image.network(
              //         'https://nikhilvadoliya.github.io/assets/images/nikhil_1.webp')
              //     .image
                  
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Nick',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 30,
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
              onTap: () => null),
          ListTile(
              title: Text('Notification',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.notifications_active, color: Colors.black),
              onTap: () => null),
          ListTile(
              title: Text('Likes',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.favorite, color: Colors.black),
              onTap: () => null),
          ListTile(
              title: Text('Setting',
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'BalsamiqSans_Regular')),
              leading: Icon(Icons.settings, color: Colors.black),
              onTap: () => null),
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

 