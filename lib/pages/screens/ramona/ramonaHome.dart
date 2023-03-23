import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../models/comment.dart';

class RamonaHome extends StatefulWidget {
  RamonaHome({Key? key}) : super(key: key);

  @override
  _RamonaHomeState createState() => _RamonaHomeState();
}

class _RamonaHomeState extends State<RamonaHome> {
  final db = FirebaseFirestore.instance;
  final CollectionReference commentList =
  FirebaseFirestore.instance.collection('commentList');
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

//input fields will be handled
  bool viewInputfields = false;

  // int _counter = 0;
  int Listlength = 0;

  Future<void> _CreateOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      nameController.text = documentSnapshot['name'];
      descriptionController.text = documentSnapshot['description'].toString();
    }
    //reference - https://www.kindacode.com/article/flutter-firestore-database/
    await showModalBottomSheet(
       
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                // prevent the soft keyboard from covering text fields
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
              child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                Image.asset(
                'assets/images/review.gif',
                height: 220, // Set the height of the image
                width: double.infinity, // Set the width of the image to be the full width of the modal
                fit: BoxFit.cover, // Set the image to cover the entire space
                 ),
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: const Text(
                    'Your Comments Can Help Us Improve',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Your Name'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Comments',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Add' : 'Update'),
                  onPressed: () async {
                    final String? name = nameController.text;
                    final String? description = descriptionController.text;
                    if (name != null && description != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await commentList.add({"name": name, "description": description});
                      }

                      if (action == 'update') {
                        // Update the product
                        await commentList
                            .doc(documentSnapshot!.id)
                            .update({"name": name, "description": description});
                      }

                      // Show a success toast
                        Fluttertoast.showToast(
                            msg: 'Thank you for your feedback',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            textColor: Colors.white);

                      // Clear the text fields
                      nameController.text = '';
                      descriptionController.text = '';

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
}

// Deleteing a product by id
  Future<void> _deleteProduct(String productId) async {
    await commentList.doc(productId).delete();

    // Show a snackbar
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted')));
  }


  Future getCommentLists() async {
    return db.collection("commentList").get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  

 appBar: AppBar(
        title: const Text('Comments and Feedback'),
      ),
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: commentList.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                     leading: const CircleAvatar(
                      backgroundImage: NetworkImage('assets/images/user.gif'),
                      radius: 25,
                      ),
                    title: Text(documentSnapshot['name']),
                    subtitle: Text(documentSnapshot['description'].toString()),
                    trailing: SizedBox(
                      width: 80,
                      child: Row(
                        children: [
                          
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () =>
                                  _CreateOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                    // Delete Confirmation Message
                            // set up the buttons
                            Widget cancelButton = TextButton(
                              child: const Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                            Widget continueButton = TextButton(
                              child: Text("Confirm"),
                              onPressed: (){ _deleteProduct(documentSnapshot.id);
                               Navigator.pop(context);
                               },
                            );

                            // set up the AlertDialog
                            AlertDialog alert = AlertDialog(
                              title: Text("Delete Comment"),
                              content: Text("Please confirm delete"),
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
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _CreateOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

