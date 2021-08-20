import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Reset.dart';
import 'SignUp.dart';

class aniImg extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return aniImgState();
  }
}

class aniImgState extends State<aniImg> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  )..repeat(reverse: true);

  late Animation<Offset> _animation = Tween(
    begin: Offset.zero,
    end: Offset(0, 0.04),
  ).animate(_animationController);
  bool _obs = true;

  setSecured() {
    setState(() {
      _obs = !_obs;
    });
  }

  void showSnackBar(String message) {
    SnackBar snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.pink,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print("there is no users");
      } else {
        print("user initialized");
      }
    });
  }

  var _email = "";
  var _password = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Positioned(
                    child: SlideTransition(
                      position: _animation,
                      child: Image.asset('assets/rocket.png'),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.deepPurple, Colors.pink]),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    width: 95,
                    height: 40,
                    left: 0,
                    top: 60,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
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
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  size: 30,
                                  color: Colors.pink,
                                ),
                                border: InputBorder.none,
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (valueEmail) {
                                _email = valueEmail;
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
                                border: Border(
                                    bottom: BorderSide(color: Colors.white))),
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.vpn_key,
                                  size: 30,
                                  color: Colors.pink,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: Colors.pink,
                                  ),
                                  onPressed: () => setSecured(),
                                ),
                                border: InputBorder.none,
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.grey),
                              ),
                              onChanged: (valuePassword) {
                                _password = valuePassword;
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
                      child: new Text("Login"),
                      onPressed: () async {
                        try {
                          UserCredential uc =
                              await instance.signInWithEmailAndPassword(
                                  email: _email, password: _password);
                          showSnackBar("Login successfully");
                        } on FirebaseAuthException catch (e) {
                          if (_email == "" || _password == "") {
                            showSnackBar(
                                "username username or password can't be null");
                          } else if (e.code == 'invalid-email') {
                            showSnackBar("user not found");
                          } else if (e.code == 'user-not-found') {
                            showSnackBar("Invalid email or password");
                          }
                        }
                      },
                      splashColor: Colors.redAccent,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Forget your password ?"),
                          TextButton(
                            onPressed: (() {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Reset()));
                            }),
                            child: Text("Reset"),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              thickness: 1,
                              color: Colors.black,
                              height: 36,
                            ),
                          ),
                        ),
                        Text("or"),
                        Expanded(
                          child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              thickness: 1,
                              color: Colors.black,
                              height: 36,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Row(
                        children: [
                          Text("Don not have an account ?"),
                          TextButton(
                            onPressed: (() => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SignUp(),
                                    ),
                                  )
                                }),
                            child: Text(
                              'Create an account',
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
