import 'package:ctse_project/pages/screens/disni/disniHome.dart';
import 'package:flutter/material.dart';

class addNote extends StatefulWidget {
  addNote({Key? key}) : super(key: key);

  @override
  _addNoteState createState() => _addNoteState();
}

//......data adding
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
          Image.asset('assets/images/note.png', height: 250),
          const SizedBox(height: 30),
          const Text('Add Your Note', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          const Text(
            'Wonna Note down Reciepie Tips? Grab You Pen Here !',
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DisniHome()),
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Click Here To Add a Note'), // <-- Text
                SizedBox(
                  width: 5,
                ),
                Icon(
                  // <-- Icon
                  Icons.draw,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
