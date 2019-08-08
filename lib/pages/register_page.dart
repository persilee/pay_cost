import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pay_cost/navigator/tab_navigater.dart';
import 'package:pay_cost/util/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _loginKey = GlobalKey<FormState>();
  String uName, uPwdOne, uPwdTwo, uCode;
  bool isPay = false;
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
  static bool isChinaPhoneLegal(String str) {
    return RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
  }

  static bool isNumAndLetter(String str) {
    return RegExp('^(?:(?=.*[a-z])(?=.*[0-9])).{8,20}\$').hasMatch(str);
  }

  String validatorPhone(value) {
    if (value.isEmpty) {
      return '手机号不能为空';
    }else if(!isChinaPhoneLegal(value)){
      return '请输入正确的手机号';
    }

    return null;
  }

  String validatorCode(value) {
    if (value.isEmpty) {
      return '验证码不能为空';
    }

    return null;
  }

  String validatorPwd(value) {
    uPwdOne = value;
    if (value.isEmpty) {
      return '密码不能为空';
    }else if(!isNumAndLetter(value)){
      return '需要8-20位英文和数字组合';
    }

    return null;
  }

  String validatorPwdTwo(value) {
    if (value.isEmpty) {
      return '密码不能为空';
    }else if(!isNumAndLetter(value)){
      return '需要8-20位英文和数字组合';
    }else if(value != uPwdOne){
      return '输入的密码不一致';
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

      Navigator.of(context).push(MaterialPageRoute(builder: (context) => TabNavigator()));
      _save();

    });
  }

  Future<void> _save() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('name', uName);
    prefs.setString('pwd', uPwdTwo);
    prefs.setBool('isPay', isPay);

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
              Text('注册成功,登录中...'),
            ],
          ),
        ),
      );
    } else {
      return ListView(
        children: <Widget>[
          Container(
            height: 800,
            padding: EdgeInsets.fromLTRB(40, 80, 40, 100),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    '注册',
                    style: TextStyle(fontSize: 24, color: Colors.black54),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 18)),
                Form(
                  key: _loginKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          labelText: '手机号',
                          icon: Icon(
                            Icons.person,
                          ),
                          hintText: '请输入您的手机号',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        onSaved: (value) {
                          uName = value;
                        },
                        validator: validatorPhone,
                        autovalidate: autoValidate,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: '验证码',
                              icon: Icon(
                                Icons.beenhere,
                              ),
                              hintText: '请输入短信验证码',
                              hintStyle: TextStyle(fontSize: 12),
                            ),
                            onSaved: (value) {
                              uCode = value;
                            },
                            validator: validatorCode,
                            autovalidate: autoValidate,
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: (){},
                              child: Text('获取验证码', style: TextStyle(color: Theme.of(context).primaryColor),),
                            ),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      TextFormField(
                        obscureText: true,
                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: '密码',
                          icon: Icon(
                            Icons.lock,
                          ),
                          hintText: '8-20位英文和数字',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        onSaved: (value) {
                          uPwdOne = value;
                        },
                        validator: validatorPwd,
                        autovalidate: autoValidate,
                      ),
                      Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 10)),
                      TextFormField(
                        obscureText: true,
                        maxLength: 20,
                        decoration: InputDecoration(
                          labelText: '确认密码',
                          icon: Icon(
                            Icons.lock,
                          ),
                          hintText: '请再次输入密码',
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                        onSaved: (value) {
                          uPwdTwo = value;
                        },
                        validator: validatorPwdTwo,
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
                            '提 交',
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
