import 'package:flutter/material.dart';

class UdaraHome extends StatefulWidget {
  UdaraHome({Key? key}) : super(key: key);

  @override
  _UdaraHomeState createState() => _UdaraHomeState();
}

class _UdaraHomeState extends State<UdaraHome> {

// methanta .....................



  @override
  Widget build(BuildContext context) {
    return Center(

      //methanata
      child: Container(
          child: Text(
        'UdaraHome',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
