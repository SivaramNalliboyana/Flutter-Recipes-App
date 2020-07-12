import 'dart:convert';

import 'package:easyrecipe/models/recipesdata.dart';
import 'package:easyrecipe/models/viewrecipe.dart';
import 'package:easyrecipe/subtabspage/breakfast.dart';
import 'package:easyrecipe/subtabspage/dessertpage.dart';
import 'package:easyrecipe/subtabspage/starterpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3);
  }

  List<CategoryModel> seafoodrecipes = List<CategoryModel>();

  getrecipes(String title) async {
    var url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=$title';
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    for (var mealdata in result['meals']) {
      CategoryModel model =
          CategoryModel(mealdata['strMeal'], mealdata['strMealThumb']);
      seafoodrecipes.add(model);
    }
    return seafoodrecipes;
  }

  showseafood() {
    return FutureBuilder(
      future: getrecipes('Seafood'),
      builder: (BuildContext context, dataSnaphot) {
        if (!dataSnaphot.hasData) {
          return Center(child: Text("Loading..."));
        }
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: seafoodrecipes.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    child: Hero(
                        tag: dataSnaphot.data[index].name,
                        child: Image(
                          image: NetworkImage(dataSnaphot.data[index].image),
                        )),
                  ),
                  Container(
                    height: 145.0,
                    width: 200.0,
                    margin: EdgeInsets.only(
                        left: 70.0,
                        right: 50.0,
                        top: MediaQuery.of(context).size.height / 2 - 100),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          dataSnaphot.data[index].name,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewRecipe(
                                          dataSnaphot.data[index].name))),
                              color: Color(0xffDB8C2C),
                              child: Center(
                                child: Text("View",
                                    style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white)),
                              )),
                          Text(
                            "Sea Food",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700, fontSize: 15),
                          )
                        ],
                      ),
                    ]),
                  )
                ],
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            height: 300,
            child: showseafood(),
          ),
          SizedBox(
            height: 10.0,
          ),
          TabBar(
              controller: tabController,
              isScrollable: true,
              indicatorColor: Colors.black,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
              tabs: [
                Tab(
                  child: Text("Breakfast"),
                ),
                Tab(
                  child: Text("Starter"),
                ),
                Tab(
                  child: Text("Dessert"),
                ),
              ]),
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height - 450,
              child: TabBarView(controller: tabController, children: [
                BreakFast(),
                StarterPage(),
                DessertPage(),
              ]),
            ),
          )
        ],
      ),
    ));
  }
}

class CategoryModel {
  final String name;
  final String image;

  CategoryModel(this.name, this.image);
}
