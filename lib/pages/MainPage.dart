import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystore/bloc/navigation_bloc/navigation_bloc.dart';
import 'package:mystore/pages/dashboard_layout/menu.dart';
import 'package:mystore/pages/dashboard_layout/dashboard.dart';
import 'package:mystore/pages/ui/messages_page.dart';
import 'package:mystore/pages/ui/my_cards.dart';
import 'package:mystore/pages/ui/utility_bills_page.dart';

final Color backgroundColor = Color(0xFF4A4A58);
class MainPage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onMenuTap(){
    setState(() {
      if (isCollapsed)
        _controller.forward();
      else
        _controller.reverse();

      isCollapsed = !isCollapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocProvider<NavigationBloc>(
        create : (context) => NavigationBloc(onMenuTap: onMenuTap),
        child: Stack(
          children: <Widget>[
            BlocBuilder<NavigationBloc, NavigationStates>(
              builder: (context, NavigationStates navigationState) {
                return Menu(
                    slideAnimation: _slideAnimation,
                    menuAnimation : _menuScaleAnimation,
                    selectedIndex : findSelectedIndex(navigationState),
                );
              },
            ),
            Dashboard(
              duration: duration,
              onMenuTap: onMenuTap,
              scaleAnimation: _scaleAnimation,
              isCollapsed: isCollapsed,
              screenWidth: screenWidth,
              child: BlocBuilder<NavigationBloc, NavigationStates>(builder: (context,
                  NavigationStates navigationState,) {
                return navigationState as Widget;
              }),
            ),
          ],
        ),
      ),
    );
  }

  int findSelectedIndex(NavigationStates navigationState) {
      if (navigationState is MyCardsPage) {
        return 0;
      } else if (navigationState is MessagesPage) {
        return 1;
      } else if (navigationState is UtilityBills) {
        return 2;
      } else {
        return 0;
      }
  }
}