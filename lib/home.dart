import 'package:flutter/material.dart';
import 'FeedingLoad1.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("CALULATOR",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold),), backgroundColor: Colors.amberAccent[100]),
        body: Menu()
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: EdgeInsets.all(14),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: BorderSide(color: Colors.grey), // 테두리 색상 설정
            ),
            title: Text("FEEDING LOAD CALULATOR", textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => FeedingLoad()));
            },
          ),
        )
      ],
    );
  }
}


