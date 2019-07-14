import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于'),
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/images/morentouxiang.png',
                    width: 80,
                    height: 80,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    '黑蚂蚁缴费V1.0.1',
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                print('v1.0.1');
              },
              child: Container(
                height: 80,
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
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          Text(
                            '用户协议',
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
          ],
        ),
      ),
    );
  }
}
