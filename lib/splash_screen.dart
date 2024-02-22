import 'package:flutter/material.dart';
import 'package:my_app/Helper.dart';
import 'package:my_app/home.dart';
import 'package:my_app/phone.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    _navigattohome();
  }

  _navigattohome() async {
    await Future.delayed(Duration(seconds: 3));
    bool islogin = await Helper.getLoginStatus();
    if (!islogin)
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => phone()));
    else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => home()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: size.height * 0.35,
              width: size.width * 0.7,
            ),
            Text(
              'Welcome to Webs Proud!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
