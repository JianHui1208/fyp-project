import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../gen/assets.gen.dart';
import '../../routes/route.dart';

import 'item_number.dart';
import 'search_bar.dart';
import 'add_item.dart';
import 'stock_in_out.dart';
import 'find_near_shop.dart';
import 'find_service.dart';
import 'home_header.dart';
import 'trending.dart';
import '../../widgets/bottom_navigation.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  var _userInfo = 'emptyUserInfo';
  var _greeting = 'Have a nice day';

  String? username;
  String? greeting;

  // home screen show username
  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    String userInfo = prefs.getString('user_data') ?? '';
    // username = 'admin';
    dynamic userObj = jsonDecode(userInfo);
    username = userObj['response']['user']['username'];

    var hour = DateTime.now().hour;
    if (hour <= 12) {
      greeting = 'Good Morning';
    } else if (hour <= 15) {
      greeting = 'Good Afternoon';
    } else if (hour <= 18) {
      greeting = 'Good Evening';
    } else if (hour <= 24) {
      greeting = 'Good Night';
    }

    setState(() {
      _userInfo = username ?? '';
      _greeting = greeting ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    // getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavigation(currentIndex: 0),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(RouteList.booking);
            },
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.grey),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(RouteList.booking);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              ItemNumber(),
              SearchBar(),
              AddItem(),
              StockInOut(),
              // FindService(),
              // const FindNearShop(),
            ],
          ),
        ),
      ),
    );
  }
}
