// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_application_4/model/User.dart';

class UserInfoPage extends StatelessWidget {
  late User userInfo;

  UserInfoPage({required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
        centerTitle: true,
      ),
      body: Card(
          margin: EdgeInsets.all(16),
          child: Column(
            children: [
              ListTile(
                  title: Text(
                    '${userInfo.name}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  subtitle: Visibility(
                      visible: _isStoryEmpty(),
                      child: Text('${userInfo.story}')),
                  leading: Icon(Icons.person, color: Colors.black),
                  trailing: Visibility(
                      visible: _isCountryEmpty(),
                      child: Text('${userInfo.country}'))),
              Visibility(
                visible: _isPhoneEmpty(),
                child: ListTile(
                  title: Text('${userInfo.phone}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )),
                  leading: Icon(
                    Icons.call,
                    color: Colors.black,
                  ),
                ),
              ),
              Visibility(
                visible: _isEmailEmpty(),
                child: ListTile(
                  title: Text('${userInfo.email}',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      )),
                  leading: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  bool _isEmailEmpty() {
    if (userInfo.email!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool _isPhoneEmpty() {
    if (userInfo.phone!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool _isStoryEmpty() {
    if (userInfo.story!.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool _isCountryEmpty() {
    if (userInfo.country == "Choose your country") {
      return false;
    } else {
      return true;
    }
  }
}
