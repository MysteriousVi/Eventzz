import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'T4_banking.dart';
import 'T4_Leaderboard.dart';
import 'setting_layout/T4_notification.dart';
import 'setting_layout/T4_payment.dart';
import 'T4_agenda.dart';
import 'T4_wallet.dart';
import 'T4_audi.dart';
import 'T4_attendees.dart';
import 'LoginScreen.dart';

class T4_home extends StatefulWidget {
  T4_home({Key? key}) : super(key: key);

  _T4_homeState createState() => _T4_homeState();
}

class _T4_homeState extends State<T4_home> {
  String _name = '';

  @override
  void initState() {
    getStringValuesSF();
    super.initState();
  }

  Future<void> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      _name = (prefs.getString('name') ?? '');
    });
  }

  Future<bool> _onWillPop() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
      child: Scaffold(
      backgroundColor: Colors.white,
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
                    height: 250.0,
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

                ///
                /// Create Box below profile
                ///
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 270.0, bottom: 30.0),
                  child: Container(
                    height: 240.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 10.0,
                              spreadRadius: 4.0)
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                            onTap: (){ Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder: (_, __, ___) => new T4_agenda()));},
                            child: Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.article,
                                  color: Color(0xFF81B622),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Agenda",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 40.0,
                            ),
                            GestureDetector(
                              onTap: (){ Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new T4_notification()));},
                            child: Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.notifications_rounded,
                                  color: Color(0xFF81B622),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Notifications",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){ Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new T4_audi()));},
                            child: Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.desktop_windows_rounded,
                                  color: Color(0xFF81B622),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Auditorium",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.qr_code_scanner_rounded,
                                  color: Color(0xFF81B622),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("QR",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){ Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new T4_leaderboard()));},
                            child: Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.leaderboard_rounded,
                                  color: Color(0xFF81B622),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Leaderboard",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 40.0,
                            ),
                            GestureDetector(
                              onTap: (){ Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new T4_payment()));},
                            child: Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.account_circle_rounded,
                                  color: Color(0xFF81B622),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Profile",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){ Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new T4_attendees()));},
                            child: Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.people_rounded,
                                  color: Color(0xFF81B622),
                                ),
                              ),
                            ),
                            ),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Attendees",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600)),
                            SizedBox(
                              height: 40.0,
                            ),
                            GestureDetector(
                              onTap: (){ Navigator.of(context).push(PageRouteBuilder(
                                  pageBuilder: (_, __, ___) => new LoginScreen1()));},
                              child:Container(
                              height: 47.0,
                              width: 47.0,
                              decoration: BoxDecoration(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(50.0)),
                                  color: Color(0xFFFAF9FC)),
                              child: Center(
                                child: Icon(
                                  Icons.logout_rounded,
                                  color: Color(0xFF81B622),
                                ),
                              ),
                            ),),
                            SizedBox(
                              height: 7.0,
                            ),
                            Text("Logout",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontFamily: "Popins",
                                    fontWeight: FontWeight.w600))
                          ],
                        ),

                      ],
                    ),
                  ),

                ),


                ///
                /// Create profile
                ///
                Padding(
                    padding: EdgeInsets.only(top: 72.0, left: 22.0),
                    child: profile()),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  ///
  /// Create triangle
  ///
  Widget _transaction(IconData icon, String title, String time, String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40.0)),
                        color: Color(0xFFA665D1)),
                    child: Center(
                      child: Icon(
                        icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w600,
                            fontSize: 15.5),
                      ),
                      Text(
                        time,
                        style: TextStyle(color: Colors.black45),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                value,
                style: TextStyle(
                  color: Colors.red,
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700,
                  fontSize: 15.5,
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            height: 0.5,
            width: double.infinity,
            color: Colors.black12.withOpacity(0.1),
          )
        ],
      ),
    );
  }

  ///
  /// Triangle for appbar wave
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

  ///
  /// Create profile widget
  ///
  Widget profile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 63.0,
          width: 63.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100.0)),
              border: Border.all(color: Colors.white, width: 2.0),
              image: DecorationImage(
                  image: NetworkImage(
                      "https://images.pexels.com/photos/4091205/pexels-photo-4091205.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260"),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          width: 20.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '$_name',
              style: TextStyle(
                  fontFamily: "Popins",
                  fontWeight: FontWeight.w700,
                  fontSize: 24.0,
                  color: Colors.white),
            ),
            Text(
              "Logged In",
              style: TextStyle(
                  fontFamily: "Sans",
                  fontWeight: FontWeight.w300,
                  color: Colors.white54),
            )
          ],
        )
      ],
    );
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
