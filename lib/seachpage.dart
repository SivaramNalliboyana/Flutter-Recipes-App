import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  gettest() async {
    var url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=Arrabiata';
    var response = await http.get(url);
    var result = jsonDecode(response.body);
    List ingredientlist = [];
    List keyslist = [];
    for (var i = 1; i < 21; i++) {
      if (result['meals'][0]['strIngredient$i'] != null && result['meals'][0]['strIngredient$i'] != '' ) {
        print(result['meals'][0]['strIngredient$i']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () => gettest());
  }
}
