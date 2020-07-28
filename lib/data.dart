import 'package:flutter/material.dart';
import 'package:homefit/custom_icons.dart';
import 'package:homefit/models/Category.dart';
import 'package:homefit/models/product.dart';

class Data {
  static List<Category> categories = [
    Category("Chair", CustomIcons.chair, ''),
    Category("Lamp", CustomIcons.desk_lamp, ''),
    Category("Plant", CustomIcons.plant, ''),
    Category("Other", Icons.timeline, '')
  ];

  static List<Product> products = [
    Product(
        "https://images.pexels.com/photos/112811/pexels-photo-112811.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Elegant Lamp",
        13,
        "Both practical and beautiful, this lamp is a great addition to any workspace",
        getCategoryFromName("Lamp"),
        '0',
        DateTime.now(), '', 0, 0, 0, ''),
    Product(
        "https://images.pexels.com/photos/509922/pexels-photo-509922.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Traditional Chair",
        23,
        "A traditional chair, suitable for any application",
        getCategoryFromName("Chair"),
        '1',
        DateTime.now(), '', 0, 0, 0, ''),
    Product(
        "https://images.pexels.com/photos/56589/cactus-plant-plant-rack-green-56589.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Cactus",
        23,
        "in addition to being a decoration, cactus can also be a health benefit, let's buy cactus in our store because now discount 30%",
        getCategoryFromName("Plant"),
        '2',
        DateTime.now(), '', 0, 0, 0, ''),
    Product(
        "https://images.pexels.com/photos/279618/pexels-photo-279618.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Cupboard",
        13,
        "Simplistic cupboard, which works in every situation",
        getCategoryFromName("Other"),
        '3',
        DateTime.now(), '', 0, 0, 0, ''),
    Product(
        "https://images.pexels.com/photos/276534/pexels-photo-276534.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Reclined Chair",
        26,
        "White reclined chair",
        getCategoryFromName("Chair"),
        '4',
        DateTime.now(), '', 0, 0, 0, ''),
    Product(
        "https://images.pexels.com/photos/993626/pexels-photo-993626.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Alfalfa Plant",
        6,
        "Potted Alfalfa Plant",
        getCategoryFromName("Plant"),
        '5',
        DateTime.now(), '', 0, 0, 0, ''),
    Product(
        "https://images.pexels.com/photos/135168/pexels-photo-135168.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260",
        "Rosemary",
        7,
        "Potted Rosemary Plant",
        getCategoryFromName("Plant"),
        '6',
        DateTime.now(), '', 0, 0, 0, '')
  ];

  static Category getCategoryFromName(name) {
    return categories.firstWhere(
        (c) => c.name.toLowerCase() == name.toString().toLowerCase());
  }
}
