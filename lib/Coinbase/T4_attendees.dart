import 'package:flutter/material.dart';
import 'setting_layout/T4_chatItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'setting_layout/T4_chatitem1.dart';
import 'setting_layout/php_functions.dart';

class T4_attendees extends StatefulWidget {
  T4_attendees({Key? key}) : super(key: key);

  _T4_attendeesState createState() => _T4_attendeesState();
}

class _T4_attendeesState extends State<T4_attendees> {
  var data  ;
  String _name = '';
  String _company = '';
  String _email ='';

  Future<void> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    setState(() {
      _name = (prefs.getString('name') ?? '');
      _company = (prefs.getString('company') ?? '');
      _email = (prefs.getString('email') ?? '');
    });
  }

  get_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
      _name = (prefs.getString('name') ?? '');
      _company = (prefs.getString('company') ?? '');
      _email = (prefs.getString('email') ?? '');
    data = await get_attendees(_email);
    setState(() {});
  }

  openchat(String str, String str1) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email2', str);
    prefs.setString('chatname', str1);
  }

  @override
  void initState() {
    getStringValuesSF();
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
                    "Attendees",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                )
              ],
            ),

            ///
            /// Create card above appbar wave
            ///
    Container(
    height : 500,
    child:
            ListView.builder(
              itemBuilder: (_, index) {
                var adata = data[index];

                return GestureDetector(
                    onTap: (){
                      openchat(adata['email'], adata['name']);
                      Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new T4_chatItem ()));},
                  child :_cardToday(
                    "https://images.pexels.com/photos/3310695/pexels-photo-3310695.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
                    adata['name'],
                    adata['company'],
                    Colors.greenAccent));
              },
              itemCount: data.length ,
              reverse: false,
              padding:
              new EdgeInsets.only(right: 10.0,left: 10.0, bottom: 10.0),
            ),),
          ],
        ),
      ),
    );
  }

  ///
  /// Widget card category
  ///
  Widget _cardToday(String image, String _title, String _subTitle,
       Color _textColor) {
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
              child: Icon(
                Icons.circle,
                color: _textColor,
              ),
              )
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
