import 'package:flutter/material.dart';

class RamonaHome extends StatefulWidget {
  RamonaHome({Key? key}) : super(key: key);

  @override
  _RamonaHomeState createState() => _RamonaHomeState();
}

class _RamonaHomeState extends State<RamonaHome> {

// methanta .....................



  @override
  Widget build(BuildContext context) {
    return Center(

      //methanata
      child: Container(
          child: Text(
        'RamonaHome',
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      )),
    );
  }
}
