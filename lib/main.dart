import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertodo/services/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData.dark(),
      home: FutureBuilder(
        // initialize flutter fire 
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // check for errors..
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(child: Text('error'),),
            );
          }
          // show application once complete
          if (snapshot.connectionState == ConnectionState.done) {
            return Root();
          }

          return const Scaffold(
            body: Center(child: Text('loading ...'),)
          );
        })
    );
  }
}

class Root extends StatefulWidget {
  const Root({ Key? key }) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth(auth: _auth).user,
      builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null){
            return Login(
              auth: _auth,
              firestore: _firestore,
            );
          } else {
            return Home(
              auth: _auth,
              firestore: _firestore,
            );
          }
        } else {
          return const Scaffold(
            body: Center(child: Text("Loading"),),
          );
        }
      },
    );
  }
}