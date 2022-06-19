import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class MyForm extends StatelessWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyFormPage(),
    );
  }
}

class MyFormPage extends StatefulWidget {
  const MyFormPage({Key? key}) : super(key: key);

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

TextEditingController namaPengirim = TextEditingController();
TextEditingController namaPenerima = TextEditingController();
TextEditingController alamatPengirim = TextEditingController();
TextEditingController alamatPenerima = TextEditingController();
TextEditingController beratBarang = TextEditingController();

enum Jenis { Pecah, Biasa }

enum Kirim { Rumah, Outlet }

enum Paket { Super, Standart, Hemat, Murah }

Random random = Random();
var min = 100000;
var max = 999999;
int noResi = min + random.nextInt(max - min);
String date = "Tanggal Lahir";
DateTime selectedDate = DateTime.now();

class _MyFormPageState extends State<MyFormPage> {
  Jenis? jenis = Jenis.Biasa;
  Kirim? kirim = Kirim.Rumah;
  Paket? paket = Paket.Super;

  String JenisBarang(Jenis jenis) {
    if (jenis == Jenis.Biasa) {
      return "Biasa";
    } else {
      return "Pecah Belah";
    }
  }

  String KirimDari(Kirim kirim) {
    if (kirim == Kirim.Rumah) {
      return "Dari Rumah";
    } else {
      return "Dari Outlet";
    }
  }

  String PilihPaket(Paket paket) {
    if (paket == Paket.Super) {
      return "SuperExpress";
    } else if (paket == Paket.Standart) {
      return "StandartExpress";
    } else if (paket == Paket.Hemat) {
      return "HematExpress";
    } else {
      return "MurahExpress";
    }
  }

  String TotalBiaya(Jenis jenis, Kirim kirim, Paket paket) {
    if (jenis == Jenis.Biasa && kirim == Kirim.Rumah && paket == Paket.Super) {
      return "Rp. 100.000";
    } else if (jenis == Jenis.Biasa &&
        kirim == Kirim.Rumah &&
        paket == Paket.Standart) {
      return "Rp. 80.000";
    } else if (jenis == Jenis.Biasa &&
        kirim == Kirim.Rumah &&
        paket == Paket.Hemat) {
      return "Rp. 40.000";
    } else if (jenis == Jenis.Biasa &&
        kirim == Kirim.Rumah &&
        paket == Paket.Murah) {
      return "Rp. 20.000";
    } else if (jenis == Jenis.Biasa &&
        kirim == Kirim.Outlet &&
        paket == Paket.Super) {
      return "Rp. 90.000";
    } else if (jenis == Jenis.Biasa &&
        kirim == Kirim.Outlet &&
        paket == Paket.Standart) {
      return "Rp. 70.000";
    } else if (jenis == Jenis.Biasa &&
        kirim == Kirim.Outlet &&
        paket == Paket.Hemat) {
      return "Rp. 30.000";
    } else if (jenis == Jenis.Biasa &&
        kirim == Kirim.Outlet &&
        paket == Paket.Murah) {
      return "Rp. 10.000";
    } else if (jenis == Jenis.Pecah &&
        kirim == Kirim.Rumah &&
        paket == Paket.Super) {
      return "Rp. 110.000";
    } else if (jenis == Jenis.Pecah &&
        kirim == Kirim.Rumah &&
        paket == Paket.Standart) {
      return "Rp. 90.000";
    } else if (jenis == Jenis.Pecah &&
        kirim == Kirim.Rumah &&
        paket == Paket.Hemat) {
      return "Rp. 50.000";
    } else if (jenis == Jenis.Pecah &&
        kirim == Kirim.Rumah &&
        paket == Paket.Murah) {
      return "Rp. 30.000";
    } else if (jenis == Jenis.Pecah &&
        kirim == Kirim.Outlet &&
        paket == Paket.Super) {
      return "Rp. 105.000";
    } else if (jenis == Jenis.Pecah &&
        kirim == Kirim.Outlet &&
        paket == Paket.Standart) {
      return "Rp. 85.000";
    } else if (jenis == Jenis.Pecah &&
        kirim == Kirim.Outlet &&
        paket == Paket.Hemat) {
      return "Rp. 45.000";
    } else {
      return "25.000";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          latar(context),
          isi(context),
          apbar(context),
          botnav(context),
        ],
      ),
    );
  }

  Future<String?> addSubColletction({
    String? id,
    String? noResi,
    String? namaPengirim,
    String? namaPenerima,
    String? alamatPengirim,
    String? alamatPenerima,
    String? jenisBarang,
    String? beratBarang,
    String? kirimDari,
    String? totalBiaya,
    String? kategoriPaket,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection("users");

    users.doc(id).collection("histori").add({
      "id": id,
      "no resi": noResi,
      "nama pengirim": namaPengirim,
      "nama penerima": namaPenerima,
      "alamat pengirim": alamatPengirim,
      "alamat penerima": alamatPenerima,
      "jenis barang": jenisBarang,
      "berat barang": beratBarang,
      "kirim dari": kirimDari,
      "kategori paket": kategoriPaket,
      "total biaya": totalBiaya,
      "tanggal kirim": DateTime.now(),
    });
  }

  Widget isi(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Container(
              height: 40,
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF243A73),
              ),
              child: Text(
                "Nama Pengirim",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "MetropolisPersonalUseRegular",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF2EBE9)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: lebar - 60,
              child: TextField(
                controller: namaPengirim,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF243A73),
              ),
              child: Text(
                "Nama Penerima",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "MetropolisPersonalUseRegular",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF2EBE9)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: lebar - 60,
              child: TextField(
                controller: namaPenerima,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF243A73),
              ),
              child: Text(
                "Alamat Pengirim",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "MetropolisPersonalUseRegular",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF2EBE9)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: lebar - 60,
              child: TextField(
                controller: alamatPengirim,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF243A73),
              ),
              child: Text(
                "Alamat Penerima",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "MetropolisPersonalUseRegular",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF2EBE9)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: lebar - 60,
              child: TextField(
                controller: alamatPenerima,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF243A73),
              ),
              child: Text(
                "Berat Barang",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "MetropolisPersonalUseRegular",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF2EBE9)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: lebar - 60,
              child: TextField(
                controller: beratBarang,
                style: TextStyle(
                  fontSize: 18,
                ),
                decoration: InputDecoration(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF243A73),
              ),
              child: Text(
                "Jenis Barang",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "MetropolisPersonalUseRegular",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF2EBE9)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 150,
                  child: ListTile(
                    title: const Text('Biasa'),
                    horizontalTitleGap: 3,
                    leading: Radio<Jenis>(
                      value: Jenis.Biasa,
                      groupValue: jenis,
                      onChanged: (Jenis? value) {
                        setState(() {
                          jenis = value;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  width: 180,
                  child: ListTile(
                    title: const Text('Pecah Belah'),
                    horizontalTitleGap: 3,
                    leading: Radio<Jenis>(
                      value: Jenis.Pecah,
                      groupValue: jenis,
                      onChanged: (Jenis? value) {
                        setState(() {
                          jenis = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 40,
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF243A73),
              ),
              child: Text(
                "KIRIM DARI",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "MetropolisPersonalUseRegular",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF2EBE9)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 150,
                  child: ListTile(
                    title: const Text('Rumah'),
                    horizontalTitleGap: 3,
                    leading: Radio<Kirim>(
                      value: Kirim.Rumah,
                      groupValue: kirim,
                      onChanged: (Kirim? value) {
                        setState(() {
                          kirim = value;
                        });
                      },
                    ),
                  ),
                ),
                // SizedBox(
                //   width: 30,
                // ),
                Container(
                  width: 150,
                  child: ListTile(
                    title: const Text('Outlet'),
                    horizontalTitleGap: 3,
                    leading: Radio<Kirim>(
                      value: Kirim.Outlet,
                      groupValue: kirim,
                      onChanged: (Kirim? value) {
                        setState(() {
                          kirim = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 40,
              width: 150,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color(0xFF243A73),
              ),
              child: Text(
                "Pilih Paket",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: "MetropolisPersonalUseRegular",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFFF2EBE9)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Container(
                  child: ListTile(
                    title: const Text('SuperExpress (Pesawat 3 Hari)'),
                    horizontalTitleGap: 3,
                    leading: Radio<Paket>(
                      value: Paket.Super,
                      groupValue: paket,
                      onChanged: (Paket? value) {
                        setState(() {
                          paket = value;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    title: const Text('StandartExpress (Pesawat 7 - 10 Hari)'),
                    horizontalTitleGap: 3,
                    leading: Radio<Paket>(
                      value: Paket.Standart,
                      groupValue: paket,
                      onChanged: (Paket? value) {
                        setState(() {
                          paket = value;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    title: const Text('HematExpress (Kapal 14 - 21 Hari)'),
                    horizontalTitleGap: 3,
                    leading: Radio<Paket>(
                      value: Paket.Hemat,
                      groupValue: paket,
                      onChanged: (Paket? value) {
                        setState(() {
                          paket = value;
                        });
                      },
                    ),
                  ),
                ),
                Container(
                  child: ListTile(
                    title: const Text('MurahExpress (Kapal 30 Hari)'),
                    horizontalTitleGap: 3,
                    leading: Radio<Paket>(
                      value: Paket.Murah,
                      groupValue: paket,
                      onChanged: (Paket? value) {
                        setState(() {
                          paket = value;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ],
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

  Widget botnav(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser!;
    return Positioned(
      top: tinggi - 60,
      left: 20,
      child: GestureDetector(
        onTap: () {
          addSubColletction(
              id: user.uid,
              noResi: noResi.toString(),
              namaPengirim: namaPengirim.text,
              namaPenerima: namaPenerima.text,
              alamatPengirim: alamatPengirim.text,
              alamatPenerima: alamatPenerima.text,
              beratBarang: beratBarang.text,
              jenisBarang: JenisBarang(jenis!),
              kirimDari: KirimDari(kirim!),
              kategoriPaket: PilihPaket(paket!),
              totalBiaya: TotalBiaya(jenis!, kirim!, paket!));
        },
        child: Container(
          height: 50,
          width: lebar - 40,
          decoration: BoxDecoration(
            color: Color(0xFF7C3E66),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              "BUAT PENGIRIMAN BARANG",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xFFF2EBE9),
                //fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
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
              "FORM KIRIM",
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
}
