import 'dart:convert';

import 'package:easyrecipe/tabpages/categorypage.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class VegetarianPage extends StatefulWidget {
  @override
  _VegetarianPageState createState() => _VegetarianPageState();
}

class _VegetarianPageState extends State<VegetarianPage> {
  getrecipes() async {
    var url = 'https://www.themealdb.com/api/json/v1/1/filter.php?c=Vegetarian';
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List<CategoryModel> vegerecipes = List<CategoryModel>();
    for (var mealdata in result['meals']) {
      CategoryModel model =
          CategoryModel(mealdata['strMeal'], mealdata['strMealThumb']);
      vegerecipes.add(model);
    }
    return vegerecipes;
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
