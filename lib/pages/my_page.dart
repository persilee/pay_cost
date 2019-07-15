import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pay_cost/pages/about_page.dart';
import 'package:pay_cost/pages/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _myPageState = GlobalKey<ScaffoldState>();

  Future<void> _launchInWebViewOrVC(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _myPageState,
      appBar: AppBar(
        elevation: 0.0,
        title: Text('我的', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        iconTheme: IconThemeData(size: 18),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 26),
                  ),
                  Image.asset(
                    'assets/images/morentouxiang.png',
                    width: 60,
                    height: 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                  ),
                  Text(
                    'gongyifu',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                EasyDialog(
                  cornerRadius: 15.0,
                  fogOpacity: 0.1,
                  height: 200,
                  contentPadding: EdgeInsets.only(top: 12.0),
                  contentList: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/huabanfuben.png',
                            width: 66,
                            height: 66,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '0755-28246827',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0))),
                      child: FlatButton(
                        onPressed: () {
                          _makePhoneCall('tel:28246827');
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "拨号",
                          textScaleFactor: 1.3,
                        ),
                      ),
                    ),
                  ],
                ).show(context);
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(.6, 1.2),
                      blurRadius: .6,
                    ),
                  ],
                ),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/huabanfuben.png',
                            height: 18,
                            width: 18,
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Text(
                            '客服电话',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AboutPage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(.6, 1.2),
                      blurRadius: .6,
                    ),
                  ],
                ),
                height: 60,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 6),
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Image.asset(
                            'assets/images/guanyu.png',
                            height: 18,
                            width: 18,
                          ),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          Text(
                            '关于畅饮缴费',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 16,
                    )
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(1.0, 1.2),
                    blurRadius: .6,
                  ),
                ],
              ),
              height: 50,
              margin: EdgeInsets.fromLTRB(0, 40, 0, 6),
              child: Material(
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '退出登录',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
