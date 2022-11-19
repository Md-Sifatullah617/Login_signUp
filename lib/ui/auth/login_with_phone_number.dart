import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/ui/auth/verify_number.dart';
import 'package:untitled/utils/utilis.dart';
import 'package:untitled/widgets/rounded_button.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final phnController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login with Phone Number"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            TextFormField(
              controller: phnController,
              decoration:
                  const InputDecoration(hintText: "+880 123 - 456 - 7893"),
            ),
            const SizedBox(
              height: 50,
            ),
            RoundButton(
                title: "Verify",
                loading: loading,
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                      phoneNumber: phnController.text,
                      verificationCompleted: (_) {
                        setState(() {
                          loading = false;
                        });
                      },
                      verificationFailed: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verificationId, int? token) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyNumber(
                                      verificationId: verificationId,
                                    )));
                        setState(() {
                          loading = false;
                        });
                      },
                      codeAutoRetrievalTimeout: (e) {
                        setState(() {
                          loading = false;
                        });
                        Utils().toastMessage(e.toString());
                      });
                })
          ],
        ),
      ),
    );
  }
}
