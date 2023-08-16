import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/custom_scaffold.dart';
import '../../routes/route.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String barcodeId = '';

  Future<void> scanBarcode() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666', 'Cancel', true, ScanMode.BARCODE);

    if (barcodeScanRes != '-1') {
      setState(() {
        barcodeId = barcodeScanRes;
      });
    } else {
      AlertDialog(
        title: const Text('Scan Canceled'),
        content: SingleChildScrollView(
          child: ListBody(
            children: const <Widget>[
              Text('Barcode scanning was canceled.'),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(RouteList.dashboard);
          },
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
        ),
        title: const Text(
          'Search',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          const Text('Enter item name or barcode ID to search.'),
          const SizedBox(height: 20),
          // search text field
          const SizedBox(
            width: 300,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Search',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(RouteList.searchResult);
            },
            child: const Text('Search'),
          ),
          const SizedBox(height: 20),
          // const Divider(
          //   color: Colors.grey,
          //   thickness: 1,
          //   indent: 20, // Left indent of the line
          //   endIndent: 20, // Right indent of the line
          // ),
          // const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              const Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              Container(
                color: Colors
                    .white, // Change this color to match the background color
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: const Text(
                  'Other',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: scanBarcode,
            child: const Icon(
              Icons.qr_code_scanner,
              size: 60,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            // barcode length is 13
            'Barcode ID: $barcodeId',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
      // bottomNavigationBar: const BottomNavigation(currentIndex: 3),
    );
  }
}
