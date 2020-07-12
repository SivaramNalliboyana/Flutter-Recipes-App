import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tabpages/categorypage.dart';
import 'tabpages/nativefood.dart';
import 'tabpages/vegetarian.dart';

class MainRecipesPage extends StatefulWidget {
  @override
  _MainRecipesPageState createState() => _MainRecipesPageState();
}

class _MainRecipesPageState extends State<MainRecipesPage> with SingleTickerProviderStateMixin {

  TabController tabController;
  @override
  void initState(){
    super.initState();
    tabController = TabController(vsync: this,length: 3);
  }

  @override
  void dispose(){
    tabController.dispose();
    super.dispose();

  }
  buildcards(String title) {
    return Container(
        width: MediaQuery.of(context).size.width / 3,
        height: 40,
        child: Card(
          elevation: 5.0,
          child: Center(
            child: Text(
              title,
              style: GoogleFonts.montserrat(fontWeight: FontWeight.w300),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        backgroundColor: Color(0xffE8E7E1),
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Color(0xffE8E7E1),
          title: Text("Trending\nCategories",style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize:20
          ),),
            bottom: TabBar(
              unselectedLabelColor: Colors.red,
              isScrollable: true,
              controller: tabController,
              tabs: [
                buildcards("Category"),
                buildcards("NativeFood"),
                buildcards("Vegetarian")
            ])
          ),
          body: TabBarView(
            controller: tabController,
            children: [
            CategoryPage(),
            NativeFood(),
            VegetarianPage()
          ]),);
      
  
  }
}



