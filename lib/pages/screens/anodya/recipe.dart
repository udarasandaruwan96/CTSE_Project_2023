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
        title: Text('My Recipes'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          const Text('Custom Recipes', style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,)),
          Text(
            'Create Your Own Recipes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          Center(
            child: Image.network(
              'assets/images/cooking-flavours.gif',
              height: 330,
              width: 400,
            ),
          ),
          const SizedBox(height: 30),
          const Text('Add your own Recipes from  here..', style: TextStyle(fontSize: 20)),
          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AnodyaHome()),
              );
            },
            child: Text('Click Here To Add New Recipe'),
          ),
        ],
      ),
    );
  }
}
