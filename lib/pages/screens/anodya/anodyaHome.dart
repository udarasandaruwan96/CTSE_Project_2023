import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../login.dart';

class AnodyaHome extends StatefulWidget {
  AnodyaHome({Key? key}) : super(key: key);

  @override
  _AnodyaHomeState createState() => _AnodyaHomeState();
}

class _AnodyaHomeState extends State<AnodyaHome> {
// methanta .....................

  final TextEditingController _recipenameController = TextEditingController();
  final TextEditingController _ingredientsController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final CollectionReference _addrecipe =
      FirebaseFirestore.instance.collection('addrecipe');

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
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/cook-chef.gif',
                    height: 250,
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
                TextField(
                  controller: _recipenameController,
                  decoration: const InputDecoration(labelText: 'Recipe Name'),
                ),
                TextField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(labelText: 'Ingredients'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: null,
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String recipename = _recipenameController.text;
                    final String ingredients = _ingredientsController.text;
                    final String description = _descriptionController.text;

                    if (ingredients != null) {
                      await _addrecipe.add({
                        "recipename": recipename,
                        "description": description,
                        "ingredients": ingredients,
                      });

                      _recipenameController.text = '';
                      _descriptionController.text = '';
                      _ingredientsController.text = '';

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
      _recipenameController.text = documentSnapshot['recipename'];
      _descriptionController.text = documentSnapshot['description'];
      _ingredientsController.text = documentSnapshot['ingredients'];
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
                  controller: _recipenameController,
                  decoration: const InputDecoration(labelText: 'Recipe name'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _ingredientsController,
                  decoration: const InputDecoration(labelText: 'Ingredients'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Update'),
                  onPressed: () async {
                    final String recipename = _recipenameController.text;
                    final String description = _descriptionController.text;
                    final String ingredients = _ingredientsController.text;

                    if (ingredients != null) {
                      await _addrecipe.doc(documentSnapshot!.id).update({
                        "recipename": recipename,
                        "description": description,
                        "ingredients": ingredients,
                      });

                      _recipenameController.text = '';
                      _descriptionController.text = '';
                      _ingredientsController.text = '';

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
    await _addrecipe.doc(hotlineId).delete().then((value) {
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
              Text("Recipe Details"),
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
          stream: _addrecipe.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.hasData) {
              return ListView.builder(
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documentSnapshot =
                      streamSnapshot.data!.docs[index];

                  return Card(
                    shadowColor: Colors.purpleAccent,
                    margin: const EdgeInsets.all(13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9.9),
                    ),
                    child: ListTile(
                      title: Text(
                        documentSnapshot['recipename'].toString(),
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
                                backgroundColor: Color.fromARGB(238, 217, 183, 233),
                                shape: CircleBorder(),
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Color.fromARGB(255, 151, 20, 190),
                              ),
                              onPressed: () => _update(documentSnapshot),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color.fromARGB(238, 220, 178, 236),
                                shape: CircleBorder(),
                              ),
                              child: Icon(
                                Icons.delete,
                                color: Color.fromARGB(255, 151, 20, 190),
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
                                  title: Text("Recipe Details"),
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
