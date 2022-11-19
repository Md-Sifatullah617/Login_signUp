import 'dart:async';

import 'package:flutter/material.dart';
import 'package:untitled/ui/auth/login_screen.dart';
import 'package:untitled/widgets/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/utilis.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool loading = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void login(){
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
        email: emailController.text.toString(),
        password: passwordController.text.toString())
        .then((value){
      setState(() {
        loading = false;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));
        Utils().congoMessage();
      });
    })
        .onError((error, stackTrace){
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
      return null;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        title: const Text("Signup Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "First Name",
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: "Last Name",
                        ),
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                            hintText: "Email",
                            suffixIcon: Icon(Icons.alternate_email_outlined)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*Required";
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                            hintText: "Password",
                            suffixIcon: Icon(Icons.remove_red_eye)),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "*Required";
                          }
                          return null;
                        },
                      )
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
              Center(
                  child: RoundButton(
                      title: "Signup",
                      loading: loading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          login();
                        }
                      })),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text("Login")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
