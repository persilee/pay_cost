import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pay_cost/dao/home_dao.dart';
import 'package:pay_cost/model/home_model.dart';
import 'package:easy_dialog/easy_dialog.dart';
import 'package:pay_cost/pages/electricity_page.dart';
import 'package:pay_cost/pages/fuel_gas_page.dart';
import 'package:pay_cost/pages/water_page.dart';

const APPBAR_SCROLL_OFFSET = 160;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'assets/images/banner.png',
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
                          autoplay: false,
                          autoplayDelay: 6000,
                          autoplayDisableOnInteraction: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Image.asset(
                              _imageUrls[index],
                              fit: BoxFit.fill,
                            );
                          },
                          pagination: SwiperPagination(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 95, 20, 20),
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
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '常规缴费',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 12),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WaterPage()),
                                          );
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/shuifei.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '水费',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ElectricityPage()));
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/dianfei.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '电费',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FuelGasPage()));
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/ranqifei.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '燃气费',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/shoujichongzhi.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '手机充值',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54,
                                                letterSpacing: 1,
                                              ),
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
                        padding: EdgeInsets.fromLTRB(20, 240, 20, 20),
                        child: Container(
                          height: 290,
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
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '便捷缴费',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WaterPage()),
                                          );
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/shuifei.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '水费',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ElectricityPage()));
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/dianfei.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '电费',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FuelGasPage()));
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/ranqifei.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '燃气费',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/youxiandianshi.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '有线电视',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/wuye.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '物业费',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/tongxun.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '通讯费',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/jiaoyu.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '教育考试',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/shoujichongzhi.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 6)),
                                            Text(
                                              '手机充值',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20),
                                ),
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/dangfeijiaona.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10)),
                                            Text(
                                              '党费',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          showAlertDialog(context);
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            Image(
                                              width: 36,
                                              height: 36,
                                              image: AssetImage(
                                                  'assets/images/qita.png'),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10)),
                                            Text(
                                              '其他',
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black54,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          child: Text(''),
                                        ))
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
