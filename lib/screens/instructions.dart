import 'package:flutter/material.dart';
import 'package:homefit/models/product.dart';
import 'package:homefit/screens/remote_object.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Instructions extends StatefulWidget {
  final Product product;
  Instructions(this.product);

  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => RemoteObject(widget.product)),
    );
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/images/$assetName', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.only(top: 100),
      contentPadding: EdgeInsets.only(top: 50)
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Tip No. 1",
          body:
              "First, you should move the camera on the floor right and left to recognize it.",
          image: _buildImage('scene-viewer-framed-2.5-33.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tip No. 2",
          body:
              "Wait until white dots appears on the floor then click on it to place the product.",
          image: _buildImage('ARCore.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Tip No. 3",
          body: "Wait seconds for 3d product to appear, finally you are done!",
          image: _buildImage('arcore-apps-feature-4032x3024.jpg'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(5.0, 5.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(15.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}