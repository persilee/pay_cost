import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pay_cost/model/pay_info_model.dart';
import 'package:pay_cost/pages/city_page.dart';
import 'package:pay_cost/pages/pay_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pay_cost/util/toast.dart';

class FuelGasPage extends StatefulWidget {
  @override
  _FuelGasPageState createState() => _FuelGasPageState();
}

class _FuelGasPageState extends State<FuelGasPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController _paymentProjectController = TextEditingController();
  TextEditingController _payCostUnitController = TextEditingController();
  String _selectCity = '金华市';
  bool _autoValidate = false;
  String _userId;
  bool _isPay = false;
  String _name = '';

  String validatorUser(value) {
    if (value.isEmpty) {
      return '用户编号不能为空';
    }else if (value.length < 8) {
      return '用户编号长度不能小于8位';
    }else if (value.length > 10) {
      return '用户编码长度不能大于10位';
    }

    return null;
  }

  void submitRegisterForm() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      debugPrint('uname: ${_userId}');

      _prefs.then((SharedPreferences prefs) {
        _isPay = (prefs.getBool('isPay') ?? false);
        _name = (prefs.getString('name') ?? '');
        print(_name == '');
        print(_isPay);
        if(_userId != '00061062') {
          Toast.show(context, "用户编号不存在");
        }

        if(_userId == '00061062' && !_isPay && _name != ''){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PayPage(),
              settings: RouteSettings(
                arguments: PayInfoModel(
                    type: '燃气费',
                    city: _selectCity,
                    project: _paymentProjectController.text,
                    unit: _payCostUnitController.text,
                    userId: _userId),
              ),
            ),
          );
        }else if(_name == ''){
          Toast.show(context, "您还没有登录！");
        } else {
          EasyDialog(
            description: Text(
              "当前户号暂未查询到账单",
              textScaleFactor: 1.2,
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            height: 140,
          ).show(context);
        }
      });

//      EasyDialog(
//        description: Text(
//          "当前户号暂未查询到账单",
//          textScaleFactor: 1.2,
//          style: TextStyle(fontSize: 14, color: Colors.black54),
//          textAlign: TextAlign.center,
//        ),
//        height: 140,
//      ).show(context);

//      Navigator.of(context).push(
//        MaterialPageRoute(
//          builder: (context) => PayPage(),
//          settings: RouteSettings(
//            arguments: PayInfoModel(
//                type: '水费',
//                city: _selectCity,
//                project: _payCostUnitController.text,
//                unit: _paymentProjectController.text,
//                userId: _userId),
//          ),
//        ),
//      );
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void showAlertDialog(BuildContext context) {
    EasyDialog(
      description: Text(
        "功能暂未开放，敬请期待",
        textScaleFactor: 1.2,
        style: TextStyle(fontSize: 14, color: Colors.black54),
        textAlign: TextAlign.center,
      ),
      height: 140,
    ).show(context);
  }

  @override
  void initState() {
    super.initState();
    _paymentProjectController.text = '华威燃气';
    _payCostUnitController.text = '金华市华威燃气有限公司';
    _paymentProjectController.addListener(() {
      print(_paymentProjectController.value);
    });
    _payCostUnitController.addListener(() {
      print(_payCostUnitController.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('燃气费', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 160,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 60, 20, 20),
                  child: Container(
                    height: 420,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset.zero,
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  width: 20,
                                  height: 20,
                                  image: AssetImage('assets/images/ranqifei.png'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  '燃气费',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Divider(
                              height: 1.0, indent: 0.0, color: Colors.black26),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                          ),
                          Form(
                            key: registerFormKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '缴费城市：',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      FlatButton.icon(
                                        label: Text(
                                          _selectCity,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
                                        icon: Icon(Icons.arrow_drop_down),
                                        highlightColor: Colors.transparent,
                                        onPressed: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      CityPage()))
                                              .then((value) {
                                            setState(() {
                                              _selectCity = (value == null
                                                  ? '金华市'
                                                  : value.name);
                                              if (_selectCity == '金华市') {
                                                _payCostUnitController.text =
                                                '金华市华威燃气有限公司';
                                                _paymentProjectController.text =
                                                '华威燃气';
                                              }else if (_selectCity == '深圳市') {
                                                _payCostUnitController.text =
                                                    '深圳燃气集团股份有限公司';
                                                _paymentProjectController.text =
                                                    '深圳市燃气费';
                                              } else {
                                                _payCostUnitController.text =
                                                    '';
                                                _paymentProjectController.text =
                                                    '';
                                                showAlertDialog(context);
                                              }
                                            });
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                TextFormField(
                                  controller: _paymentProjectController,
                                  decoration: InputDecoration(
                                    labelText: '缴费项目',
                                    labelStyle: TextStyle(fontSize: 16),
                                    helperText: '',
                                  ),
                                  onSaved: (value) {},
                                  enabled: false,
                                ),
                                TextFormField(
                                  controller: _payCostUnitController,
                                  decoration: InputDecoration(
                                    labelText: '收费单位',
                                    labelStyle: TextStyle(fontSize: 16),
                                    helperText: '',
                                  ),
                                  onSaved: (value) {},
                                  enabled: false,
                                ),
                                TextFormField(
                                  autofocus: false,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    labelText: '用户编号',
                                    labelStyle: TextStyle(fontSize: 16),
                                    helperText: '',
                                    hintText: '8-10位用户编号',
                                  ),
                                  onSaved: (value) {
                                    _userId = value;
                                  },
                                  validator: validatorUser,
                                  autovalidate: _autoValidate,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 6),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                      child: Text(
                        '下一步',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: submitRegisterForm,
                      splashColor: Colors.grey[200],
                      color: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(60))),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
