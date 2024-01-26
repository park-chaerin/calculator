import 'package:flutter/material.dart';

class HoseSize extends StatelessWidget {
  const HoseSize({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Hose Size", style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Colors.amberAccent[100], ),
      body: Text("이지미가 나을까 표가 나을까.. 고민이 되네..."),
    );
  }
}
