
import 'package:big_ui_material_null_safety/Coinbase/T4_Dashboard.dart';
import 'package:flutter/material.dart';

import 'T4_Custom_nav_bar.dart';
import 'T4_banking.dart';
import 'T4_home.dart';
import 'T4_setting.dart';
import 'T4_agenda.dart';
import 'T4_wallet.dart';
import 'T4_recent.dart';
import 'LoginScreen.dart';
import 'setting_layout/groupchat.dart';
import 'LoginScreen.dart';

class T4_dashboard extends StatefulWidget {
  T4_dashboard({Key? key}) : super(key: key);

  _T4_dashboardState createState() => _T4_dashboardState();
}

class _T4_dashboardState extends State<T4_dashboard> {


  int currentIndex = 0;
  bool _color =true;
  Widget callPage(int current){
    switch (current) {
       case 0:
        return new T4_home();
        break;
      case 1:
      return new T4_gc();
        break;
      case 2:
      return new T4_banking();
        break;
        case 3:
      return new T4_recent();
        break;
      default: 
      return new T4_home();
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
      backgroundColor: Colors.white,
       body: callPage(currentIndex),


        bottomNavigationBar: T4_BottomNavigationDotBar ( // Usar -> "T4_BottomNavigationDotBar"
        color: Colors.black12,
      items: <T4_BottomNavigationDotBarItem>[
        T4_BottomNavigationDotBarItem(icon: Icons.home, onTap: () { setState(() {
         currentIndex = 0;
        }); }),
        T4_BottomNavigationDotBarItem(icon: Icons.question_answer, onTap: () { setState(() {
         currentIndex = 1;
        }); }),
        T4_BottomNavigationDotBarItem(icon: Icons.contact_mail, onTap: () { setState(() {
         currentIndex = 2;
        }); }),
         T4_BottomNavigationDotBarItem(icon: Icons.chat_bubble, onTap: () { setState(() {
         currentIndex = 3;
        }); }),
         T4_BottomNavigationDotBarItem(icon: Icons.logout, onTap: () { setState(() {
           Navigator.of(context).push(PageRouteBuilder(
               pageBuilder: (_, __, ___) => new LoginScreen1 ()));
        }); }),
         ]
  ),

    ));
  }
}