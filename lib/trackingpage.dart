import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class MyTracking extends StatelessWidget {
  const MyTracking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyTrackingPage(),
    );
  }
}

class MyTrackingPage extends StatefulWidget {
  const MyTrackingPage({Key? key}) : super(key: key);

  @override
  State<MyTrackingPage> createState() => _MyTrackingPAgeState();
}

class _MyTrackingPAgeState extends State<MyTrackingPage> {
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
              "TRACKING",
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
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: 80,
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
            Container(
              height: 60,
              width: lebar - 30,
              decoration: BoxDecoration(
                color: Color(0xFFF2EBE9),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xFF7C3E66),
                  width: 10,
                ),
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 240,
                    child: TextField(
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        //labelText: "  Cari No. Resi",
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    color: Color(0xFF7C3E66),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 15,
                ),
                Container(
                  height: 50,
                  width: 40,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
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
                        image: AssetImage("assets/instructions.png"),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 120,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xFF243A73),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                  ),
                  child: Text(
                    "Detail Info",
                    style: TextStyle(
                      fontFamily: "BreadleySansRegular",
                      fontSize: 24,
                      color: Color(0xFFF2EBE9),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                // Container(
                //   height: 50,
                //   width: 165,
                //   padding: EdgeInsets.all(10),
                //   decoration: BoxDecoration(
                //     color: Color(0xFF243A73),
                //     borderRadius: BorderRadius.only(
                //       bottomLeft: Radius.circular(5),
                //       topLeft: Radius.circular(5),
                //       topRight: Radius.circular(5),
                //     ),
                //   ),
                //   child: Text(
                //     "S   E   A   R   C   H",
                //     style: TextStyle(
                //       fontFamily: "BreadleySansRegular",
                //       fontSize: 24,
                //       color: Color(0xFFF2EBE9),
                //     ),
                //   ),
                // ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Container(
                    height: 200,
                    width: 270,
                    decoration: BoxDecoration(
                      color: Color(0xFFA5BECC),
                      borderRadius: BorderRadius.circular(5)
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                // Container(
                //   height: 230,
                //   width: 35,
                //   padding: EdgeInsets.only(left: 15),
                //   decoration: BoxDecoration(
                //     color: Color(0xFF243A73),
                //     borderRadius: BorderRadius.only(
                //       bottomLeft: Radius.circular(5),
                //       bottomRight: Radius.circular(5),
                //     ),
                //   ),
                //   child: Text(
                //     "E\n\nR\n\nE",
                //     style: TextStyle(
                //       fontFamily: "BreadleySansRegular",
                //       fontSize: 24,
                //       color: Color(0xFFF2EBE9),
                //     ),
                //   ),
                // ),
                SizedBox(
                  width: 15,
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
