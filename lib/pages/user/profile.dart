import 'package:ctse_project/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../screens/udara/udaraHome.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has benn sent');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has benn sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
    }
  }

//delete..................
Future<void> deleteUserProfile(BuildContext context) async {
  final user = FirebaseAuth.instance.currentUser;

    try {
    await user?.delete();
    print('User account deleted successfully.');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          "User account deleted successfully.",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
    );
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login()),
      (route) => false,
    );
  } catch (e) {
    print('Failed to delete user account: $e');
     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.orangeAccent,
        content: Text(
          "Failed to delete user account.",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        ),
      ),
    );
  }

  // Delete user profile data in Cloud Firestore
  // final userDocRef = FirebaseFirestore.instance.collection('users').doc(user!.uid);
  // await userDocRef.delete();
}






  @override
  Widget build(BuildContext context) {
    return Container(
      
      margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [

          const SizedBox(height: 30),
          Image.network('assets/images/user.gif', height: 250),
      

          const SizedBox(height: 30),
          Text(
            'User ID: $uid',
            style: TextStyle(fontSize: 18.0),
          ),
          Row(
            children: [
              Text(
                'Email: $email',
                style: TextStyle(fontSize: 18.0),
              ),
              user!.emailVerified
                  ? Text(
                      'verified',
                      style: TextStyle(fontSize: 18.0, color: Colors.blueGrey),
                    )
                  :
                  const SizedBox(height: 30), 
                  TextButton(
                      onPressed: () => {verifyEmail()},
                      child: Text('Verify Email'))
            ],
          ),

          const SizedBox(height: 30),
          Text(
            'Created: $creationTime',
            style: TextStyle(fontSize: 18.0),
          ),

        //delete ...........
          Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0), // adjust the value to add more or less space
              child: ElevatedButton(
            onPressed: () async {
              //await deleteUserProfile(context);
              Widget cancelButton = TextButton(
                 child: Text("Cancel"),
                   onPressed: () {
                   Navigator.pop(context);
                 },
            );
            Widget continueButton = TextButton(
               child: Text("Ok"),
                  onPressed: () => deleteUserProfile(context),
            );

           // Create the AlertDialog
           AlertDialog alert = AlertDialog(
             title: Text("Delete Profile"),
             content: Text("Are you sure you want to delete?"),
             actions: [
             cancelButton,
             continueButton,
             ],
           );

            // Show the AlertDialog
           showDialog(
              context: context,
              builder: (BuildContext context) {
              return alert;
              },
           );
           },
          child: Text('Delete Profile'),
         ),
         ),
           
           const SizedBox(height: 30),
           Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0), // adjust the value to add more or less space
              child: ElevatedButton(
               onPressed: () async {
                       Navigator.push(context, MaterialPageRoute(builder: (context) => UdaraHome()));
                   },
                child: Text('User Details'),
              ),
           ),
           
          

        ],
      ),
    );
  }
}
