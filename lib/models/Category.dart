import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_icons.dart';

class Category {
  final String name;
  final IconData icon;
  final String id;

  Category(this.name, this.icon, this.id);

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      json['name'],
      CustomIcons.chair,
      json['_id']
    );
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
