import 'package:easy_dialog/easy_dialog.dart';
import 'package:flutter/material.dart';
import 'package:pay_cost/model/pay_info_model.dart';
import 'package:pay_cost/pages/city_page.dart';
import 'package:pay_cost/pages/pay_page.dart';
import 'package:direct_select/direct_select.dart';

class ElectricityPage extends StatefulWidget {
  @override
  _ElectricityPageState createState() => _ElectricityPageState();
}

class _ElectricityPageState extends State<ElectricityPage> {
  final registerFormKey = GlobalKey<FormState>();
  TextEditingController _paymentProjectController = TextEditingController();
  TextEditingController _payCostUnitController = TextEditingController();
  String _selectCity = '金华市';
  bool _autoValidate = false;
  String _userId;
  bool _visible = true;
  double _height = 410;
  final elements1 = [
    "罗湖区",
    "福田区",
    "南山区",
    "宝安区",
    "龙岗区",
    "盐田区",
    "龙华区",
    "坪山区",
    "光明区",
  ];
  int selectedIndex1 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
      title: val,
    ))
        .toList();
  }

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

      EasyDialog(
        description: Text(
          "当前户号暂未查询到账单",
          textScaleFactor: 1.2,
          style: TextStyle(fontSize: 14, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
        height: 140,
      ).show(context);

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
    _paymentProjectController.text = '浙江省电费';
    _payCostUnitController.text = '国网浙江省电力公司';
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
        title: Text('电费',  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
        elevation: 0.0,
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 120,
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                  child: Container(
                    height: _height,
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
                                  image: AssetImage('assets/images/dianfei.png'),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 10),
                                ),
                                Text(
                                  '电费',
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
                            padding: EdgeInsets.only(top: 6),
                          ),
                          Form(
                            key: registerFormKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        '缴费城市：',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                      FlatButton.icon(
                                        icon: Icon(Icons.arrow_drop_down),
                                        label: Text(
                                          _selectCity,
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 16,
                                          ),
                                        ),
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
                                                _visible = true;
                                                _height = 410;
                                                _payCostUnitController.text =
                                                '浙江省电费';
                                                _paymentProjectController.text =
                                                '国网浙江省电力公司';
                                              } else if (_selectCity == '深圳市') {
                                                _visible = false;
                                                _height = 460;
                                                _payCostUnitController.text =
                                                '深圳市电费';
                                                _paymentProjectController.text =
                                                '深圳供电局';
                                              } else {
                                                _visible = true;
                                                _height = 410;
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
                                Offstage(
                                  offstage: _visible,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          '地区码：',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        DirectSelect(
                                            itemExtent: 45.0,
                                            selectedIndex: selectedIndex1,
                                            child: MySelectionItem(
                                              isForList: false,
                                              title: elements1[selectedIndex1],
                                            ),
                                            onSelectedItemChanged: (index) {
                                              setState(() {
                                                selectedIndex1 = index;
                                              });
                                            },
                                            items: _buildItems1()),
                                      ],
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    labelText: '用户编号',
                                    labelStyle: TextStyle(fontSize: 16),
                                    helperText: '',
                                    hintText: '16位用户编号',
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
              padding: EdgeInsets.only(top: 10),
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

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key key, this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46.0,
      child: isForList
          ? Padding(
        child: _buildItem(context),
        padding: EdgeInsets.all(10.0),
      )
          : Card(
        elevation: 0,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            _buildItem(context),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_drop_down),
            )
          ],
        ),
      ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: 120,
      alignment: Alignment.center,
      child: Text(title, style: TextStyle(fontSize: 16),),
    );
  }
}

