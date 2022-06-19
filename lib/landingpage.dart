import 'package:flutter/material.dart';
import 'package:pengiriman_barang/login.dart';

class MyLanding extends StatelessWidget {
  const MyLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Landing Page Pengiriman Barang',
      theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(255, 255, 46, 31))),
      home: MyLandingPage(key: key),
    );
  }
}

class MyLandingPage extends StatefulWidget {
  const MyLandingPage({Key? key}) : super(key: key);

  @override
  State<MyLandingPage> createState() => _MyLandingPageState();
}

class _MyLandingPageState extends State<MyLandingPage> {
  @override
  Widget build(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(children: <Widget>[latar(context), judul(context)]),
    );
  }

  Widget latar(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Container(
      height: tinggi,
      width: lebar,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/latarB.jpg"), fit: BoxFit.cover)),
    );
  }

  Widget kotak(
    BuildContext context,
    String isi,
    String gambar,
  ) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: <Widget>[
          Image(
            image: AssetImage(gambar),
            height: 100.0,
            width: 100.0,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            isi,
            style: TextStyle(
                fontFamily: "BreadleySansRegular",
                fontSize: 16,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Widget judul(BuildContext context) {
    var tinggi = MediaQuery.of(context).size.height;
    var lebar = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 50,
        ),
        Align(
            alignment: Alignment.center,
            child: Text(
              "TimLima Express",
              style: TextStyle(
                  fontFamily: 'MetropolisPersonalUseRegular',
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
        SizedBox(
          height: 50,
        ),
        Container(
          height: 350,
          width: 500,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Spacer(
                    flex: 1,
                  ),
                  kotak(context, "Pengiriman yang Mudah", "assets/giftBox.png"),
                  Spacer(
                    flex: 1,
                  ),
                  kotak(context, "Cepat dan Tepat", "assets/deliveryTruck.png"),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Spacer(
                    flex: 1,
                  ),
                  kotak(context, "Kesehatan Terjamin", "assets/antivirus.png"),
                  Spacer(
                    flex: 1,
                  ),
                  kotak(
                      context, "1000+ Gerai Tersebar ", "assets/connected.png"),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MyLoginPage(),
                ),
              );
            },
            child: Text("Gabung Sekarang"),
            style: ElevatedButton.styleFrom(
              primary: Colors.black, // Background color
            ))
      ],
    );
  }
}
