import 'package:flutter/material.dart';
import 'package:pay_cost/navigator/tab_navigater.dart';
import 'package:pay_cost/util/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _loginKey = GlobalKey<FormState>();
  String uName, uPwd;
  bool autoValidate = false;
  bool _loading = false;

  void submitRegisterForm() {
    if (_loginKey.currentState.validate()) {
      _loginKey.currentState.save();
      _onRefresh();
    } else {
      setState(() {
        autoValidate = true;
      });
    }
  }

  String validatorName(value) {
    if (value.isEmpty) {
      return '用户名不能为空';
    }

    return null;
  }

  String validatorPwd(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    }

    return null;
  }

  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
      autoValidate = true;
    });
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _loading = !_loading;
        autoValidate = true;
      });
      if(uName == 'CYUD201902469876' && uPwd == 'cyjf0016425') {
        _save();
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => TabNavigator()));
      }else{
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
        Toast.show(context, "用户名或密码不正确");
      }
    });
  }

  Future<void> _save() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('name', uName);
    prefs.setString('pwd', uPwd);

    _prefs.then((SharedPreferences prefs) {
      return (prefs.getString('name') ?? 'null');
    });
  }

  save() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', uName);
    prefs.setString('pwd', uPwd);
  }

  Widget _childLayout() {
    if (_loading) {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(padding: EdgeInsets.only(top: 16),),
              Text('登录中...'),
            ],
          ),
        ),
      );
    } else {
      return ListView(
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
                          icon: Icon(
                            Icons.person,
                          ),
                        ),
                        onSaved: (value) {
                          uName = value;
                        },
                        validator: validatorName,
                        autovalidate: autoValidate,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: '密码',
                          icon: Icon(
                            Icons.lock,
                          ),
                        ),
                        onSaved: (value) {
                          uPwd = value;
                        },
                        validator: validatorPwd,
                        autovalidate: autoValidate,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          child: Text(
                            '登 录',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          elevation: 0.0,
                          onPressed: submitRegisterForm,
                          shape: StadiumBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _childLayout(),
    );
  }
}
