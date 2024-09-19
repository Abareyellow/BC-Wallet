import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  double? deviceWidth, deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Your Cards",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 27,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: addBusinessCard(),
    );
  }

  Widget addBusinessCard() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.blue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
