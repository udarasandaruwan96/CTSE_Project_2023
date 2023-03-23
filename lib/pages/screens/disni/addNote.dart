import 'package:ctse_project/pages/screens/disni/disniHome.dart';
import 'package:ctse_project/pages/screens/ramona/ramonaHome.dart';
import 'package:flutter/material.dart';

class addNote extends StatefulWidget {
  addNote({Key? key}) : super(key: key);

  @override
  _addNoteState createState() => _addNoteState();
}

class _addNoteState extends State<addNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
       body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Image.network('assets/images/homeImage.gif', height: 350),
          const SizedBox(height: 30),
          const Text('Add your Note', style: TextStyle(fontSize: 20)),
          // const SizedBox(height: 20),
          // const Text('We strive to make cooking for you more simpler and more easy with our dishes and cutting-edge application', style: TextStyle(fontSize: 15), textAlign: TextAlign.center,
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,),
          // SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisniHome()),
              );
            },
            child: Text('Click Here To Add Note'),
          ),
        ],
    ),

    );
  }
}
