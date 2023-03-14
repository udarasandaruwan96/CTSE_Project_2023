import 'package:flutter/material.dart';

class DisniHome extends StatefulWidget {
  DisniHome({Key? key}) : super(key: key);

  @override
  _DisniHomeState createState() => _DisniHomeState();
}

class _DisniHomeState extends State<DisniHome> {

// methanta .....................



  @override
  Widget build(BuildContext context) {
    return Center(

      //methanata
      child: Container(
          child: Text(
        'DisniHome',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
