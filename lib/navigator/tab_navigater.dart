import 'package:flutter/material.dart';
import 'package:pay_cost/pages/home_page.dart';
import 'package:pay_cost/pages/login_page.dart';
import 'package:pay_cost/pages/my_page.dart';
import 'package:pay_cost/pages/search_page.dart';

class TabNavigator extends StatefulWidget {
  @override
  _TabNavigatorState createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = Colors.blue;
  int _currentIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          HomePage(),
          SearchPage(),
          MyPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          elevation: 16,
          iconSize: 36,
          onTap: (index) {
            _controller.jumpToPage(index);
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Image(
                width: 34,
                height: 34,
                image: AssetImage('assets/images/shouye.png'),
              ),
              activeIcon: Image(
                width: 34,
                height: 34,
                image: AssetImage('assets/images/shouye.png'),
              ),
              title: Text(
                '首页',
                style: TextStyle(
                  color: _currentIndex != 0 ? _defaultColor : _activeColor,
                  fontSize: 14,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image(
                width: 34,
                height: 34,
                image: AssetImage('assets/images/jilu.png'),
              ),
              activeIcon: Image(
                width: 34,
                height: 34,
                image: AssetImage('assets/images/jilu.png'),
              ),
              title: Text(
                '记录',
                style: TextStyle(
                  color: _currentIndex != 1 ? _defaultColor : _activeColor,
                  fontSize: 14,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Image(
                width: 34,
                height: 34,
                image: AssetImage('assets/images/wode-copy.png'),
              ),
              activeIcon: Image(
                width: 34,
                height: 34,
                image: AssetImage('assets/images/wode-copy.png'),
              ),
              title: Text(
                '我的',
                style: TextStyle(
                  color: _currentIndex != 2 ? _defaultColor : _activeColor,
                  fontSize: 14,
                ),
              ),
            ),
          ]),
    );
  }
}
