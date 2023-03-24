import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../login.dart';

class DisniHome extends StatefulWidget {
  DisniHome({Key? key}) : super(key: key);

  @override
  _DisniHomeState createState() => _DisniHomeState();
}

class _DisniHomeState extends State<DisniHome> {

// methanta .....................


  final TextEditingController _topicnameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();



  final CollectionReference _addnote =
  FirebaseFirestore.instance.collection('addnote');


  
  //add data........................................................
  Future<void> _create([DocumentSnapshot? documentSnapshot]) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery
                    .of(ctx)
                    .viewInsets
                    .bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _topicnameController,
                  decoration: const InputDecoration(labelText: 'topicname'),
                ),

               
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'description'),
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String topicname = _topicnameController.text;
                    final String description = _descriptionController.text;
                    final String date = _dateController.text;
                 

                    if (date != null) {
                      await _addnote.add(
                          {
                            "topicname": topicname,
                            "description": description,
                            "date": date,
                            
                          });

                      _topicnameController.text = '';
                      _descriptionController.text = '';
                      _dateController.text = '';

                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
}


  //update data...........................................................
  Future<void> _update([DocumentSnapshot? documentSnapshot]) async {
    if (documentSnapshot != null) {

      _topicnameController.text = documentSnapshot['topicname'];
      _descriptionController.text = documentSnapshot['description'];
      _dateController.text = documentSnapshot['date'];
     
    }


    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _topicnameController,
                  decoration: const InputDecoration(labelText: 'Topic'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
              
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String topicname = _topicnameController.text;
                    final String description = _descriptionController.text;
                    final String date = _dateController.text;
                    
                    if (date != null) {

                      await _addnote
                          .doc(documentSnapshot!.id)
                          .update(
                          {
                            "topicname": topicname,
                            "description": description,
                            "date": date,
                           }
                      );

                      _topicnameController.text = '';
                      _descriptionController.text = '';
                      _dateController.text = '';
                     
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }


  //delete.....................................................
  Future<void> _delete(String hotlineId) async {
    await _addnote.doc(hotlineId).delete()
    .then((value) {
    Get.snackbar('Success', 'Successfully Deleted');
    });
    Navigator.pop(context);


    }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Note Details"),
            ElevatedButton(
              onPressed: () async => {
                await FirebaseAuth.instance.signOut(),
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Login(),
                    ),
                    (route) => false)
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
            )
          ],
        ),
      ),


      //......body....................................................
        body: StreamBuilder(
          stream: _addnote.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot)

          {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];

                return Card(
                    shadowColor: Colors.purpleAccent,
                    margin: const EdgeInsets.all(13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.9),
                    ),
                    child: ListTile(
                      title: Text(
                        documentSnapshot['topicname'].toString(),
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        documentSnapshot['description'].toString(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 130,
                        child: Row(
                            children: [
                        TextButton(
                        style: TextButton.styleFrom(
                        backgroundColor: Color(0xEFEFEFFF),
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Color.fromARGB(255, 33, 115, 209),
                      ),
                      onPressed: () => _update(documentSnapshot),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xEFEFEFFF),
                        shape: CircleBorder(),
                      ),
                      child: Icon(
                        Icons.delete,
                        color: Color.fromARGB(255, 224, 68, 68),
                      ),
                      onPressed: () {
                        // Delete Confirmation Message
                        // set up the buttons
                        Widget cancelButton = TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        );
                        Widget continueButton = TextButton(
                          child: Text("Ok"),
                          onPressed: () => _delete(documentSnapshot.id),
                        );

                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Note Details"),
                          content: Text("Are you sure want to delete?"),
                          actions: [
                            cancelButton,
                            continueButton,
                          ],
                        );
                        // show the dialog
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return alert;
                          },
                        );
                      },
                    ),


                        ],
                      ),
                    ),
                  ),
                );
                },
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
       
       
      // Add new..........................................................................................
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
  
     
    ); 

  }
}
