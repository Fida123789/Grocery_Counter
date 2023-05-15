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
  runApp(ViewPage());
}

class ViewPage extends StatefulWidget {
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  DatabaseReference _databaseReference;

  List<Map<dynamic, dynamic>> items = [];

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.ref().child('items');

    _databaseReference.onValue.listen((event) {
      setState(() {
        Map<dynamic, dynamic> values = event.snapshot.value;
        items = [];
        values.forEach((key, values) {
          items.add({
            "name": values["name"],
            "price": values["price"],
          });
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Items List'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: ListTile(
                  title: Text(items[index]["name"]),
                  subtitle: Text(items[index]["price"]),
                ),
              );
            }),
      ),
    );
  }
}
