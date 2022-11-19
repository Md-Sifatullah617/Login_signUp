import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/posts/post_screen.dart';

import 'dart:async';

import 'package:untitled/ui/auth/login_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user != null){
      Timer(
          const Duration(seconds: 5),
              () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const PostScreen())));
    }else{
      Timer(
          const Duration(seconds: 5),
              () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())));
    }

  }
}
