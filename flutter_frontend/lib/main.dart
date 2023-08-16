import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'common/theme.dart';
import 'routes/route.dart';
import 'screens/splash_screen.dart';
import '../screens/search/search.dart';
import '../screens/welcome.dart';
import '../screens/account.dart';
import '../screens/home/dashboard.dart';
import '../screens/stockInOut/stockInOutList.dart';
import '../screens/stockInOut/stockDetail.dart';
import '../screens/item/add_item.dart';
import '../screens/login.dart';

void main() {
  dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const Login(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
