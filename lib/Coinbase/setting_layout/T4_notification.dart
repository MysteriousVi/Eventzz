
import 'php_functions.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model_data/notification_model.dart';

class T4_notification extends StatefulWidget {
  T4_notification({Key? key}) : super(key: key);

  _T4_notificationState createState() => _T4_notificationState();
}

class _T4_notificationState extends State<T4_notification> {
  var items  ;
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
    items = await get_notifications(_email);
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
      backgroundColor: Colors.white,
      body: Column(
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
                child: Row(children: <Widget>[
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "Notification",
                    style:
                        TextStyle(color:Colors.white,fontSize: 25.0, fontWeight: FontWeight.w700),
                  )
                ]),
              )
            ],
          ),
          Expanded(
            child: items.length > 0
                ? ListView.builder(
                    itemCount: items.length,
                    padding: const EdgeInsets.all(5.0),
                    itemBuilder: (context, position) {
                      return Dismissible(
                          key: Key(items[position]['id'].toString()),
                          onDismissed: (direction) {
                            setState(() {
                              items.removeAt(position);
                            });
                          },
                          background: Container(
                            color: Color(0xFFFFBBCF),
                          ),
                          child: Container(
                            height: 88.0,
                            child: Column(
                              children: <Widget>[
                                Divider(
                                  height: 5.0,
                                  color: Colors.black12,
                                ),
                                ListTile(
                                  title: Text(
                                    '${items[position]['type']}' == 'virtual' ? 'V-Card' : 'Message' ,
                                    style: TextStyle(
                                        fontSize: 17.5,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: Container(
                                      width: 440.0,
                                      child: Text(
                                        '${items[position]['message']}',
                                        style: new TextStyle(
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.italic,
                                            color: Colors.black38),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
/*                                  onTap: () =>
                                      _onTapItem(context, items[position])*/
                                ),
                                Divider(
                                  height: 5.0,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                          ));
                    })
                : noItemNotifications(),
          )
        ],
      ),
    );
  }

/*  void _onTapItem(BuildContext context, Post post) {
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: new Text(post.id.toString() + ' - ' + post.title!)));
  }*/

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
              "Not Have Notification",
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
