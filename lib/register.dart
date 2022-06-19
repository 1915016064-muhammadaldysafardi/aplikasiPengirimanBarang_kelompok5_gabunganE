import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pengiriman_barang/login.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MyRegister extends StatelessWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Register TIMLIMA Exspress',
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(255, 255, 46, 31))),
      home: MyRegisterPage(key: key),
    );
  }
}

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({Key? key}) : super(key: key);

  @override
  State<MyRegisterPage> createState() => _MyLoginPageState();
}

enum Gender { LakiLaki, Perempuan }

class DatabaseMethod {
  Future addUserInfoToDB(String userId, Map<String, dynamic> userInfoMap) {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  Future<DocumentSnapshot> getUserFromDB(String userId) {
    return FirebaseFirestore.instance.collection("users").doc(userId).get();
  }
}

class _MyLoginPageState extends State<MyRegisterPage> {
  VideoPlayerController _controller =
      VideoPlayerController.asset("videos/latarVid.mp4");
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController pswrdController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  String date = "Tanggal Lahir";
  DateTime selectedDate = DateTime.now();
  Gender? _gender = Gender.LakiLaki;

  FirebaseFirestore firebase = FirebaseFirestore.instance;
  //CollectionReference users = firebase.collection('users');
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    return await _auth.currentUser!;
  }

  Future<void> createUserWithEmailAndPassword(String email, String password,
      String nama, String noHp, String umur, String jenkel) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    Map<String, dynamic> userInfoMap = {
      "nama": nama,
      "umur": umur,
      "jenkel": jenkel,
      "no hp": noHp,
      "email": email,
      "password": password
    };

    if (userCredential != null) {
      DatabaseMethod().addUserInfoToDB(_auth.currentUser!.uid, userInfoMap);
    }
  }

  // static Future<SignInSignUpResult> createUser({String email, String pass}) async {
  //          try {
  //            AuthResult result = await
  //      _auth.createUserWithEmailAndPassword(email: email, password: pass);
  //            return SignInSignUpResult(user: result.user);
  //          } catch (e) {
  //            return SignInSignUpResult(message: e.toString());
  //          }
  //        }

  String jenkel(Gender gender) {
    if (gender == Gender.LakiLaki) {
      return "Laki-laki";
    } else {
      return "Perempuan";
    }
  }

  @override
  void initState() {
    super.initState();
    _controller
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;

    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          latarVideo(context),
          Center(
            child: Container(
                height: tinggi - 100,
                width: lebar - 100,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Register",
                            style: TextStyle(
                                fontFamily: "BreadleySansRegular",
                                fontSize: 40)),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 30,
                          width: 220,
                          child: TextField(
                            controller: namaController,
                            decoration: new InputDecoration(
                                border: UnderlineInputBorder(),
                                hoverColor: Colors.grey,
                                focusColor: Colors.grey,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: 'Nama'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 30,
                          width: 220,
                          child: TextField(
                            decoration: new InputDecoration(
                                border: UnderlineInputBorder(),
                                hoverColor: Colors.grey,
                                focusColor: Colors.grey,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                //hintText: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                                labelText: date),
                            readOnly: true,
                            onTap: () async {
                              DateTime? selected = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2010),
                                lastDate: DateTime(2025),
                              );
                              if (selected != null && selected != selectedDate)
                                setState(() {
                                  selectedDate = selected;
                                  date =
                                      "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                                });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Laki - Laki'),
                          leading: Radio<Gender>(
                            value: Gender.LakiLaki,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Perempuan'),
                          leading: Radio<Gender>(
                            value: Gender.Perempuan,
                            groupValue: _gender,
                            onChanged: (Gender? value) {
                              setState(() {
                                _gender = value;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 220,
                          child: TextField(
                            controller: nohpController,
                            decoration: new InputDecoration(
                                border: UnderlineInputBorder(),
                                hoverColor: Colors.grey,
                                focusColor: Colors.grey,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: 'No Hp'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 30,
                          width: 220,
                          child: TextField(
                            controller: emailController,
                            decoration: new InputDecoration(
                                border: UnderlineInputBorder(),
                                hoverColor: Colors.grey,
                                focusColor: Colors.grey,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: 'Email'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Container(
                        //   height: 30,
                        //   width: 220,
                        //   child: TextField(
                        //     controller: usrnmController,
                        //     decoration: new InputDecoration(
                        //         border: UnderlineInputBorder(),
                        //         hoverColor: Colors.grey,
                        //         focusColor: Colors.grey,
                        //         contentPadding: EdgeInsets.only(
                        //             left: 15, bottom: 11, top: 11, right: 15),
                        //         hintText: 'Username'),
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        Container(
                          height: 30,
                          width: 220,
                          child: TextField(
                            controller: pswrdController,
                            decoration: new InputDecoration(
                                border: UnderlineInputBorder(),
                                hoverColor: Colors.grey,
                                focusColor: Colors.grey,
                                contentPadding: EdgeInsets.only(
                                    left: 15, bottom: 11, top: 11, right: 15),
                                hintText: 'Password'),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 150,
                          height: 45,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 219, 135, 135),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              createUserWithEmailAndPassword(
                                emailController.text,
                                pswrdController.text,
                                namaController.text,
                                nohpController.text,
                                date,
                                jenkel(_gender!),
                              ).then((value) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MyLoginPage(),
                                    ),
                                  ));
                            },
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                )),
          )
        ],
      )),
    );
  }

  Widget latarVideo(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Container(
      height: tinggi,
      width: lebar,
      child: _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
