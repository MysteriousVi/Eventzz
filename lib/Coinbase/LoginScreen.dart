import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'T4_Dashboard.dart';
import 'setting_layout/php_functions.dart';

class LoginScreen1 extends StatefulWidget {
  @override
  _LoginScreen1State createState() => _LoginScreen1State();
}

class _LoginScreen1State extends State<LoginScreen1> {
  final titleController = TextEditingController();

  clear() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
  @override
  void initState() {
    clear();
    super.initState();
  }

    addStringToSF() async {
      int loggedin = await login(titleController.text);
      if (loggedin == 1) {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => new T4_dashboard()));
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            content: new Text("Invalid email address ")));
      }
    }
  Future<bool> _onWillPop() async {
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child:Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF008080),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child: Stack(
              children: <Widget>[
                Positioned(
                    child: Container(
                        decoration: BoxDecoration(
                        ),
                      ),
                    )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                  Text(
                    "Hello There, \nWelcome ",
                    style: TextStyle(
                      fontSize: 35,
                      fontFamily: "Sofia",
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                SizedBox(
                  height: 40,
                ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white!,
                              ),
                            ),
                          ),
                          child: TextField(
                            style: TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            controller: titleController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Email",
                              hintStyle: TextStyle(color: Colors.white),
                              focusColor: Colors.white ,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 20.0,
                ),
                  GestureDetector(
                    onTap: addStringToSF,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.pink[200],
                    ),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: "Sofia",
                        ),
                      ),
                    ),
                  ),
                  ),
                SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          )
        ],
      ),
    ));
  }
}
