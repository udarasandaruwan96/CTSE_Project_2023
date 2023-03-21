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

TextEditingController nameController = TextEditingController();
TextEditingController descriptionController = TextEditingController();


//input fields will be handled
  bool viewInputfields = false;

  // int _counter = 0;
  int Listlength = 0;
  


   // create a function to add new recipe
  void _addnewcomment(String name , String description) async {

    final docRef = db.collection('commentList').doc();
   
    docRef.set(CommentModel(Listlength,name, description).toJson()).then(
      (value) => Fluttertoast.showToast(msg:"Comment Added"),
      onError: (e) => print("Error Adding Comment: $e"));

    //commentList.add(CommentModel(commentListlength,task, name, 3));
    Listlength++;
    setState(() {});
  }


// a function to remove recipe
  void _removecomment(dynamic docID,CommentModel comment) {
        print("${docID} ${comment.id}");
        db.collection('commentList').doc(docID.toString()).delete().then(
            (value) => Fluttertoast.showToast(msg:"Comment Deleted"),
            onError: (e) => print("Error Deleting Comment: $e"));
    setState(() {
    Listlength--;
    });
  }

  //  void _changeComment(dynamic docID,CommentModel comment) {
  //       comment.description = "Updated";
  //       db.collection('commentList').doc(docID.toString()).set(comment.toJson()).then(
  //           (value) => Fluttertoast.showToast(msg:"Comment Updated"),
  //           onError: (e) => print("Error Updating Comment: $e"));
  //   setState(() {
  //   });
  // }

  Future getCommentLists() async {
        return db.collection("commentList").get();
    }




  @override
  Widget build(BuildContext context) {
   return Scaffold(
    

 body: Center(
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //show and hide input fields according to the variable value
            if(viewInputfields)
            Container(
              padding: const EdgeInsets.all(20),
              height: 400,
              width: MediaQuery.of(context).size.width * 0.9 ,              
              decoration: BoxDecoration(                
                border: Border.all(color: Colors.blueGrey),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Add New Comment',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,                      
                      ),
                    ),                  
                  ),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter Your Name',
                    ),
                  ),
                  const SizedBox(height: 20,),
                  TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      hintText: 'Give Us Your Feedback',
                    ),
                  ),
                  
                  const SizedBox(height: 20,),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          _addnewcomment(nameController.text, descriptionController.text);
                          nameController.clear();
                          descriptionController.clear();

                          setState(() {
                            viewInputfields = false;
                          });
                        }, 
                        child: const Text('Add Comment')                  
                     ),
                  )
                ],
              ),
            ),
            if(!viewInputfields) 
           FutureBuilder(
              future: getCommentLists(),
              builder: ((context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.data == null) {
                  return const SizedBox();
                }

                if (snapshot.data!.docs.isEmpty) {
                  print("List ${snapshot.data.docs}");
                  return const SizedBox(
                    child: Center(
                        child:
                            Text("No Comments")),
                  );
                }

                if (snapshot.hasData) {
                  List<Map<dynamic,dynamic>> commentList = [];

                  for (var doc in snapshot.data!.docs) {
                    final comment = CommentModel.fromJson(doc.data() as Map<String, dynamic>);
                    Map<dynamic,dynamic> map = {
                      "docId":doc.id,
                      "comment":comment
                      };
                    commentList.add(map);
                  }

                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: commentList.length,
                    itemBuilder: (context, index) {
                      return  Card(
                          child: ListTile(
                            title: Center(child: Text("Username :" +commentList[index]["comment"].name!)),
                            subtitle: Column(children: [
                              Text("description :"+commentList[index]["comment"].description!),
                           
                            ]),                      
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // IconButton(
                                //   tooltip : "Press to mark complete",
                                //   onPressed: () {
                                //     _changeComment(commentList[index]["docId"],commentList[index]["comment"]);
                                //   }, 
                                //   icon: const Icon(
                                //     Icons.update_rounded,
                                //     color: Colors.cyanAccent,
                                //   ),
                                // ),
                                IconButton(
                                  tooltip : "Press to delete",
                                  onPressed: () {
                                    _removecomment(commentList[index]["docId"],commentList[index]["comment"]);
                                  }, 
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,)
                                ),
                              ],
                              )
                          ),
                        );
                    },
                  );
                }

                return const SizedBox();
              }),
            )
          ],
        ),
      ),

       floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
             viewInputfields = true;
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      )
    );
  }
}
