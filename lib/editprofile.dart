import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyEditProfile extends StatelessWidget {
  const MyEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyEditProfilePage(),
    );
  }
}

class MyEditProfilePage extends StatefulWidget {
  const MyEditProfilePage({Key? key}) : super(key: key);

  @override
  State<MyEditProfilePage> createState() => _MyProfilePageState();
}

enum Gender { LakiLaki, Perempuan }

class _MyProfilePageState extends State<MyEditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          latar(context),
          isi(context),
          apbar(context),
        ],
      ),
    );
  }

  Widget latar(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Container(
      height: tinggi,
      width: lebar,
      color: Color(0xFFF2EBE9),
    );
  }

  Widget apbar(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Positioned(
      top: 23,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: lebar / 6,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage(
                    "assets/back.png",
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: lebar / 1.5,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Color(0xFF243A73),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
            ),
            child: Text(
              "EDIT PROFILE",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                fontFamily: "MetropolisPersonalUseRegular",
                color: Color(0xFFF2EBE9),
              ),
            ),
          ),
          Container(
            height: 30,
            width: lebar / 6,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage(
                  "assets/menu.png",
                ),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usrnmController = TextEditingController();
  TextEditingController pswrdController = TextEditingController();
  TextEditingController nohpController = TextEditingController();
  String date = "Tanggal Lahir";
  DateTime selectedDate = DateTime.now();
  Gender? _gender = Gender.LakiLaki;
  String jenkel(Gender gender) {
    if (gender == Gender.LakiLaki) {
      return "Laki-laki";
    } else {
      return "Perempuan";
    }
  }

  Widget isi(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    final user = FirebaseAuth.instance.currentUser!;
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;

    return StreamBuilder<DocumentSnapshot>(
      stream: users.doc(user.uid).snapshots(),
      builder: (_, snapshot) {
        return (snapshot.hasData)
            ? ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          top: 90,
                          left: 20,
                          right: 20,
                        ),
                        child: Container(
                          height: tinggi - 300,
                          width: lebar - 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xFF243A73).withOpacity(0.4),
                          ),
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 130,
                                width: 130,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage("assets/fotop.jpg"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 240,
                                child: TextField(
                                  controller: namaController,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: snapshot.data!.get('nama'),
                                  ),
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
                                          left: 15,
                                          bottom: 11,
                                          top: 11,
                                          right: 15),
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
                                    if (selected != null &&
                                        selected != selectedDate)
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
                              // TextField(
                              //   controller: nohpController,
                              //   decoration: new InputDecoration(
                              //     border: UnderlineInputBorder(),
                              //     hoverColor: Colors.grey,
                              //     focusColor: Colors.grey,
                              //     contentPadding: EdgeInsets.only(
                              //         left: 15, bottom: 11, top: 11, right: 15),
                              //     hintText: 'No Hp',
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Container(
                              //   width: 240,
                              //   child: TextField(
                              //     controller: emailController,
                              //     style: TextStyle(
                              //       fontSize: 18,
                              //     ),
                              //     decoration: InputDecoration(
                              //       hintText: snapshot.data!.get('nama'),
                              //     ),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              // Container(
                              //   width: 240,
                              //   child: TextField(
                              //     controller: namaController,
                              //     style: TextStyle(
                              //       fontSize: 18,
                              //     ),
                              //     decoration: InputDecoration(
                              //       hintText: snapshot.data!.get('nama'),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          users
                              .doc(user.uid)
                              .update({"nama": namaController.text});
                          users.doc(user.uid).update({"umur":date});
                          users.doc(user.uid).update({"jenkel":jenkel(_gender!)});
                          users.doc(user.uid).update({"noHp":nohpController.text});
                          Navigator.pop(context);
                        },
                        child: Container(
                            height: 50,
                            width: lebar - 40,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xFFA5BECC)),
                            child: Center(
                              child: Text(
                                "DONE",
                                style: TextStyle(fontSize: 18),
                              ),
                            )
                            ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          height: 50,
                          width: lebar - 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFF7C3E66)),
                          child: Center(
                            child: Text(
                              "CANCEL",
                              style: TextStyle(fontSize: 18),
                            ),
                          )
                          // Row(
                          //   children: <Widget>[

                          //   ],
                          // ),
                          ),
                    ],
                  ),
                ],
              )
            : Text('Loading...');
      },
    );
  }
}
