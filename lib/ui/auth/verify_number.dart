import 'package:flutter/material.dart';


class VerifyNumber extends StatefulWidget {
  final String verificationId;
  const VerifyNumber({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification'),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
