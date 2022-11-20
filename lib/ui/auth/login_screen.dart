import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/posts/post_screen.dart';
import 'package:untitled/ui/auth/signup_screen.dart';
import 'package:untitled/utils/utilis.dart';
import 'package:untitled/widgets/rounded_button.dart';

import 'login_with_phone_number.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _auth = FirebaseAuth.instance;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // emailController.dispose();
    // passwordController.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
          // Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const PostScreen()));
          Utils().succesMessage();
          setState(() {
            loading = false;
          });
    })
        .onError((error, stackTrace) {
          debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Login Page'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: const InputDecoration(
                              hintText: "Email",
                              helperText: "enter email e.g isuIT@gmail.com",
                              prefixIcon: Icon(Icons.email_rounded)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please input a valid Email";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                              hintText: "Password",
                              helperText:
                                  "*   At least 12 characters (required for your Muhlenberg \n     password)—the more characters, the better.\n*   A mixture of both uppercase and lowercase letters.\n*   A mixture of both uppercase and lowercase letters.\n*   A mixture of letters and numbers.\n*   Inclusion of at least one special character, e.g., ! @ # ? ]",
                              prefixIcon: Icon(Icons.lock_open_rounded)),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please input a valid Password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 50),
                        RoundButton(
                          title: "Login",
                          loading: loading,
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()));
                        },
                        child: const Text("Sign up"))
                  ],
                ),
                const SizedBox(height: 30,),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginWithPhoneNumber()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.black,
                      )
                    ),
                    child: const Center(
                      child: Text("Login with Phone Number", style: TextStyle(fontSize: 15,color: Colors.purple),),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
