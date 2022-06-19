import 'package:flutter/material.dart';
import 'package:pengiriman_barang/formpage.dart';
import 'package:pengiriman_barang/historypage.dart';
import 'package:pengiriman_barang/landingpage.dart';
import 'package:pengiriman_barang/login.dart';
import 'package:pengiriman_barang/mainpage.dart';
import 'package:pengiriman_barang/package1.dart';
import 'package:pengiriman_barang/profilepage.dart';
import 'package:pengiriman_barang/register.dart';
import 'package:pengiriman_barang/tes.dart';
import 'package:pengiriman_barang/trackingpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pengiriman_barang/wrapper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyWrapper(),
    );
  }
}
