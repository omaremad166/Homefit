import 'package:flutter/material.dart';
import 'package:homefit/models/Category.dart';
import 'package:homefit/widgets/category_card.dart';

class CategoryCardScroller extends StatelessWidget {
  final List<Category> categories;
  final int length;

  CategoryCardScroller(this.categories, this.length);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) =>
              CategoryCard(categories[index], index, length),
        ),
      ),
    );
  }
}
