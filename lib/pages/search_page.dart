import 'package:flutter/material.dart';
import '../model/pay_list_model.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('缴费记录'),
      ),
      body: CustomScrollView(
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

class SliverListPay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          child: Padding(
            padding: EdgeInsets.only(bottom: 6),
            child: Material(
                elevation: 16,
                shadowColor: Colors.grey.withOpacity(0.1),
                type: MaterialType.card,
                borderRadius: BorderRadius.circular(2.0),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('户号: ${payList[index].doorNo}'),
                          Text(payList[index].date, style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                              '${payList[index].type} - ${payList[index].amount}元', style: TextStyle(fontSize: 20, fontWeight:FontWeight.bold),),
                          Text(payList[index].info, style: TextStyle(fontSize: 16, color: Colors.green, fontWeight: FontWeight.bold),)
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 6)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(payList[index].unit),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
        );
      }, childCount: payList.length),
    );
  }
}
