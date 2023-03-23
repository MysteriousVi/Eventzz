import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'setting_layout/php_functions.dart';

class T4_agenda extends StatefulWidget {
  T4_agenda({Key? key}) : super(key: key);

  _T4_agendaState createState() => _T4_agendaState();
}

class _T4_agendaState extends State<T4_agenda> {
  var data  ;

  get_data() async {
    data = await get_agenda();
    setState(() {});
  }

  @override
  void initState() {
    get_data();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFBFBFD),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                ///
                /// Create wave appbar
                ///
                ClipPath(
                  child: Container(
                    height: 160.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF81B622), Color(0xFFECF87F)])),
                  ),
                  clipper: BottomWaveClipper(),
                ),

                ///
                /// Get triangle widget
                ///
                _triangle(
                  20.0,
                  10.0,
                ),
                _triangle(
                  110.0,
                  80.0,
                ),
                _triangle(
                  60.0,
                  190.0,
                ),
                _triangle(
                  40.0,
                  300.0,
                ),
                _triangle(
                  130.0,
                  330.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70.0, left: 20.0),
                  child: Text(
                    "Agenda",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                )
              ],
            ),

            ///
            /// Create box total transaction in below appbar
            ///
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Container(
                height: 175.0,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 25.0,
                          color: Colors.black12.withOpacity(0.05),
                          spreadRadius: 5.0)
                    ]),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "Live Now",
                      style: TextStyle(
                          color: Colors.black45,
                          fontFamily: "Sans",
                          fontSize: 13.0),
                    ),
                    SizedBox(
                      height: 0.0,
                    ),
                    Text(
                      "Summit Introduction & Welcome",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontFamily: "Popins",
                          fontSize: 22.0,
                          letterSpacing: 1.2),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Text(
                        "By Professor Proton",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontFamily: "Popins",
                            fontSize: 22.0,
                            letterSpacing: 1.2),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
              child: Container(
                height: 400,
                    child: ListView.builder(
                        itemBuilder: (_, index) {
                          var adata = data[index];

                          return _cardToday(
                              "https://images.pexels.com/photos/3310695/pexels-photo-3310695.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                              adata['name'],
                              adata['topic'],
                              convert(adata['start_time']),
                              Colors.redAccent);
                        },
                        itemCount: data.length ,
                        reverse: false,
                        padding:
                        new EdgeInsets.only(right: 10.0,left: 10.0, bottom: 10.0),
                      ),
              ),
            ),
            SizedBox(
              height: 30.0,
            )
          ],
        ),
      ),
    );
  }

  ///
  /// Create card today widget
  ///
  Widget _cardToday(String image, String _title, String _subTitle,
      String _value, Color _textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 15.0),
      child: Container(
        height: 120.0,
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.black12.withOpacity(0.05),
              blurRadius: 10.0,
              spreadRadius: 3.0),
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Container(
                    height: 45.0,
                    width: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      image: DecorationImage(
                          image: NetworkImage(image), fit: BoxFit.cover),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Container (
                    height: 120.0,
                    width: 150.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: <Widget>[
                      Text(
                        _title,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Text(
                        _subTitle,
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.0),
                      ),
                    ],
                  ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Text(
                _value,
                style:
                TextStyle(color: _textColor, fontWeight: FontWeight.w800),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Create triangle
  ///
  Widget _triangle(double top, left) {
    return Padding(
      padding: EdgeInsets.only(top: top, left: left),
      child: ClipPath(
        child: Container(
          height: 40.0,
          width: 40.0,
          color: Colors.white12.withOpacity(0.09),
        ),
        clipper: TriangleClipper(),
      ),
    );
  }

  String convert(String str) {
    var timestamp = int.parse(str);
    DateFormat formatter = DateFormat('hh a');
    String time = formatter.format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000)).toString();
    return time;
  }
}

///
/// Create wave appbar
///
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height - 20);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2.25, size.height - 30.0);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 65);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

///
/// Create triangle clipper
///
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
