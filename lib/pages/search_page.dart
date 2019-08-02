import 'package:flutter/material.dart';
import 'package:pay_cost/pages/login_page.dart';
import '../model/pay_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pay_cost/util/toast.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

bool _visible = false;

class _SearchPageState extends State<SearchPage> {

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String _name = '',type,unit,date;
  bool _isPay = false;

  Future<Null> _onRefresh() async {
    await Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _prefs.then((SharedPreferences prefs) {
      _name = (prefs.getString('name') ?? '');
      _isPay = (prefs.getBool('isPay') ?? false);
      type = (prefs.getString('type') ?? '');
      unit = (prefs.getString('unit') ?? '');
      date = (prefs.getString('date') ?? '');

      print(_name);
      print(_isPay);
      print(date);
      if( _name == '' ) {
        Toast.show(context, "您还没有登录！");
        setState(() {
          _visible = false;
        });
        _onRefresh();
      }else{
        if(_isPay && payList.length == 0){
          payList.add(
              PayListModel(
                type: type,
                doorNo: '00061062',
                unit: unit,
                amount: '58.68',
                date: date,
                info: '缴费成功',
              )
          );
        }
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('缴费记录', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
      ),
      body: PayLostContent(),
    );
  }
}

class PayLostContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (payList.length == 0) {
      return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/images/record.png', width: 80, height: 80,),
            Padding(padding: EdgeInsets.only(top: 10),),
            Text('您还没有缴费记录哦', style: TextStyle(fontSize: 16,color: Colors.grey),),
          ],
        ),
      );
    }else{
      return Offstage(
        offstage: !_visible,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverSafeArea(
              sliver: SliverPadding(
                padding: EdgeInsets.all(6),
                sliver: SliverListPay(),
              ),
            ),
          ],
        ),
      );
    }
  }
}

class SliverListPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(top: 4),
          child: Padding(
            padding: EdgeInsets.only(bottom: 4),
            child: Material(
                elevation: 16,
                shadowColor: Colors.grey.withOpacity(0.1),
                type: MaterialType.card,
                borderRadius: BorderRadius.circular(2.0),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                  child: Column(
                    children: <Widget>[
                      Padding(padding: EdgeInsets.only(bottom: 6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(payList[index].unit, style: TextStyle(color: Colors.black54),),
                          Text(payList[index].date, style: TextStyle(color: Colors.black54),)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              '${payList[index].type}', style: TextStyle(fontSize: 16, fontWeight:FontWeight.bold, color: Colors.black87),),
                          Text('- ￥${payList[index].amount}', style: TextStyle(fontSize: 16, fontWeight:FontWeight.bold, color: Colors.black87),)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('户号: ${payList[index].doorNo}', style: TextStyle(color: Colors.black54),),
                          Text(payList[index].info, style: TextStyle(fontSize: 14, color: Color.fromRGBO(0, 180, 184, 1)),)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 6)),
                    ],
                  ),
                )),
          ),
        );
      }, childCount: payList.length),
    );
  }
}
