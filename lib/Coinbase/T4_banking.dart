import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'setting_layout/php_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model_data/cardWallet_model.dart';

class T4_banking extends StatefulWidget {
  T4_banking({Key? key}) : super(key: key);

  _T4_bankingState createState() => _T4_bankingState();
}

class _T4_bankingState extends State<T4_banking> {
  var data  ;
  String _name = '';
  String _email = '';

  Future<void> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      _name = (prefs.getString('name') ?? '');
    });
  }

  get_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _email = (prefs.getString('email') ?? '');
    data = await get_vcards(_email);
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                    "Recieved V-Cards",
                    style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.1),
                  ),
                )
              ],
            ),

            ///
            /// Credit card header slider
            ///

            ///
            /// List horizontal for card contact
            ///


            ///
            /// Create card recent transaction
          Padding(padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
            child: DefaultTabController (
              length: 2,
              initialIndex: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container (
                    child: TabBar(
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.black,
                      tabs: [
                        Tab(text:'Accepted'),
                        Tab(text:'Pending'),
                      ],
                    ),
                  ),
                  Container(
                    height: 400,
                    child: TabBarView(
                        children: <Widget>[
                          Container(
                            height: 450.0,
                            child: data.length > 0
                                ? ListView.builder(
                                itemBuilder: (_, index) {
                                  var adata = data[index];
                                  return Column(children: <Widget>[_cardHeader(adata),Divider(height: 30.0)],);
                                },
                                itemCount: data.length ,
                                reverse: false)
                                :noItemNotifications(),
                          ),
                          Container(
                            height: 450.0,
                            child: data.length > 0
                                ? ListView.builder(
                                itemBuilder: (_, index) {
                                  var adata = data[index];
                                  return Column(
                                    children: <Widget>[
                                      _cardHeader(adata),
                                      Divider(height: 10.0),
                                      Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.blue,
                                        ),
                                        onPressed: null,
                                        child: Text('Accept'),
                                      ),
                                    TextButton(
                                      style: TextButton.styleFrom(

                                      ),
                                      onPressed: null,
                                      child: Text('Reject'),
                                    )
                                    ],),]);
                                },
                                itemCount: data.length ,
                                reverse: false)
                                :noItemNotifications(),
                          ),
                        ]),
                  ),
                ],

              ),// length of tabs
            ),/*Container(
            height: 450.0,
            child: ListView.builder(
            itemBuilder: (_, index) {
                  var adata = listCard[index];
                  return Column(children: <Widget>[_cardHeader(adata),Divider(height: 30.0)],);
            },
              itemCount: listCard.length ,
              reverse: false),
),*/
    ),
    ],
    ),
      ),
    );
  }

  Widget noItemNotifications() {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
            Image.asset(
              "lib/Screen/FullApps/Coinbase/Assets/notifications.png",
              height: 200.0,
            ),
            Padding(padding: EdgeInsets.only(bottom: 30.0)),
            Text(
              "Not Have V-Cards",
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18.5,
                  color: Colors.black54,
                  fontFamily: "Gotik"),
            ),
          ],
        ),
      ),
    );
  }

  ///
  /// Widget for card today
  ///
  Widget _cardToday(String image, String _title, String _subTitle,
      String _value, Color _textColor) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
      child: Container(
        height: 80.0,
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
                      )
                    ],
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
  /// Widget for create card contact
  ///
  Widget _cardContact(String image, String name) {
    return Padding(
      padding:
      const EdgeInsets.only(left: 15.0, right: 1.0, bottom: 10.0, top: 5.0),
      child: Container(
        width: 100.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.05),
                blurRadius: 3.0,
                spreadRadius: 1.0),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 47.0,
                width: 47.0,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12.withOpacity(0.2),
                        blurRadius: 2.0,
                        spreadRadius: 1.0)
                  ],
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.lightBlueAccent,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(name,
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Sans"))
            ],
          ),
        ),
      ),
    );
  }

  ///
  /// Widget for create credit card
  ///
  Widget _cardHeader(dynamic item) {
    return Stack(
      children: <Widget>[
        Divider(height: 90.0,),
        Container(
          height: 220.0,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green,Colors.lime],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0, right: 25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item['company'],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Sans",
                          fontSize: 20.0),
                    ),
                    Icon(
                      Icons.spa,
                      color: Colors.white,
                    )
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item['name'],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Popins",
                          fontSize: 20.0,
                          letterSpacing: 1.7),
                    ),
                    Text(
                      '3975',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Sans",
                          fontSize: 20.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      item['email'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontFamily: "Sans",
                        fontSize: 18.0,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          "Date",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Sans",
                          ),
                        ),
                        Text(
                          '07/21',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Sans",
                              fontSize: 16.0),
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Container(
            height: 170.0,
            width: 170.0,
            decoration: BoxDecoration(
                color: Colors.white10.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200.0),
                    topRight: Radius.circular(20.0))),
          ),
        ),
      ],
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
