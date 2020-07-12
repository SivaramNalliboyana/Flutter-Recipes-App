import 'dart:convert';

import 'package:easyrecipe/youtubeview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'models/recipesdata.dart';

class RandomMealPage extends StatefulWidget {
  @override
  _RandomMealPageState createState() => _RandomMealPageState();
}

class _RandomMealPageState extends State<RandomMealPage> {
  bool isIngredient = true;
  List<RecipeModel> eachrecipes = [];
  getrecipe() async {
    var url = 'https://www.themealdb.com/api/json/v1/1/random.php';
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List ingredientslist = [];
    for (var i = 1; i < 21; i++) {
      if (result['meals'][0]['strIngredient$i'] != null &&
          result['meals'][0]['strIngredient$i'] != '') {
        ingredientslist.add(result['meals'][0]['strIngredient$i']);
      }
    }
    print("the url is ${result['meals'][0]['strYoutube']}");
    RecipeModel recipeModel = RecipeModel(
        result['meals'][0]['strMealThumb'],
        result['meals'][0]['strArea'],
        result['meals'][0]['strCategory'],
        result['meals'][0]['strTags'],
        result['meals'][0]['strYoutube'],
        result['meals'][0]['strMeal'],
        ingredientslist,
        result['meals'][0]['strInstructions']);
    eachrecipes.add(recipeModel);
    print("the list is $ingredientslist");
    return eachrecipes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: getrecipe(),
            builder: (BuildContext context, dataSnapshot) {
              if (!dataSnapshot.hasData) {
                return Center(
                  child: Text(
                    "Loading",
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                );
              }
              return ListView(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.zero,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Image(
                          fit: BoxFit.fitWidth,
                          image: NetworkImage(dataSnapshot.data[0].image),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 60),
                        child: Center(
                          child: Text(
                            "Random Meal",
                            style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w700,
                                fontSize: 35,
                                color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Positioned(
                          top: 170.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(45.0),
                                topRight: Radius.circular(45.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 20.0),
                                  child: Text(
                                    dataSnapshot.data[0].name,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 20,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(height: 20),
                                dataSnapshot.data[0].category != null
                                    ? Text(
                                        dataSnapshot.data[0].category,
                                        style: GoogleFonts.montserrat(
                                            fontSize: 20),
                                        textAlign: TextAlign.center,
                                      )
                                    : Text("")
                              ],
                            ),
                          )),
                    ],
                  ),
                  Container(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        dataSnapshot.data[0].area,
                        style: GoogleFonts.montserrat(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    YouTubeView(dataSnapshot.data[0].youtube))),
                        child: Container(
                          width: 180,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.red,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.video_library),
                              SizedBox(width: 5.0),
                              Text(
                                "View on Youtube",
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
                  Container(
                      margin: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: dataSnapshot.data[0].tags != null
                          ? Text(
                              dataSnapshot.data[0].tags,
                              style: GoogleFonts.montserrat(
                                  fontSize: 18, color: Colors.black),
                            )
                          : Text("")),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isIngredient = true;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 45,
                            child: Card(
                              elevation: 7.0,
                              child: Center(
                                  child: Text(
                                "Ingredients",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: isIngredient == true
                                        ? Colors.green
                                        : Colors.black),
                              )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isIngredient = false;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 45,
                            child: Card(
                              elevation: 7.0,
                              child: Center(
                                  child: Text(
                                "Directions",
                                style: GoogleFonts.montserrat(
                                    fontSize: 18,
                                    color: isIngredient == false
                                        ? Colors.green
                                        : Colors.black),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  isIngredient == true
                      ? Container(
                          height: MediaQuery.of(context).size.height / 3,
                          child: ListView.builder(
                              itemCount:
                                  dataSnapshot.data[0].ingredientslist.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                    margin: EdgeInsets.only(
                                        left: 20.0, right: 20.0),
                                    height: 60,
                                    child: Card(
                                      child: Center(
                                        child: Text(
                                            dataSnapshot
                                                .data[0].ingredientslist[index],
                                            style: GoogleFonts.montserrat(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w700,
                                            )),
                                      ),
                                    ));
                              }),
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child: dataSnapshot.data[0].directions != null
                              ? Text(
                                  dataSnapshot.data[0].directions,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400),
                                )
                              : Text(""))
                ],
              );
            }));
  }
}
