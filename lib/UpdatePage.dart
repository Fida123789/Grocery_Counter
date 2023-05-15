import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: firebaseConfig["AIzaSyCRQLg0xpn9Uq_U67LT-B5dCrsM_k-2hoQ"],
        authDomain: firebaseConfig["grocery-counter.firebaseapp.com"],
        projectId: firebaseConfig["grocery-counter"],
        storageBucket: firebaseConfig["grocery-counter.appspot.com"],
        messagingSenderId: firebaseConfig["20579314957"],
        appId: firebaseConfig["1:20579314957:web:97e8f0963e559ed5c35444"]),
  );

  // Run the app
  runApp(UpdatePage());
}

class UpdatePage extends StatefulWidget {
  final String name;
  final String price;

  UpdatePage({@required this.name, @required this.price});

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final databaseReference = FirebaseDatabase.instance.ref();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
    _priceController.text = widget.price;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void updateItem() {
    String itemName = _nameController.text;
    String price = _priceController.text;

    databaseReference
        .child('items')
        .child(itemName)
        .update({'price': price}).then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Item Updated')));
    }).catchError((error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Item'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Price',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: updateItem,
              child: Text('Update Item'),
            ),
          ],
        ),
      ),
    );
  }
}
