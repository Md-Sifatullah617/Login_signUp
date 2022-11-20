import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/posts/post_screen.dart';
import 'package:untitled/utils/utilis.dart';
import 'package:untitled/widgets/rounded_button.dart';

class VerifyNumber extends StatefulWidget {
  final String verificationId;
  const VerifyNumber({Key? key, required this.verificationId})
      : super(key: key);

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  final auth = FirebaseAuth.instance;
  final verificationCodeController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: "Enter 6 digit code"),
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
                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: verificationCodeController.text.toString());
                  try{
                    auth.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const PostScreen()));
                  }catch(e){
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(e.toString());
                  }
                })
          ],
        ),
      ),
    );
  }
}
