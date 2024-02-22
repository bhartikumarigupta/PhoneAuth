import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Helper.dart';
import 'package:my_app/phone.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animate_do/animate_do.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Center(
            child: const Text(
              'Webs Proud Technologies',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 18, 94, 106)),
      body: Container(
        color: Color.fromARGB(255, 18, 94, 106),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                child: Image.asset(
                  'assets/Designer.png',
                  height: size.height * 0.35,
                  width: size.width * 0.7,
                ),
              ),

              // ...

              FadeInDown(
                duration: const Duration(milliseconds: 1200),
                child: Text(
                  'Welcome to home Screen',
                  style: TextStyle(
                    // color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(136, 239, 154, 154),
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(color: Colors.white, width: 1),
                ),
                child: FadeInUp(
                  child: TextButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Helper.saveLoginStatus(false);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => phone()));
                    },
                    child: FadeOut(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
