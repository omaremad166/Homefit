import 'dart:convert';

import 'package:homefit/models/Category.dart';
import 'package:http/http.dart' as http;

import '../custom_icons.dart';

class Product {
  final String imageUrl;
  final String name;
  final int cost;
  final String description;
  final Category category;
  final String id;
  final DateTime createdAt;

  Product(this.imageUrl, this.name, this.cost, this.description, this.category,
      this.id, this.createdAt);

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      'https://majestic-glacier-47307.herokuapp.com/products/' + json['_id'] + '/image',
      json['name'],
      json['price'],
      json['description'],
      new Category('x', CustomIcons.chair, ''),
      json['_id'],
      DateTime.parse(json['createdAt']),
    );
  }

  @override
  String toString() {
    return 'Product{imageUrl: $imageUrl, name: $name, cost: $cost, description: $description, category: $category, id: $id, createdAt: $createdAt}';
  }

  List<Product> parseProducts(String responseBody) { 
   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>(); 
   return parsed.map<Product>((json) =>Product.fromJson(json)).toList(); 
  } 
  
  Future<List<Product>> fetchProducts() async { 
    final response = await http.get('https://majestic-glacier-47307.herokuapp.com/products'); 
    if (response.statusCode == 200) { 
        return parseProducts(response.body); 
    } else { 
        throw Exception('Unable to fetch products from the REST API');
    } 
  }

  Future<List<Product>> getProductsByCategory(String categoryId) async { 
    final response = await http.get('https://majestic-glacier-47307.herokuapp.com/categoryProducts/$categoryId'); 
    if (response.statusCode == 200) { 
        return parseProducts(response.body); 
    } else { 
        throw Exception('Unable to fetch products from the REST API');
    } 
  }
}
