import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Container(
            height: 600,
            padding: EdgeInsets.fromLTRB(40, 160, 40, 100),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    '畅饮缴费',
                    style: TextStyle(fontSize: 24, color: Colors.black54),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 18)),
                Form(
                  key: _loginKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: '用户名',
                          icon: Icon(Icons.person,),
                        ),
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: '密码',
                          icon: Icon(Icons.lock,),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
