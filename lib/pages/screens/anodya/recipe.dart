import 'package:ctse_project/pages/screens/anodya/anodyaHome.dart';
import 'package:ctse_project/pages/screens/disni/disniHome.dart';
import 'package:ctse_project/pages/screens/ramona/ramonaHome.dart';
import 'package:flutter/material.dart';

class addRecipe extends StatefulWidget {
  addRecipe({Key? key}) : super(key: key);

  @override
  _addRecipeState createState() => _addRecipeState();
}

class _addRecipeState extends State<addRecipe> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipes'),
      ),
       body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Image.network('assets/images/cooking-flavours.gif', height: 360),
          const SizedBox(height: 30),
          const Text('Add your Recipe here..', style: TextStyle(fontSize: 20)),
          const Text('EXCITED!....you can create new recipe here and read them', style: TextStyle(fontSize: 18)),
      
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnodyaHome()),
              );
            },
            child: Text('Click Here To Add Recipe'),
          ),
        ],
    ),

    );
  }
}
