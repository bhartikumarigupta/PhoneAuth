// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_app/Helper.dart';
import 'package:my_app/home.dart';
import 'package:pinput/pinput.dart';

class otp extends StatefulWidget {
  final String Number;
  final String verifyid;
  otp({super.key, required this.verifyid, required this.Number});

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  Future<void> signInWithPhoneAuthCredential(
      PhoneAuthCredential credential) async {
    setState(() => loading = true);
    try {
      await auth.signInWithCredential(credential);
      Helper.saveLoginStatus(true);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => home()));
    } on FirebaseAuthException catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message ?? 'Error occurred during sign in')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('An unknown error occurred')));
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    var code = "";
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            )),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.35,
                width: size.height * 0.35,
                child: Image.asset('assets/logo.png'),
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: "we have sent an OTP to ",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(
                      text:
                          "+91 ${widget.Number.toString().substring(0, 2)}*****${widget.Number.toString().substring(8)}",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Pinput(
                length: 6,
                showCursor: true,
                onChanged: (value) {
                  code = value;
                },
              ),
              SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                              verificationId: widget.verifyid, smsCode: code);
                      print("Credential: $credential");
                      // Sign the user in (or link) with the credential
                      print(widget.verifyid);

                      await signInWithPhoneAuthCredential(credential);
                      print("otp verified");
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("${e.toString()}"),
                      ));
                      print(e.toString());
                      setState(() {
                        loading = false;
                      });
                    }
                  },
                  child: loading == false
                      ? Text("get started",
                          style: TextStyle(fontSize: 18, color: Colors.white))
                      : CircularProgressIndicator(
                          color: Colors.white,
                        ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.brown.shade400,
                      textStyle: TextStyle(fontSize: 18, color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () async {
                        setState(() {
                          loading = true;
                        });
                        // Create a PhoneAuthCredential with the code
                        try {
                          var phone;
                          PhoneAuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: widget.verifyid,
                                  smsCode: code);

                          // Sign the user in (or link) with the credential
                          await auth.signInWithCredential(credential);
                          print("otp verified");
                          setState(() {
                            loading = false;
                          });
                          Helper.saveLoginStatus(true);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => home()));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("${e.toString()}"),
                          ));
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: Text(
                        "Resend OTP",
                        style: TextStyle(color: Colors.blue, fontSize: 16),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
