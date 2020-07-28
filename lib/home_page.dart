import 'package:flutter/material.dart';
import 'package:homefit/screens/category_page.dart';
import 'package:homefit/widgets/custom_app_bar.dart';
import 'package:homefit/models/shopping_basket.dart';
import 'package:homefit/models/wishlist.dart';
import 'package:homefit/models/product.dart';
import 'package:homefit/widgets/category_card_scroller.dart';
import 'package:homefit/widgets/product_list_item.dart';
import 'package:homefit/widgets/hot_product_card.dart';

import 'custom_icons.dart';
import 'models/Category.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  static ShoppingBasket shoppingBasket = ShoppingBasket();
  static WishList wishList = WishList();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  String searchTerm = "";

  Future<List<Product>> futureProducts;
  Future<List<Product>> futureLatestProducts;
  Product x = new Product(
      '',
      '',
      0,
      '',
      new Category('', CustomIcons.chair, ''),
      '1',
      DateTime.now(),
      '',
      0,
      0,
      0,
      '');

  Future<List<Category>> futureCategories;
  Category y = new Category('', CustomIcons.chair, '');

  @override
  void initState() {
    super.initState();
    futureProducts = x.fetchProducts();
    futureCategories = y.fetchCategories();
    futureLatestProducts = x.getLatestProducts();
  }

  List<Product> shuffleAndReturn(List<Product> products) {
    List<Product> r = products;
    r.shuffle();
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: Container(
        padding: EdgeInsets.only(left: 16.0, top: 32.0),
        width: 250.0,
        color: Colors.white,
        child: FutureBuilder<List<Category>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            List<Category> categories = snapshot.data;
            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    "Categories",
                    style: TextStyle(fontSize: 28.0),
                  ),
                ),
              ]..addAll(
                  categories.map(
                    (c) => Container(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => CategoryPage(c)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Icon(c.icon),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(c.name),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            );
          },
        ),
      ),
      appBar: CustomAppBar((s) {
        setState(() {
          searchTerm = s;
        });
      }, scaffoldKey),
      body: searchTerm == ""
          ? ListView(
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Text(
                    "Category",
                    style: TextStyle(
                        fontWeight: FontWeight.w100, color: Color(0xff444444)),
                  ),
                ),
                FutureBuilder<List<Category>>(
                  future: futureCategories,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    List<Category> categories = snapshot.data;
                    return CategoryCardScroller(categories, categories.length);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    "Latest Items",
                    style: TextStyle(
                        fontWeight: FontWeight.w100, color: Color(0xff444444)),
                  ),
                ),
                FutureBuilder<List<Product>>(
                  future: futureLatestProducts,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    List<Product> products = snapshot.data;
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: GridView.count(
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.798,
                        mainAxisSpacing: 16.0,
                        crossAxisSpacing: 16.0,
                        children: products.map((p) => ProductCard(p)).toList(),
                        shrinkWrap: true,
                      ),
                    );
                  },
                )
              ],
            )
          : Container(
              child: FutureBuilder<List<Product>>(
                future: futureProducts,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  List<Product> products = snapshot.data;
                  return ListView.builder(
                    itemCount: products
                        .where((p) => p.name
                            .toLowerCase()
                            .contains(searchTerm.toLowerCase()))
                        .length,
                    itemBuilder: (ctx, index) {
                      return ProductListItem(products
                          .where((p) => p.name
                              .toLowerCase()
                              .contains(searchTerm.toLowerCase()))
                          .toList()[index]);
                    },
                  );
                },
              ),
            ),
    );
  }
}
