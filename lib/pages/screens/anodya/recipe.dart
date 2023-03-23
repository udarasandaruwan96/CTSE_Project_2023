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
        title: Text('Add Recipe'),
      ),
       body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 70),
          Image.network('assets/images/homeImage.gif', height: 350),
          const SizedBox(height: 30),
          const Text('Add your Recipe', style: TextStyle(fontSize: 20)),
          // const SizedBox(height: 20),
          // const Text('We strive to make cooking for you more simpler and more easy with our dishes and cutting-edge application', style: TextStyle(fontSize: 15), textAlign: TextAlign.center,
          //     maxLines: 2,
          //     overflow: TextOverflow.ellipsis,),
          // SizedBox(height: 30),
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
