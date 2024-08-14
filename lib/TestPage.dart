import "package:flutter/material.dart";

class TestPage extends StatelessWidget {
  TestPage({super.key});

  final double IMAGE_SIZE = 200;

  static final List<String> images = [
    "./assets/images/login_image01.png",
    "./assets/images/login_image02.png",
    "./assets/images/login_image03.png",
    "./assets/images/login_image04.png",
  ];

  List<Widget> createList() {
    List<Widget> result = [];
    for (String image in images) {
      result.add(Image.asset(
        image,
        width: IMAGE_SIZE,
        height: IMAGE_SIZE,
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: createList(),
    );
  }
}
