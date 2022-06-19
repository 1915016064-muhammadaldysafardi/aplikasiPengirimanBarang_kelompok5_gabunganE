import 'package:flutter/material.dart';

class MyPackage1 extends StatelessWidget {
  const MyPackage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPackage1Page(),
    );
  }
}

class MyPackage1Page extends StatefulWidget {
  const MyPackage1Page({Key? key}) : super(key: key);

  @override
  State<MyPackage1Page> createState() => _MyPackage1PageState();
}

class _MyPackage1PageState extends State<MyPackage1Page> {
  final List<BottomNavigationBarItem> _myBottom = [
    BottomNavigationBarItem(icon: Icon(Icons.looks_one_outlined), label:"SuperExpress"),
    BottomNavigationBarItem(icon: Icon(Icons.looks_two_outlined), label:"StandartExpress"),
  ];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _materiPage = [
      isi(context, "SuperExpress", "2-4 hari"),
      isi(context, "StdExpress", "7-14 hari"),
    ];

    return Scaffold(
      body: Stack(
        children: <Widget>[
          latar(context),
          _materiPage.elementAt(_pageIndex),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(currentIndex: _pageIndex, items: _myBottom, onTap: (int newIndex){
        setState(() {
          _pageIndex = newIndex;
        });
      },),
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

  Widget isi(BuildContext context, String nama, String hari) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 23,
        ),
        Row(
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
                "VIA PESAWAT",
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
        SizedBox(
          height: 30,
        ),
        Container(
          height: 200,
          width: lebar - 30,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFF7C3E66),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Image(
            image: AssetImage("assets/paket1.jpg"),
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 15,
            ),
            Container(
              height: 50,
              width: 120,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF243A73),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                nama,
                style: TextStyle(
                  fontFamily: "BreadleySansRegular",
                  fontSize: 24,
                  color: Color(0xFFF2EBE9),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Container(
              height: 50,
              width: 80,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF7C3E66),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                ),
              ),
              child: Text(
                hari,
                style: TextStyle(
                  fontFamily: "BreadleySansRegular",
                  fontSize: 24,
                  color: Color(0xFFF2EBE9),
                ),
              ),
            ),
            Container(
              height: 50,
              width: 40,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
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
                    image: AssetImage("assets/clock.png"),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 130,
          width: lebar - 30,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFF7C3E66),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Deskripsi",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFF2EBE9),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Ukuran Barang",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Tipe Barang    ",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Jaminan        ",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "kecil - sedang",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "pecah belah / biasa",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "garansi & packing safety",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          height: 130,
          width: lebar - 30,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xFFA5BECC),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Detail Harga",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFF2EBE9),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "< 1 Kg",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "1 - 3 Kg",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "> 3 - 5 Kg",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 90,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Rp 50.000",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp 75.000",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rp 100.000",
                        style: TextStyle(
                          color: Color(0xFFF2EBE9),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
