import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'mainrecipes.dart';
import 'randommeals.dart';
import 'seachpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: RecipesPage(),
    );
  }
}

class RecipesPage extends StatefulWidget {
  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  PageController pageController;
  int page =0;
  final pageoption = [
    MainRecipesPage(),
          SearchPage(),
          RandomMealPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE8E7E1),
      body: pageoption[page],
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        items: [
          Icon(Icons.fastfood,size: 30,color: Colors.black,),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.explore,
            size: 30,
            color: Colors.black,
          )
        ],
        onTap: (index) {
          setState(() {
            page = index;
          });
          print(page);
          print(pageoption[page]);
        },
        height: 50,
        backgroundColor: Color(0xffE8E7E1),
      ),
    );
  }
}
