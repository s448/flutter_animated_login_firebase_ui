import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_firebase/homepage.dart';

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  FirebaseAuth instance = FirebaseAuth.instance;
  var _email ;
  var _password ;
  bool _obs = true;
  var _user ;

  setSecured() {
    setState(() {
      _obs = !_obs;
    });
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(content: Text(message),backgroundColor: Colors.pink,);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: (() => Navigator.pop(context)),
                icon: Icon(Icons.arrow_back_ios))
          ],
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              "Sign up",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
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
                child: Column(
                  children: [
                    //Email Form Field
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'User name',
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.pink,
                            size: 35,
                          ),
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (user_value) {
                          _user = user_value;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 2,
                      child: Divider(
                        color: Colors.deepPurple,
                        thickness: 1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'email',
                          prefixIcon: Icon(
                            Icons.email,
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
                      height: 2,
                      child: Divider(
                        color: Colors.deepPurple,
                        thickness: 1,
                      ),
                    ),
                    //Password Form Field
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.white))),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            size: 35,
                            color: Colors.pink,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.pink,
                            ),
                            onPressed: () => setSecured(),
                          ),
                        ),
                        onChanged: (value_password) {
                          _password = value_password;
                        },
                        obscureText: _obs,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25,
              ),
              MaterialButton(
                height: 40.0,
                minWidth: MediaQuery.of(context).size.width,
                color: Colors.deepPurple,
                textColor: Colors.white,
                child: new Text("Sign up now"),
                onPressed: () async {
                  try {
                    UserCredential uc =
                        await instance.createUserWithEmailAndPassword(
                            email: _email, password: _password);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => homepage(_user),
                      ),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'email-already-in-use') {

                      showSnackBar("email already in use");
                    } else if (_user == "") {
                      showSnackBar("user cant be null");
                    } else if (e.code == 'invalid-email') {
                      showSnackBar('Invalid email or password');
                    } else if (_user == "") {
                      showSnackBar("user name cant be null");
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
