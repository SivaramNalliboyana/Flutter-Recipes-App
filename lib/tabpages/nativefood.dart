import 'dart:convert';

import 'package:easyrecipe/models/viewrecipe.dart';
import 'package:easyrecipe/tabpages/categorypage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class NativeFood extends StatefulWidget {
  @override
  _NativeFoodState createState() => _NativeFoodState();
}

class _NativeFoodState extends State<NativeFood> {
  List<CategoryModel> indiafoodrecipes = List<CategoryModel>();
  List<CategoryModel> turkishrecipes = List<CategoryModel>();
  List<CategoryModel> americanrecipes = List<CategoryModel>();

  initState() {
    super.initState();
    print("the length is ${americanrecipes.length}");
  }

  getrecipes(String area) async {
    var url = 'https://www.themealdb.com/api/json/v1/1/filter.php?a=$area';
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    for (var mealdata in result['meals']) {
      CategoryModel model =
          CategoryModel(mealdata['strMeal'], mealdata['strMealThumb']);
      if (area == "Indian") {
        indiafoodrecipes.add(model);
      } else if (area == "Turkish") {
        turkishrecipes.add(model);
      } else if (area == "American") {
        americanrecipes.add(model);
      }
    }
    if (area == "Indian") {
      return indiafoodrecipes;
    } else if (area == "Turkish") {
      return turkishrecipes;
    } else if (area == "American") {
      return americanrecipes;
    }
  }

  handlelength(String area) {
    if (area == "Indian") {
      return 11;
    } else if (area == "Turkish") {
      return 2;
    } else if (area == "American") {
      return 32;
    }
  }

  showareafood(String area) {
    return FutureBuilder(
      future: getrecipes(area),
      builder: (BuildContext context, dataSnaphot) {
        if (!dataSnaphot.hasData) {
          return Center(child: Text("Loading..."));
        }
        return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: handlelength(area),
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
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.0, top: 20.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/india.png'),
                ),
                title: Text(
                "Indian Recipes",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    fontSize: 25),
              ),
              subtitle: Text("Scroll right for more",style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w200,
                    fontSize: 15),),
              )
            ),
            Container(
              height: 300,
              child: showareafood("Indian"),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.0, top: 20.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/turkey.png'),
                ),
                title: Text(
                "Turkish Recipes",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    fontSize: 25),
              ),
              subtitle: Text("Scroll right for more",style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w200,
                    fontSize: 15),),
              )
            ),
            Container(height: 300, child: showareafood("Turkish")),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 20.0, top: 20.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/usa.png'),
                ),
                title: Text(
                "American Recipes",
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                    fontSize: 25),
              ),
              subtitle: Text("Scroll right for more",style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w200,
                    fontSize: 15),),
              )
            ),
            Container(height: 300, child: showareafood("American"))
          ],
        ),
      ),
    );
  }
}
