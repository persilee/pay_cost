import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pay_cost/dao/home_dao.dart';
import 'package:pay_cost/model/home_model.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:pay_cost/pages/electricity_page.dart';
import 'package:pay_cost/pages/fuel_gas_page.dart';
import 'package:pay_cost/pages/water_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

const APPBAR_SCROLL_OFFSET = 160;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg',
    'https://dimg04.c-ctrip.com/images/300h0u000000j05rnD96B_C_500_280.jpg',
    'https://dimg03.c-ctrip.com/images/fd/tg/g1/M03/7E/19/CghzfVWw6OaACaJXABqNWv6ecpw824_C_500_280_Q90.jpg'
  ];

  double appBarAlpha = 0;
  bool _loading = true;

  void _onScroll(double pixels) {
    double alpha = pixels / APPBAR_SCROLL_OFFSET;

    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<Null> _handleRefresh() async {
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        _loading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _loading = false;
      });
    }
    return null;
  }

  Future<String> get() async {
    var userName;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = await prefs.getString('name');
    print(userName);
    return userName;
  }

  void showAlertDialog(BuildContext context) {
    Future<String> userName = get();
    userName.then((String userName) {
      Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("数据获取成功：$userName")));
    });
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            child: NotificationListener(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
              },
              child: ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Opacity(
                        opacity: appBarAlpha,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text('首页'),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 170,
                        child: Swiper(
                          itemCount: _imageUrls.length,
                          autoplay: true,
                          autoplayDelay: 6000,
                          autoplayDisableOnInteraction: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 120, 20, 20),
                        child: Container(
                          height: 130,
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
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '常规缴费',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => WaterPage()),
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage('assets/images/shuifei.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '水费',
                                              style: TextStyle(fontSize: 14, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectricityPage()));
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage('assets/images/dianfei.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '电费',
                                              style: TextStyle(fontSize: 14, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FuelGasPage()));
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage('assets/images/ranqifei.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '燃气费',
                                              style: TextStyle(fontSize: 14, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage('assets/images/shoujichongzhi.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top:6)),
                                            Text(
                                              '手机充值',
                                              style: TextStyle(fontSize: 14, color: Colors.black54, letterSpacing: 1,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 250, 20, 20),
                        child: Container(
                          height: 300,
                          child: Container(
                            padding: EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  '便捷缴费',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) => WaterPage()),
                                        );
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/shuifei.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '水费',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => ElectricityPage()));
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/dianfei.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '电费',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => FuelGasPage()));
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/ranqifei.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '燃气费',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/youxiandianshi.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '有线电视',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 1,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/wuye.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '物业费',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/tongxun.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '通讯费',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 1,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/jiaoyu.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '教育考试',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 1,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.all(6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/shoujichongzhi.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 6)),
                                            Text(
                                              '手机充值',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 1,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 6),
                                ),
                                Row(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.fromLTRB(12, 12, 22, 10),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/dangfeijiaona.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 10)),
                                            Text(
                                              '党费',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showAlertDialog(context);
                                      },
                                      child:Padding(
                                        padding: EdgeInsets.fromLTRB(24, 10, 0, 6),
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 32,
                                              height: 32,
                                              image: AssetImage('assets/images/qita.png'),
                                            ),
                                            Padding(padding: EdgeInsets.only(top: 10)),
                                            Text(
                                              '其他',
                                              style: TextStyle(fontSize: 12, color: Colors.black54, letterSpacing: 2,),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
