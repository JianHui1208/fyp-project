import 'package:flutter/material.dart';
import '../../gen/assets.gen.dart';
import '../../routes/route.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({super.key});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  final List<Item> items = [
    Item(id: 1, name: 'Item 1', price: 10.99, imageUrl: 'image_url_1'),
    Item(id: 2, name: 'Item 2', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 3, name: 'Item 3', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 4, name: 'Item 4', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 5, name: 'Item 5', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 6, name: 'Item 2', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 7, name: 'Item 2', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 8, name: 'Item 2', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 9, name: 'Item 2', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 10, name: 'Item 2', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 11, name: 'Item 2', price: 15.99, imageUrl: 'image_url_2'),
    Item(id: 12, name: 'Item 2', price: 15.99, imageUrl: 'image_url_2'),
    // Add more items
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Search Result',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(RouteList.search);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.black),
          )),
      body: ListView(
        children: [
          const SizedBox(height: 15),
          GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
            ),
            shrinkWrap: true, // Allow GridView to be scrollable inside ListView
            physics:
                const NeverScrollableScrollPhysics(), // Disable GridView's scrolling
            itemCount: items.length,
            itemBuilder: (context, index) {
              return ItemCard(item: items[index]);
            },
          ),
          const SizedBox(height: 15),
          const Center(
            child: Text('This is the last item'),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouteList.itemDetail, arguments: item.id);
      },
      child: Card(
        color: Colors.blue,
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.network(Assets.images.defaultImg.path),
                  const SizedBox(height: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '\$${item.price.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Implement cart screen UI
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: const Center(
        child: Text('Cart Screen'),
      ),
    );
  }
}

class Item {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  Item(
      {required this.id,
      required this.name,
      required this.price,
      required this.imageUrl});
}
