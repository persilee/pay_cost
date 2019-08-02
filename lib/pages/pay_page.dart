import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pay_cost/model/pay_info_model.dart';
import 'package:pay_cost/pages/pay_result.dart';
import 'package:pay_cost/util/toast.dart';
import '../model/pay_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:pay_cost/model/pay_qr_model.dart';
import 'dart:convert';

class PayPage extends StatefulWidget {
  @override
  _PayPageState createState() => _PayPageState();
}

class _PayPageState extends State<PayPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final registerFormKey = GlobalKey<FormState>();
  PayInfoModel _payInfo;
  String _choice = 'Nothing';
  String _payVal = 'union';
  bool _loading = false;
  bool _isPay = false;
  var url = "https://www.googleapis.com/books/v1/volumes?q={http}";

  String validatorPwd(value) {
    if (value.isEmpty) {
      return 'pwd is required';
    }
    return null;
  }

  Future<Null> _onRefresh() async {
    setState(() {
      _loading = !_loading;
    });
    Navigator.pop(context);
    _pay();
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

   _pay() async {

     var date = new DateTime.now();
     String timestamp = "${date.year.toString()}-${date.month.toString().padLeft(2,'0')}-${date.day.toString().padLeft(2,'0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
     print(timestamp);

//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => PayResult(),
//         settings: RouteSettings(
//           arguments:
//           PayListModel(
//            type: _payInfo.type,
//            doorNo: '00061062',
//            unit: _payInfo.unit,
//            amount: '58.68',
//            date: timestamp,
//            info: '缴费成功',
//          )
//         ),
//       ),
//     );
    if(payList.length > 0) {
      setState(() {
        _loading = !_loading;
      });
      Toast.show(context, "支付错误");
    }else{
//      payList.add(
//          PayListModel(
//            type: _payInfo.type,
//            doorNo: '00061062',
//            unit: _payInfo.unit,
//            amount: '58.68',
//            date: timestamp,
//            info: '缴费成功',
//          )
//      );
      _setPay(timestamp);
      var params = Map<String, String>();
      params["merchId"] = "15811813135";
      params["amount"] = "58.68";
      params["scanCodeType"] = "12";
      params["version"] = "1.2";
      var url = 'http://api.worepay.com/app/scanpay/unionQrpay.do?merchId=15811813135&amount=1&scanCodeType=12&version=1.2';
      var response = await http.post(url);

      Map<String, dynamic> jsonMap = json.decode(response.body);

      QrModel qr = QrModel.fromJson(jsonMap);
      print('country name is:${qr.data.qrCode}');

      setState(() {
        _loading = !_loading;
      });

      launch(qr.data.qrCode);
      
    }
  }


  Future<void> _setPay(String timestamp) async {
    final SharedPreferences prefs = await _prefs;
//    prefs.setBool('isPay', true);
    prefs.setString('type', _payInfo.type);
    prefs.setString('unit', _payInfo.unit);
    prefs.setString('date', timestamp);
  }

  Future _openModalBottomSheet() async {
    final option = await showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () { return false; },
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
              height: 200.0,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '请选择支付方式',
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.close),
                        color: Colors.black54,
                        iconSize: 20,
                        highlightColor: Colors.white,
                        splashColor: Colors.grey[100],
                      ),
                    ],
                  ),
                  Divider(height: 1.0, indent: 0.0, color: Colors.black26),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Wrap(
                            spacing: 6,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: <Widget>[
                              Image(
                                width: 32,
                                height: 32,
                                image: AssetImage('assets/images/unionPay.png'),
                              ),
                              Text('银联支付'),
                            ],
                          ),
                          Wrap(
                            children: <Widget>[
                              Radio(
                                  value: 'union',
                                  groupValue: _payVal,
                                  activeColor: Theme.of(context).primaryColor,
                                  onChanged: (value) {
                                    setState(() {
                                      _payVal = value;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
//                  Divider(height: 1.0, indent: 0.0, color: Colors.black26),
//                  Expanded(
//                    child: GestureDetector(
//                      onTap: () {},
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Wrap(
//                            spacing: 6,
//                            crossAxisAlignment: WrapCrossAlignment.center,
//                            children: <Widget>[
//                              Image(
//                                width: 32,
//                                height: 32,
//                                image:
//                                AssetImage('assets/images/wechatPay_off.png'),
//                              ),
//                              Text(
//                                '微信支付',
//                                style: TextStyle(color: Colors.grey),
//                              ),
//                            ],
//                          ),
//                          Wrap(
//                            children: <Widget>[
//                              Radio(
//                                value: '',
//                                groupValue: null,
//                                onChanged: (value) {
//                                  Toast.show(context, "该业务暂未开通");
//                                },
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                  Divider(height: 1.0, indent: 0.0, color: Colors.black26),
//                  Expanded(
//                    child: GestureDetector(
//                      onTap: () {},
//                      child: Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Wrap(
//                            spacing: 6,
//                            crossAxisAlignment: WrapCrossAlignment.center,
//                            children: <Widget>[
//                              Image(
//                                width: 32,
//                                height: 32,
//                                image: AssetImage('assets/images/aliPay_off.png'),
//                              ),
//                              Text(
//                                '支付宝支付',
//                                style: TextStyle(color: Colors.grey),
//                              ),
//                            ],
//                          ),
//                          Wrap(
//                            children: <Widget>[
//                              Radio(
//                                value: '',
//                                groupValue: null,
//                                activeColor: Theme.of(context).primaryColor,
//                                onChanged: (value) {
//                                  Toast.show(context, "该业务暂未开通");
//                                },
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                          child: Text(
                            '确定支付 ￥58.68',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () {
                            _onRefresh();
                          },
                          splashColor: Colors.grey[200],
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });

    switch (option) {
      case 'A':
        setState(() {
          _choice = 'A';
        });
        break;
      case 'B':
        setState(() {
          _choice = 'B';
        });
        break;
      case 'C':
        setState(() {
          _choice = 'C';
        });
        break;
      default:
    }
  }

  Widget _childLayout() {
    if(_loading) {
      return Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(padding: EdgeInsets.only(top: 16),),
              Text('正在跳转支付页面...'),
            ],
          ),
        ),
      );
    }else{
      return Container(
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
                    height: 300,
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
                      padding: EdgeInsets.fromLTRB(26, 15, 26, 15),
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
                                  image:
                                  AssetImage('assets/images/shuifei.png'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  '水费',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
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
                          Container(
                            height: 72,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '应缴金额',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black45),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '58.68',
                                      style: TextStyle(
                                          fontSize: 36,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      '（含违约金 5.6 元）',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black45,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '缴费单位',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black45),
                                ),
                                Text(
                                  _payInfo.unit,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '缴费户号',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black45),
                                ),
                                Text(
                                  _payInfo.userId,
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  '户名',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black45),
                                ),
                                Text(
                                  '**付',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black87),
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
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                      child: Text(
                        '缴 费',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      onPressed: _openModalBottomSheet,
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
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /*获取传递过来的参数*/
    _payInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('${_payInfo.type}账单'),
        elevation: 0.0,
      ),
      body: _childLayout(),
    );
  }
}
