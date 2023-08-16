import 'package:flutter/material.dart';
import 'QuantityDialog.dart';
import 'LongTextDialog.dart';

class AdjustStock extends StatefulWidget {
  const AdjustStock({Key? key}) : super(key: key);

  @override
  _AdjustStockState createState() => _AdjustStockState();
}

class _AdjustStockState extends State<AdjustStock> {
  final _formKey = GlobalKey<FormState>();
  int _itemQuantity = 1;
  String? selectedOption;
  String? description;

  Future<String?> showLongTextDialog(BuildContext context,
      {String? initialDescription}) async {
    return await showDialog(
      context: context,
      builder: (context) =>
          LongTextDialog(initialDescription: initialDescription),
    );
  }

  void _showQuantityDialog(BuildContext context) async {
    int? newQuantity = await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return QuantityDialog(currentQuantity: _itemQuantity);
      },
    );

    if (newQuantity != null) {
      setState(() {
        _itemQuantity = newQuantity;
      });
    }
  }

  String _truncateDescription(String description) {
    const int maxVisibleChars =
        10; // Adjust the number of visible characters to your preference.
    return (description.length <= maxVisibleChars)
        ? description
        : '${description.substring(0, maxVisibleChars)}...';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            size: 30.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text('Adjust'),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              // Change Row to Column
              children: [
                Row(
                  children: const [
                    Text(
                      'Adjust',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 3,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Item'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Item',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter item';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Description'),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () async {
                        String? newDescription = await showLongTextDialog(
                          context,
                          initialDescription: description,
                        );

                        if (newDescription != null) {
                          setState(() {
                            description = newDescription;
                          });
                        }
                      },
                      child: (description != null)
                          ? Text(
                              _truncateDescription(description!),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            )
                          : const Text('Write'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
