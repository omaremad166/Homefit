import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:homefit/models/product.dart';
import 'package:homefit/screens/instructions.dart';
import 'package:homefit/screens/remote_object.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_page.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage(this.product);

  @override
  ProductPageState createState() {
    return new ProductPageState();
  }
}

class ProductPageState extends State<ProductPage> {
  void toggle() {
    setState(() {
      MyHomePage.wishList.products.contains(widget.product)
          ? MyHomePage.wishList.products.remove(widget.product)
          : MyHomePage.wishList.products.add(widget.product);
    });
  }

  SharedPreferences sp;

  @override
  Widget build(BuildContext context) {
    final key = new GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      body: new Container(
        color: Colors.white,
        child: new Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  Hero(
                    tag: "product_${widget.product.toString()}",
                    child: CachedNetworkImage(
                      imageUrl: widget.product.imageUrl,
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, string) => Center(
                          child: Icon(
                        Icons.collections,
                        size: 75,
                      )),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: IconButton(
                          icon: Icon(
                            Icons.keyboard_arrow_left,
                            color: Colors.white,
                            size: 40.0,
                          ),
                          onPressed: () => Navigator.of(context).pop())),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(right: 16.0, bottom: 20.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            size: 30.0,
                          ),
                          color: MyHomePage.wishList.products
                                  .contains(widget.product)
                              ? Colors.redAccent
                              : Colors.grey,
                          onPressed: () => toggle(),
                        ),
                      )),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        widget.product.name,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        "\$" + widget.product.cost.toString().split(".")[0],
                        style: TextStyle(
                            color: Color(0xff8E8EF6),
                            fontSize: 19.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "Dimensions: " +
                                  widget.product.width.toString() +
                                  "x" +
                                  widget.product.height.toString() +
                                  "x" +
                                  widget.product.depth.toString() +
                                  " cm",
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 30.0),
                              child: Text(
                                "Color: " + widget.product.color,
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 16.0),
                        height: 2.0,
                        width: 221.0,
                        color: Color(0xffDEDEDE),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.product.description,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            FlatButton(
            
              color: Theme.of(context).primaryColor,
              onPressed: widget.product.modelPath == '' || widget.product.modelPath == null ? null : () {
                navigateInst() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Instructions(widget.product)));
                }

                navigateCam() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RemoteObject(widget.product)));
                }
                
                checkStatus() async {
                  sp = await SharedPreferences.getInstance();
                  if (sp.getBool('firstCam') == null) {
                    sp.setBool('firstCam', true);
                    return Timer(Duration(seconds: 4), navigateInst());
                  } else {
                    return Timer(Duration(seconds: 4), navigateCam());
                  }
                }
                checkStatus();
              },
              disabledColor: Colors.grey,
              shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(90.0)),
              padding: EdgeInsets.symmetric(vertical: 32.0),
              child: Center(
                child: Text(
                  "Try LIVE!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
