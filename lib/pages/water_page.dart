import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pay_cost/model/pay_info_model.dart';
import 'package:pay_cost/pages/city_page.dart';
import 'package:pay_cost/pages/pay_page.dart';

class WaterPage extends StatefulWidget {
  @override
  _WaterPageState createState() => _WaterPageState();
}

class _WaterPageState extends State<WaterPage> {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController _paymentProjectController = TextEditingController();
  TextEditingController _payCostUnitController = TextEditingController();
  String _selectCity = '深圳市';
  bool _autoValidate = false;
  String _userId;

  String validatorUser(value) {
    if (value.isEmpty) {
      return '用户编号不能为空';
    }

    return null;
  }

  void submitRegisterForm() {
    if (registerFormKey.currentState.validate()) {
      registerFormKey.currentState.save();
      debugPrint('uname: ${_userId}');

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PayPage(),
          settings: RouteSettings(
            arguments: PayInfoModel(
                type: '水费',
                city: _selectCity,
                project: _payCostUnitController.text,
                unit: _paymentProjectController.text,
                userId: _userId),
          )));
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
        textAlign: TextAlign.center,
      ),
      height: 160,
    ).show(context);
  }

  @override
  void initState() {
    super.initState();
    _paymentProjectController.text = '深圳市水费';
    _payCostUnitController.text = '深圳水务集团';
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
        title: Text('水费'),
        elevation: 0.0,
      ),
      body: Container(
        child: Column(
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
                    height: 460,
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
                          Text(
                            '水费',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 15),
                          ),
                          Divider(
                              height: 1.0, indent: 0.0, color: Colors.black26),
                          Padding(
                            padding: EdgeInsets.only(top: 20),
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
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      FlatButton.icon(
                                        label: Text(
                                          _selectCity,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 18,
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
                                                  ? '深圳市'
                                                  : value.name);
                                              if (_selectCity == '深圳市') {
                                                _payCostUnitController.text =
                                                    '深圳市水费';
                                                _paymentProjectController.text =
                                                    '深圳水务集团';
                                              } else if (_selectCity == '广州市') {
                                                _payCostUnitController.text =
                                                    '广州市水费';
                                                _paymentProjectController.text =
                                                    '广州水务集团';
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
                                    labelStyle: TextStyle(fontSize: 18),
                                    helperText: '',
                                  ),
                                  onSaved: (value) {},
                                  enabled: false,
                                ),
                                TextFormField(
                                  controller: _payCostUnitController,
                                  decoration: InputDecoration(
                                    labelText: '收费单位',
                                    labelStyle: TextStyle(fontSize: 18),
                                    helperText: '',
                                  ),
                                  onSaved: (value) {},
                                  enabled: false,
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                    labelText: '用户编号',
                                    labelStyle: TextStyle(fontSize: 18),
                                    helperText: '',
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
              padding: EdgeInsets.only(top: 12),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        '下一步',
                        style: TextStyle(fontSize: 20),
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
