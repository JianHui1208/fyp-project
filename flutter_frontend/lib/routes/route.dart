import 'package:flutter/material.dart';
import '../screens/item/add_item.dart';
import '../screens/error/error.dart';
import '../screens/account.dart';
import '../screens/home/dashboard.dart';
import '../screens/login.dart';
import '../screens/coming_soon.dart';
import '../screens/search/search.dart';
import '../screens/search/search_result.dart';
import '../screens/itemList/itemCategory.dart';
import '../screens/itemList/itemList.dart';
import '../screens/itemList/ItemDetail.dart';
import '../screens/stockInOut/addStockIn.dart';
import '../screens/stockInOut/addStockOut.dart';
import '../screens/stockInOut/adjustStock.dart';
import '../screens/stockInOut/stockInOutList.dart';
import '../screens/stockInOut/LongTextDialog.dart';
import '../screens/stockInOut/stockDetail.dart';
import '../screens/register.dart';
import '../screens/booking/booking_detail.dart';
import '../screens/booking/booking_list.dart';
import '../screens/welcome.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case RouteList.welcome:
        return MaterialPageRoute(builder: (_) => const Welcome());
      case RouteList.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case RouteList.register:
        return MaterialPageRoute(builder: (_) => const Register());
      case RouteList.dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case RouteList.booking:
        return MaterialPageRoute(builder: (_) => const BookingList());
      case RouteList.bookingDetail:
        return MaterialPageRoute(builder: (_) => const BookingDetail());
      case RouteList.account:
        return MaterialPageRoute(builder: (_) => const Account());
      case RouteList.comingsoon:
        return MaterialPageRoute(builder: (_) => const ComingSoon());
      case RouteList.search:
        return MaterialPageRoute(builder: (_) => const Search());
      case RouteList.itemCategory:
        return MaterialPageRoute(builder: (_) => const ItemCategory());
      case RouteList.addItem:
        return MaterialPageRoute(builder: (_) => const AddItem());
      case RouteList.addStockIn:
        return MaterialPageRoute(builder: (_) => const AddStockIn());
      case RouteList.addStockOut:
        return MaterialPageRoute(builder: (_) => const AddStockOut());
      case RouteList.adjustStock:
        return MaterialPageRoute(builder: (_) => const AdjustStock());
      case RouteList.longTextDialog:
        return MaterialPageRoute(builder: (_) => const LongTextDialog());
      case RouteList.stockInOutList:
        return MaterialPageRoute(builder: (_) => const StockInOutList());
      case RouteList.searchResult:
        return MaterialPageRoute(builder: (_) => const SearchResult());
      case RouteList.itemList:
        if (args is int) {
          // If the argument is of type int, pass it to the StockDetail widget
          return MaterialPageRoute(
              builder: (_) => ItemList(itemCategoryId: args));
        }
        // Handle the case where the argument is not of the expected type
        return _errorRoute();
      case RouteList.itemDetail:
        if (args is int) {
          return MaterialPageRoute(builder: (_) => ItemDetail(itemID: args));
        }
        return _errorRoute();
      case RouteList.stockDetail:
        if (args is int) {
          return MaterialPageRoute(builder: (_) => StockDetail(stockID: args));
        }
        return _errorRoute();
      default:
        return MaterialPageRoute(builder: (_) => const ErrorPage());
    }
  }

  static Route<dynamic> _errorRoute() {
    // Return an error page or handle the error case as needed
    return MaterialPageRoute(builder: (_) => const ErrorPage());
  }
}

class RouteList {
  static const String welcome = '/Welcome';
  static const String login = '/Login';
  static const String register = '/Register';
  static const String dashboard = '/Dashboard';
  static const String booking = '/Booking';
  static const String bookingDetail = '/BookingDetail';
  static const String account = '/Account';
  static const String comingsoon = '/comingSoon';
  static const String search = '/search';
  static const String itemCategory = '/itemCategory';
  static const String itemList = '/itemList';
  static const String itemDetail = '/itemDetail';
  static const String addItem = '/addItem';
  static const String stockDetail = '/stockDetail';
  static const String addStockIn = '/addStockIn';
  static const String addStockOut = '/addStockOut';
  static const String adjustStock = '/adjustStock';
  static const String stockInOutList = '/stockInOutList';
  static const String longTextDialog = '/LongTextDialog';
  static const String searchResult = '/searchResult';
}
