import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pay_cost/model/pay_info_model.dart';
import 'package:pay_cost/util/toast.dart';
import '../model/pay_list_model.dart';

class PayResult extends StatefulWidget {
  @override
  _PayResultState createState() => _PayResultState();
}

class _PayResultState extends State<PayResult> {
  final registerFormKey = GlobalKey<FormState>();
  PayListModel _payInfo;

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

  Widget _iconStr(_payInfo) {
    if(_payInfo.info == '缴费成功'){
      return Image(
        width: 26,
        height: 26,
        image:
        AssetImage('assets/images/isuccess.png'),
      );
    }else if(_payInfo.info == '缴费失败'){
      return Image(
        width: 26,
        height: 26,
        image:
        AssetImage('assets/images/failure.png'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    /*获取传递过来的参数*/
    _payInfo = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('支付结果'),
        elevation: 0.0,
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 190,
                      decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _iconStr(_payInfo),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                            ),
                            Text(
                              _payInfo.info == '缴费成功' ? '支付成功' :'支付失败',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                  letterSpacing: 3
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 110, 20, 20),
                      child: Container(
                        height: 200,
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
                              Padding(
                                padding: EdgeInsets.only(top: 20),
                              ),
                              Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '支付时间',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black45),
                                    ),
                                    Text(
                                      _payInfo.info == '缴费成功' ? _payInfo.date :'—',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 1.0, indent: 0.0, color: Colors.black26),
                              Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '支付方式',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black45),
                                    ),
                                    Text(
                                      _payInfo.info == '缴费成功' ? '银联支付' :'—',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                  height: 1.0, indent: 0.0, color: Colors.black26),
                              Container(
                                height: 40,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '支付金额',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black45),
                                    ),
                                    Text(
                                      _payInfo.info == '缴费成功' ? _payInfo.amount :'—',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
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
                            '返 回',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
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
        ],
      ),
    );
  }
}
