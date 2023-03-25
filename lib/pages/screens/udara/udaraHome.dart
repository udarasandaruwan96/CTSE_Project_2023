import 'package:ctse_project/pages/user/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../login.dart';

class UdaraHome extends StatefulWidget {
  UdaraHome({Key? key}) : super(key: key);

  @override
  _UdaraHomeState createState() => _UdaraHomeState();
}

class _UdaraHomeState extends State<UdaraHome> {

final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _pnumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _aboutmeController = TextEditingController();


  final CollectionReference _userprofile =
  FirebaseFirestore.instance.collection('userprofile');


  
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
                    .bottom + 20),//MediaQuery....
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),

                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _pnumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: _aboutmeController,
                  decoration: const InputDecoration(labelText: 'About Me'),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () async {
                    final String name = _nameController.text;

                    final double? pnumber =
                    double.tryParse(_pnumberController.text);
                    final String address = _addressController.text;
                    final String date = _dateController.text;
                    final String aboutme = _aboutmeController.text;

                    if (pnumber != null) {
                      await _userprofile.add(
                          {
                            "name": name,
                            "pnumber": pnumber,
                            "address": address,
                            "date": date,
                            "aboutme": aboutme,
                          });

                      _nameController.text = '';
                      _pnumberController.text = '';
                      _addressController.text = '';
                      _dateController.text = '';
                      _aboutmeController.text = '';
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

      _nameController.text = documentSnapshot['name'];

      _pnumberController.text = documentSnapshot['pnumber'].toString();
      _addressController.text = documentSnapshot['address'];
      _dateController.text = documentSnapshot['date'];
      _aboutmeController.text = documentSnapshot['aboutme'];
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
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),

                TextField(
                  keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
                  controller: _pnumberController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                ),
                TextField(
                  controller: _addressController,
                  decoration: const InputDecoration(labelText: 'address'),
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(labelText: 'Date'),
                ),
                TextField(
                  controller: _aboutmeController,
                  decoration: const InputDecoration(labelText: 'aboutme'),
                ),
                const SizedBox(
                  height: 20,
                ),


                ElevatedButton(
                  child: const Text( 'Update'),
                  onPressed: () async {
                    final String name = _nameController.text;

                    final double? pnumber =
                    double.tryParse(_pnumberController.text);
                    final String address = _addressController.text;
                    final String date = _dateController.text;
                    final String aboutme = _aboutmeController.text;

                    if (pnumber != null) {

                      await _userprofile
                          .doc(documentSnapshot!.id)
                          .update(
                          {"name": name,

                            "pnumber": pnumber,
                            "address": address,
                            "date": date,
                            "aboutme": aboutme,}
                      );

                      Fluttertoast.showToast(
                          msg: 'Your Profile is Updated !',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          textColor: Colors.white);

                      _nameController.text = '';
                      _pnumberController.text = '';
                      _addressController.text = '';
                      _dateController.text = '';
                      _aboutmeController.text = '';
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
    await _userprofile.doc(hotlineId).delete()
    .then((value) {
    Get.snackbar('Success', 'Successfully Deleted');
    });
    Navigator.pop(context);


    }


  @override
  Widget build(BuildContext context) {
    
    //............................................................................
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("User Details"),
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
          stream: _userprofile.snapshots(),
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
                        documentSnapshot['name'].toString(),
                        style: TextStyle(
                          fontSize: 27,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Text(
                        documentSnapshot['address'].toString(),
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
                        color: Color(0xFFFFA000),
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
                        color: Colors.red,
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
                          title: Text("User Details"),
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

      //.....botom navebar...................................
       bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Change Password',
          ),
        ],
      ),

      
      // Add new ..........................................................................................
        floatingActionButton: FloatingActionButton(
          onPressed: () => _create(),
          child: const Icon(Icons.add),

        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat
  
     
    ); 
  }
}
