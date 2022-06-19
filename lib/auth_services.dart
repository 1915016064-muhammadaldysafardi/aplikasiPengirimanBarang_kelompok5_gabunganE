import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices{
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future signInAnonymous() async{
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? firebaseUser = result.user;

      return firebaseUser;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  static Future<void> signOut()async{
    _auth.signOut();
  }

  static Stream<User?> get firebaseUserStream => _auth.authStateChanges();
}