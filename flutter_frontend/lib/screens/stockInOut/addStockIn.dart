import 'package:flutter/material.dart';
import 'QuantityDialog.dart';
import 'LongTextDialog.dart';

class AddStockIn extends StatefulWidget {
  const AddStockIn({Key? key}) : super(key: key);

  @override
  _AddStockInState createState() => _AddStockInState();
}

class _AddStockInState extends State<AddStockIn> {
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

  // Item Category
  List<String> suppliers = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
  ];

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
        centerTitle: true,
        title: const Text('Stock In'),
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
                      'Stock In',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  height: 3,
                  color: Colors.blue,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Expanded(
                      child: Text('Supplier'),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: DropdownButtonFormField<String>(
                        menuMaxHeight: 300,
                        value: selectedOption,
                        items: suppliers.map((String option) {
                          return DropdownMenuItem<String>(
                            value: option,
                            child: Text(option),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedOption = newValue;
                            print(selectedOption);
                          });
                        },
                        decoration: const InputDecoration.collapsed(
                          hintText: "Select an option",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
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
