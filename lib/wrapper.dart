import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pengiriman_barang/landingpage.dart';
import 'package:pengiriman_barang/login.dart';
import 'package:pengiriman_barang/mainpage.dart';

class MyWrapper extends StatelessWidget {
  const MyWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return MyMainPage();
        }else{
          return MyLandingPage();
        }
      });
  }