import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pengiriman_barang/editprofile.dart';
import 'package:pengiriman_barang/landingpage.dart';
import 'package:pengiriman_barang/login.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyProfilePage(),
    );
  }
}

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

enum Gender { LakiLaki, Perempuan }

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    final user = FirebaseAuth.instance.currentUser!;

    void deleteUserAccount(String email, String pass) async {
      FirebaseAuth _auth = FirebaseAuth.instance;
      User user = await _auth.currentUser!;
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: pass);
      users.doc(user.uid).delete();

      await user.reauthenticateWithCredential(credential).then((value) {
        value.user!.delete().then((res) {
          Get.offAll(MyLoginPage());
          Get.snackbar("Akun Telah Dihapus", "Success");
        });
      }).catchError((onError) => Get.snackbar("Credential Error", "Failed"));
    }

    return Scaffold(
      body: Stack(
        children: [
          latar(context),
          StreamBuilder<DocumentSnapshot>(
            stream: users.doc(user.uid).snapshots(),
            builder: (_, snapshot) {
              return (snapshot.hasData)
                  ? isi(
                      context,
                      Text(
                        snapshot.data!.get('nama'),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        snapshot.data!.get('umur'),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        snapshot.data!.get('jenkel'),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        snapshot.data!.get('no hp'),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        snapshot.data!.get('email'),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) => deleteUserAccount(snapshot.data!.get('email'), snapshot.data!.get('password')),);
                          // users.doc(user.uid).delete();
                          
                        },
                        child: Container(
                          height: 50,
                          width: lebar - 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFF7C3E66)),
                          child: Center(
                            child: Text(
                              "DELETE THIS ACCOUNT",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Text('Loading...');
            },
          ),
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
              "PROFILE",
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

  Widget isi(BuildContext context, Widget nama, Widget umur, Widget jenkel,
      Widget noHp, Widget email, Widget delete) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    String date = "Tanggal Lahir";
    DateTime selectedDate = DateTime.now();
    Gender? _gender = Gender.LakiLaki;
    final user = FirebaseAuth.instance.currentUser!;
    final number = TextEditingController();
    return ListView(
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
                      child: Center(child: nama),
                      // TextField(
                      //   style: TextStyle(
                      //     fontSize: 18,
                      //   ),
                      //   decoration: InputDecoration(
                      //       //hintText: profil.collection(collectionPath)
                      //       ),
                      // ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      width: 220,
                      child: Center(child: umur),
                      // TextField(
                      //   decoration: new InputDecoration(
                      //       border: UnderlineInputBorder(),
                      //       hoverColor: Colors.grey,
                      //       focusColor: Colors.grey,
                      //       contentPadding: EdgeInsets.only(
                      //           left: 15, bottom: 11, top: 11, right: 15),
                      //       //hintText: "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                      //       labelText: date),
                      //   readOnly: true,
                      //   onTap: () async {
                      //     DateTime? selected = await showDatePicker(
                      //       context: context,
                      //       initialDate: selectedDate,
                      //       firstDate: DateTime(2010),
                      //       lastDate: DateTime(2025),
                      //     );
                      //     if (selected != null && selected != selectedDate)
                      //       setState(() {
                      //         selectedDate = selected;
                      //         date =
                      //             "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
                      //       });
                      //   },
                      // ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 240,
                      child: Center(child: jenkel),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // ListTile(
                    //   title: const Text('Laki - Laki'),
                    //   leading: Radio<Gender>(
                    //     value: Gender.LakiLaki,
                    //     groupValue: _gender,
                    //     onChanged: (Gender? value) {
                    //       setState(() {
                    //         _gender = value;
                    //       });
                    //     },
                    //   ),
                    // ),
                    // ListTile(
                    //   title: const Text('Perempuan'),
                    //   leading: Radio<Gender>(
                    //     value: Gender.Perempuan,
                    //     groupValue: _gender,
                    //     onChanged: (Gender? value) {
                    //       setState(() {
                    //         _gender = value;
                    //       });
                    //     },
                    //   ),
                    // ),
                    Container(
                      height: 30,
                      width: 220,
                      child: Center(child: noHp),
                      // TextField(
                      //   controller: number,
                      //   decoration: new InputDecoration(
                      //       border: UnderlineInputBorder(),
                      //       hoverColor: Colors.grey,
                      //       focusColor: Colors.grey,
                      //       contentPadding: EdgeInsets.only(
                      //           left: 15, bottom: 11, top: 11, right: 15),
                      //       hintText: 'No Hp'),
                      //   keyboardType: TextInputType.number,
                      //   inputFormatters: <TextInputFormatter>[
                      //     FilteringTextInputFormatter.digitsOnly
                      //   ],
                      // ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 30,
                      width: 220,
                      child: Center(child: email),
                      // TextField(
                      //   decoration: new InputDecoration(
                      //       border: UnderlineInputBorder(),
                      //       hoverColor: Colors.grey,
                      //       focusColor: Colors.grey,
                      //       contentPadding: EdgeInsets.only(
                      //           left: 15, bottom: 11, top: 11, right: 15),
                      //       hintText: 'Email'),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyEditProfilePage(),
                  ),
                );
              },
              child: Container(
                  height: 50,
                  width: lebar - 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFFA5BECC)),
                  child: Center(
                    child: Text(
                      "EDIT PROFILE",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                  // Row(
                  //   children: <Widget>[

                  //   ],
                  // ),
                  ),
            ),
            SizedBox(
              height: 10,
            ),
            delete,
          ],
        ),
      ],
    );
  }
}
