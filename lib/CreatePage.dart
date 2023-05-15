import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  runApp(CreatePage());
}

class CreatePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 150),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Item Name',
                    hintText: 'Enter item name'),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price',
                    hintText: 'Enter price'),
              ),
            ),
            SizedBox(
              height: 75,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('item').add({
                  'name': nameController.text,
                  'price': priceController.text,
                });
              },
              child: Text(
                'CREATE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
