import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHistory extends StatelessWidget {
  const MyHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHistoryPage(),
    );
  }
}

class MyHistoryPage extends StatefulWidget {
  const MyHistoryPage({Key? key}) : super(key: key);

  @override
  State<MyHistoryPage> createState() => _MyHistoryPageState();
}

class _MyHistoryPageState extends State<MyHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
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
              "HISTORY",
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

  Widget isi(BuildContext context) {

    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection("users");
    final user = FirebaseAuth.instance.currentUser!;
    
    
    return StreamBuilder(
        stream: users.doc(user.uid).collection("histori").snapshots(),
        builder: (context, snapshot) {
          return Column(
            children: <Widget>[
              SizedBox(
                height: 110,
              ),
              judul(context),
              SizedBox(
                height: 15,
              ),
              tombolpage(context),
              SizedBox(
                height: 15,
              ),
              Container(
                height: tinggi - 290,
                width: lebar - 30,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 3,
                    color: Color(0xFF7C3E66),
                  ),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: users.doc(user.uid).collection("histori").snapshots(),
                  builder: (_, snapshot) {
                    return (snapshot.hasData)
                        ? Column(
                            children: snapshot.data!.docs
                                .map((e) => kartu(
                                          context,
                                          e.get("no resi"),
                                          e.get("nama pengirim"),
                                          e.get("nama penerima"),
                                          e.get("alamat penerima"),
                                          e.get("kategori paket"),
                                          e.get("tanggal kirim").toDate().toString(),
                                        )
                                    // Text(
                                    //   e.get("no resi"),
                                    // ),
                                    )
                                .toList(),
                          )
                        : CircularProgressIndicator();
                  },
                  // return Column(
                  //   children: [
                  //     Container(
                  //       height: 100,
                  //       width: lebar - 50,
                  //       padding: EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //         color: Color(0xFFA5BECC),
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //       child: StreamBuilder<QuerySnapshot>(
                  //         stream: users.doc(user.uid).collection("histori").snapshots(),
                  //         builder: (_, snapshot){
                  //           return (snapshot.hasData)
                  //             ? Column(
                  //               children: snapshot.data!.docs
                  //                 .map((e) => Text(e.get("no resi"),),).toList(),
                  //             ):CircularProgressIndicator();
                  //         },
                  //         )
                  //       // Column(
                  //       //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       //   crossAxisAlignment: CrossAxisAlignment.start,
                  //       //   children: <Widget>[
                  //       //     Text(
                  //       //       "09902133192929",
                  //       //       style: TextStyle(
                  //       //         fontSize: 18,
                  //       //         fontWeight: FontWeight.w500,
                  //       //       ),
                  //       //     ),
                  //       //     Text("Aldy"),
                  //       //     Text("Jl.Siti Aisyah"),
                  //       //     Text("SMD - JKT")
                  //       //   ],
                  //       // ),
                  //     ),
                  //   ],
                  // );
                ),
              ),
            ],
          );
        });
  }

  Widget kartu(
    BuildContext context,
    String noResi,
    String namaPengirim,
    String namaPenerima,
    String alamat,
    String kategoriPaket,
    String tanggalKirim,
  ) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Container(
      height: 120,
      width: lebar - 50,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Color(0xFFA5BECC),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            noResi,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(namaPengirim),
          Text(namaPenerima),
          Text(alamat),
          Text(kategoriPaket),
          Text(tanggalKirim),
        ],
      ),
    );
  }

  Widget judul(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 40,
          width: 40,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/list.png"),
              ),
            ),
          ),
        ),
        Container(
          height: 40,
          width: 70,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFF243A73),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Text(
            "LIST  ",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontFamily: "MetropolisPersonalUseRegular",
              color: Color(0xFFF2EBE9),
            ),
          ),
        ),
      ],
    );
  }

  Widget tombolpage(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 15,
        ),
        Container(
          height: 35,
          width: 100,
          //padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF2EBE9),
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Text(
            " 01/01/2022 ",
            style: TextStyle(
              fontFamily: "BreadleySansRegular",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 35,
          width: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF7C3E66),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/next.png"),
              ),
            ),
          ),
        ),
        Spacer(
          flex: 1,
        ),
        Container(
          height: 35,
          width: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF7C3E66),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back.png"),
              ),
            ),
          ),
        ),
        Container(
          height: 35,
          width: 40,
          //padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFF2EBE9),
            border: Border.all(
              width: 1,
              color: Colors.black,
            ),
          ),
          child: Text(
            "1",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "BreadleySansRegular",
              fontSize: 24,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          height: 35,
          width: 40,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF7C3E66),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5),
              bottomRight: Radius.circular(5),
            ),
          ),
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/next.png"),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
    );
  }
}
