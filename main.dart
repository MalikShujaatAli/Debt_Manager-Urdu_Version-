import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import for shared preferences

void main() {
  runApp(const DebtManagerApp());
}

class DebtManagerApp extends StatelessWidget {
  const DebtManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qarz Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const DebtManagerHomePage(),
    );
  }
}

class DebtItem {
  String name;
  double amount;
  bool isOwedByUser;

  DebtItem({
    required this.name,
    required this.amount,
    required this.isOwedByUser,
  });
}

class DebtManagerHomePage extends StatefulWidget {
  const DebtManagerHomePage({super.key});

  @override
  _DebtManagerHomePageState createState() => _DebtManagerHomePageState();
}

class _DebtManagerHomePageState extends State<DebtManagerHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  List<DebtItem> _debtsList = [];
  bool _isOwedByUser = false; // State variable for checkbox

  @override
  void initState() {
    super.initState();
    _loadSavedData(); // Load saved data when the widget initializes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qarz Manager'),
      ),
      body: Stack(
        // Wrap with Stack
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Naam'),
                ),
                const SizedBox(height: 12.0),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Raqam (Rs.)'),
                ),
                const SizedBox(height: 12.0),
                Row(
                  children: [
                    const Text('Meine dene hein? '),
                    Checkbox(
                      value: _isOwedByUser,
                      onChanged: (value) {
                        setState(() {
                          _isOwedByUser = value!;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: _addDebt,
                  child: const Text('Dakhla'),
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Qarzay:',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline, // Add this line
                  ),
                ),
                Expanded(
                  child: ReorderableListView(
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final item = _debtsList.removeAt(oldIndex);
                        _debtsList.insert(newIndex, item);
                      });
                    },
                    children: _debtsList
                        .map((debt) => ListTile(
                              key: Key(debt.name),
                              title: Text(
                                  '${debt.name}: Rs. ${debt.amount.toInt()} ${debt.isOwedByUser ? "\n(Meine dene hein)" : "\n(Meine lene hein)"}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () => _deleteDebt(debt),
                              ),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            // Positioned for absolute positioning
            left: 0,
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: _launchURL,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                color: const Color.fromARGB(255, 255, 255, 255),
                child: const Text(
                  'Made by Shujaat',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addDebt() {
    final name = _nameController.text;
    final amountStr = _amountController.text;

    if (name.isEmpty || amountStr.isEmpty) {
      return;
    }

    final amount = double.tryParse(amountStr);
    if (amount == null || amount <= 0) {
      return;
    }

    setState(() {
      _debtsList.add(DebtItem(
        name: name,
        amount: amount,
        isOwedByUser: _isOwedByUser, // Use the current checkbox state
      ));
    });

    _nameController.clear();
    _amountController.clear();
    _saveData(); // Save the updated list after adding a new debt
  }

  void _deleteDebt(DebtItem debt) {
    setState(() {
      _debtsList.remove(debt);
    });
    _saveData(); // Save the updated list after deleting a debt
  }

  void _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> debtsStringList = _debtsList
        .map((debt) =>
            "${debt.name},${debt.amount.toString()},${debt.isOwedByUser.toString()}")
        .toList();
    prefs.setStringList('debtsList', debtsStringList);
  }

  void _loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? debtsStringList = prefs.getStringList('debtsList');
    if (debtsStringList != null) {
      setState(() {
        _debtsList = debtsStringList.map((debtString) {
          List<String> values = debtString.split(',');
          return DebtItem(
            name: values[0],
            amount: double.parse(values[1]),
            isOwedByUser: values[2] == 'true',
          );
        }).toList();
      });
    }
  }
}

// Function to launch the URL
void _launchURL() async {
  const url =
      'https://www.instagram.com/malik._.shujaat?igshid=emR0eGQ1OGdocG04';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
