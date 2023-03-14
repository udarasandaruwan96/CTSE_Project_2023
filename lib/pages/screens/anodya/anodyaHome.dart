import 'package:flutter/material.dart';

class AnodyaHome extends StatefulWidget {
  AnodyaHome({Key? key}) : super(key: key);

  @override
  _AnodyaHomeState createState() => _AnodyaHomeState();
}

class _AnodyaHomeState extends State<AnodyaHome> {

// methanta .....................



  @override
  Widget build(BuildContext context) {
    return Center(

      //methanata
      child: Container(
          child: Text(
        'AnodyaHome',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
