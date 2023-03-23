import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



login(String _msg) async {
    final response = await http.get(
      Uri.parse('https://appapi.zebiqtechnology.com/single_user.php?email=$_msg')
    );

    dynamic data =
    jsonDecode(response.body); // Turn bytes to readable data.
    if (data['status'] == 200){
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('name', data['name']);
      prefs.setString('company', data['company']);
      prefs.setString('email', data['email']);
      return 1 ;
    }
    else {
      return 0;
    }
}

get_agenda() async{
  final response = await http.get(
      Uri.parse('https://appapi.zebiqtechnology.com/agenda.php')
  );
  return jsonDecode(response.body);
}

get_leaderpoints() async {
  final response = await http.get(
      Uri.parse('https://appapi.zebiqtechnology.com/points.php')
  );
  return jsonDecode(response.body);
}

get_notifications(String _msg) async {
  print("Entered");
  final response = await http.get(
      Uri.parse('https://appapi.zebiqtechnology.com/alerts.php?email=$_msg')
  );

  return jsonDecode(response.body);

}

get_vcards(String _msg) async {
  print("Entered");
  final response = await http.get(
      Uri.parse('https://appapi.zebiqtechnology.com/v_cards.php?email=$_msg')
  );
  return jsonDecode(response.body);

}

get_attendees(String _msg) async {
  print("Entered");
  final response = await http.get(
      Uri.parse('https://appapi.zebiqtechnology.com/users.php?email=$_msg')
  );
  return jsonDecode(response.body);

}


get_chat() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String _name = (prefs.getString('email2') ?? '');
  String _email = (prefs.getString('email') ?? '');
  print("Entered");
  final response = await http.get(
      Uri.parse('https://appapi.zebiqtechnology.com/privatechat.php?email=$_email&email2=$_name')
  );
  print(jsonDecode(response.body));
  return jsonDecode(response.body);

}

get_chat1(String _msg, String _msg1) async {
  print("Entered");
  final response = await http.get(
      Uri.parse(Uri.encodeFull('https://appapi.zebiqtechnology.com/privatechat.php?email=$_msg&email2=$_msg1'))
  );
  print(jsonDecode(response.body));
  return jsonDecode(response.body);

}

