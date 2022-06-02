import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginPage.dart';

class ScreenProfile extends StatefulWidget {
  const ScreenProfile({key}) : super(key: key);

  @override
  State<ScreenProfile> createState() => _ScreenProfileState();
}

class _ScreenProfileState extends State<ScreenProfile> {
  SharedPreferences logindata;
  String username;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather app Log Out"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(26.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                logindata.setBool('login', true);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => login_screen()));
              },
              child: Text('Log Out'),
            )
          ],
        ),
      ),
    );
    ;
  }
}