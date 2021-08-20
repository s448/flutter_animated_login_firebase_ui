import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reset extends StatefulWidget {
  const Reset({Key? key}) : super(key: key);

  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  FirebaseAuth instance = FirebaseAuth.instance;
  var _email;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios))
          ],
          title: Center(child: Text("Reset password")),
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20,
                        color: Colors.deepPurple,
                        offset: Offset(0, 0))
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'email',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.pink,
                      size: 35,
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (email_value) {
                    _email = email_value;
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: MediaQuery.of(context).size.width,
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: new Text("Reset now"),
                onPressed: () async {
                  try {
                    instance.sendPasswordResetEmail(email: _email);
                    Navigator.pop(context);
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'invalid-email') {
                      SnackBar snackBar = new SnackBar(
                        content: Text("invalid-email"),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }
                },
                splashColor: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
