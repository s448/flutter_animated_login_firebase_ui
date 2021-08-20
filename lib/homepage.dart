import 'package:flutter/material.dart';

class homepage extends StatefulWidget{
  var val;
  homepage(this.val);
  @override
  State<StatefulWidget> createState() {
    return homepageState();
  }

}

class homepageState extends State<homepage>{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Home")),
        ),
        body: Center(
          child: Column(
            children: [
              Text("That's great...",style: TextStyle(fontSize: 22),),
              Text("Welcome  ${widget.val}",style: TextStyle(fontSize: 22),),
            ],
          ),
        ),
      ),
    );
  }

}