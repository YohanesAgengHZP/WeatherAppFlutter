import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather_app/HomePage.dart';


class login_screen extends StatefulWidget{
  const login_screen({key}) : super(key: key);

  @override
  _loginscreenState createState() => _loginscreenState();
}
class _loginscreenState extends State<login_screen>{
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();

  SharedPreferences logindata;
  bool userbaru;

  @override
  void initState() {
    super.initState();
    checkIfAlreadyLogin();
  }

  void checkIfAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    userbaru = (logindata.getBool('login') ?? true);
    print(userbaru);
    if (userbaru == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  @override
  void dispose() {
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget buildUsername() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Username',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight:  FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller: username_controller,
            keyboardType: TextInputType.text,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.accessibility,
                color: Color(0xff5ac18e),
              ),
              hintText: 'Username',
              hintStyle: TextStyle(
                  color: Colors.black38
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight:  FontWeight.bold
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5,
                    offset: Offset(0,2)
                )
              ]
          ),
          height: 60,
          child: TextField(
            controller: password_controller,
            obscureText: true,
            style: TextStyle(
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14),
              prefixIcon: Icon(
                Icons.lock,
                color: Color(0xff5ac18e),
              ),
              hintText: 'Password',
              hintStyle: TextStyle(
                  color: Colors.black38
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBtnLogin(){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      width: 100,
      child: ElevatedButton(
        onPressed: () {
          String username = username_controller.text;
          String password = password_controller.text;
          if (username != '' && password != '') {
            print("Success");
            logindata.setBool('login', false);
            logindata.setString('username', username);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomePage()));
          }
        },
        child: Text(
          'Login',
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width:  double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0x66c1d0f7),
                        Color(0x99c1d0f7),
                        Color(0xccc1d0f7),
                        Color(0xffc1d0f7),
                      ],
                    )
                ),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 120
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Login Here',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Image.asset('assets/img1.png'),
                      SizedBox(height: 50),
                      buildUsername(),
                      SizedBox(height: 15),
                      buildPassword(),
                      buildBtnLogin(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}