import 'dart:convert';

import 'package:easyrecipe/models/viewrecipe.dart';
import 'package:easyrecipe/tabpages/categorypage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
class DessertPage extends StatefulWidget {
  @override
  _DessertPageState createState() => _DessertPageState();
}

class _DessertPageState extends State<DessertPage> {
  List<CategoryModel> dessertlist = List<CategoryModel>();
  getbreakfastrecipe() async {
    var url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=Dessert';
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    for (var mealdata in result['meals']) {
      CategoryModel model =
          CategoryModel(mealdata['strMeal'], mealdata['strMealThumb']);
      dessertlist.add(model);
    }
    return dessertlist;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getbreakfastrecipe(),
        builder: (BuildContext context, dataSnapshot) {
          if (!dataSnapshot.hasData) {
            return Center(child: Text("Loading"));
          }
          return ListView.builder(
              itemCount: dessertlist.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: Card(
                      child: ListTile(
                        leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0)),
                          width: 45,
                          child: Image(
                            image: NetworkImage(dataSnapshot.data[index].image),
                          ),
                        ),
                        title: Text(
                          dataSnapshot.data[index].name,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                          ),
                        ),
                        trailing: GestureDetector(onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewRecipe(dataSnapshot.data[index].name))),child: Icon(Icons.arrow_forward_ios,size:32)),
                      ),
                    ));
              });
        });
  }
}