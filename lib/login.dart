import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pengiriman_barang/mainpage.dart';
import 'package:pengiriman_barang/register.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MyLogin extends StatelessWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing Page Pengiriman Barang',
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(255, 255, 46, 31))),
      home: MyLoginPage(key: key),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  VideoPlayerController _controller =
      VideoPlayerController.asset("videos/latarVid.mp4");

  
  //final alovelaceDocumentRef = db.collection("users").doc("alovelace");

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
TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");

    

    void validasi(){
      var nama = users.doc("nama").get();
      print(nama);
    }
    

    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
          body: Stack(
        children: <Widget>[
          latarVideo(context),
          Center(
            child: Container(
              height: tinggi - 370,
              width: lebar - 100,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Column(
                children: <Widget>[
                  Text("Login",
                      style: TextStyle(
                          fontFamily: "BreadleySansRegular", fontSize: 40)),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 30,
                    width: 220,
                    child: TextField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
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
                  Container(
                    height: 30,
                    width: 220,
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
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
                        backgroundColor: Color.fromARGB(255, 219, 135, 135),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        signIn();
                        // validasi();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => MyMainPage()),
                        // );
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          color: Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 40,
                    width: 220,
                    child: Row(
                      children: <Widget>[
                        Spacer(
                          flex: 1,
                        ),
                        Text("Belum punya akun ?"),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyRegisterPage()),
                            );
                          },
                          child: Text(
                            "Daftar",
                            style: TextStyle(
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                          ),
                        ),
                        Spacer(
                          flex: 1,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(), 
      password: passwordController.text.trim(),
      ).catchError((onError)=>print("$onError"));
    
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
