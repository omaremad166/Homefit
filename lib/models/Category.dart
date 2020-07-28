import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Category {
  final String name;
  final IconData icon;
  final String id;

  Category(this.name, this.icon, this.id);

  factory Category.fromJson(Map<String, dynamic> json) {
    if(json['name'] == "Others")
    {
      return Category(
        json['name'],
        Icons.dashboard,
        json['_id']
      );
    }
    else if(json['name'] == "Sofas")
    {
      return Category(
        json['name'],
        Icons.weekend,
        json['_id']
      );
    }
    else if(json['name'] == "Beds")
    {
      return Category(
        json['name'],
        Icons.local_hotel,
        json['_id']
      );
    }
    // else if(json['name'] == "Beds")
    // {
    //   return Category(
    //     json['name'],
    //     Icons.,
    //     json['_id']
    //   );
    // }
    else if(json['name'] == "Chairs")
    {
      return Category(
        json['name'],
        Icons.event_seat,
        json['_id']
      );
    }
    else
    {
      return Category(
        json['name'],
        Icons.trending_down,
        json['_id']
      );
    }
  }

  @override
  String toString() {
    return 'Category{name: $name, icon: $icon, _id: $id}';
  }

  List<Category> parseCategories(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Category>((json) =>Category.fromJson(json)).toList(); 
  } 
  
  Future<List<Category>> fetchCategories() async { 
    final response = await http.get('https://homefitapi.herokuapp.com/categories'); 
    if (response.statusCode == 200) { 
        return parseCategories(response.body); 
    } else { 
        throw Exception('Unable to fetch categories from the REST API');
    } 
  } 
}
