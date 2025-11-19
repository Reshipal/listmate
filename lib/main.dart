import 'package:flutter/material.dart';

void main() {
  runApp(ListMateApp());
}

class ListMateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListMate',
      home: ItemListScreen(),
      debugShowCheckedModeBanner: false, // Disable the debug banner
    );
  }
}

class ItemListScreen extends StatefulWidget {
  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  // The list of items
  List<String> items = ["Buy groceries", "Call mom", "Read a book"];
  
  // Track which items are checked
  List<bool> checked = [];

  // Controller for text input
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    checked = List<bool>.filled(items.length, false);
  }

  void _addItem(String item) {
    setState(() {
      if (item.isNotEmpty) {
        items.add(item);
        checked.add(false); // Add new unchecked state
      } else {
        debugPrint('Attempted to add an empty item');
      }
    });
  }

  // Function to delete checked items
  void _deleteCheckedItems() {
    setState(() {
      debugPrint('Deleting checked items...');
      for (int i = checked.length - 1; i >= 0; i--) {
        if (checked[i]) {
          debugPrint('Deleting item at index: $i');
          items.removeAt(i);
          checked.removeAt(i);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ListMate'),
      ),
      body: Column(
        children: [
          // Input field to add new items
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Add a new item',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addItem(_controller.text);
                    _controller.clear();
                  },
                )
              ],
            ),
          ),
          // Display the list of items with checkboxes
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(
                    value: checked[index],
                    onChanged: (bool? value) {
                      setState(() {
                        checked[index] = value!;
                      });
                    },
                  ),
                  title: Text(items[index]),
                );
              },
            ),
          ),
          // Delete Selected button at the bottom
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: _deleteCheckedItems,
              child: Text('Delete Selected'),
            ),
          ),
        ],
      ),
    );
  }
}
