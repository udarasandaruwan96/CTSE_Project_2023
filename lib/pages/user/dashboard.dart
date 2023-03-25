//import 'package:ctse_project/pages/screens/anodya/recipe.dart';
//import 'package:ctse_project/pages/screens/disni/addNote.dart';
import 'package:flutter/material.dart';

import '../screens/anodya/recipe.dart';
import '../screens/disni/addNote.dart';
import '../screens/ramona/comment.dart';
import '../screens/ramona/ramonaHome.dart';
import '../screens/udara/udaraHome.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
// methanta

  @override
  Widget build(BuildContext context) {
    //methanata................

    // ignore: prefer_const_constructors
    return Scaffold(
// appBar: AppBar(title: Text("Grid"),),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),

          // ignore: sort_child_properties_last
          child: GridView(
            children: [
              InkWell(
                //  onTap: (){
                //    Navigator.push(context, MaterialPageRoute(builder: (context)=>UdaraHome()));
                //  },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 97, 107, 197),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "Home",
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addNote()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 179, 83, 171),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sticky_note_2,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "Add Notes",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => addRecipe()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 45, 148, 139),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.settings,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        "Recipes",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CommentHome()));
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.book,
                        size: 45,
                        color: Colors.white,
                      ),
                      Text(
                        "Comments",
                        style: TextStyle(color: Colors.white, fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
            ],
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          ),
        ),
      ),
    );
  }

//button call.................................
  // void _udaraHome(BuildContext context) {
  //   Navigator.of(context)
  //       .push(MaterialPageRoute(builder: (context) => UdaraHome()));
  // }
}
