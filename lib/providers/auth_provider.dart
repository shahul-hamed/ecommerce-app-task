


import 'package:ecommerce_task/model/product_model.dart';
import 'package:ecommerce_task/services/product_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  bool loginLoading = false;
  bool isNameInvalid = false;
  bool isEmailInvalid = false;
  bool isEmailEmpty = false;
  bool isPasswordInvalid = false;
  bool isObscure = false;
  String userEmail = "";
  bool _success = false;
  bool get success => _success;
  final FirebaseAuth auth = FirebaseAuth.instance;

  onChangeObscure() {
    isObscure =!isObscure;
    notifyListeners();
  }
  validateName(String s) {
    if(s.isEmpty){
      isNameInvalid = true;
    }
    else{
      isNameInvalid = false;
    }
    notifyListeners();
  }
  validateEmail(String s) {
    if(s.isEmpty){
      isEmailEmpty = true;
      isEmailInvalid = false;
    }
    else if(!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s)) {
      isEmailInvalid = true;
      isEmailEmpty = false;

    }
    else{
      isEmailInvalid = false;
      isEmailEmpty = false;
    }
    notifyListeners();
  }
  validatePassword(String s) {
    if(s.isEmpty){
      isPasswordInvalid = true;
    }
    else{
      isPasswordInvalid = false;
    }
    notifyListeners();
  }
  validateSignUp() {
    validateName(nameController.text);
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    if(!isNameInvalid && !isEmailEmpty && !isEmailInvalid && !isPasswordInvalid) {
      loading=true;
      _register();
    }
    else{
      isNameInvalid = true;
      print("invalid");
    }
    notifyListeners();
  }
  validateLogin() {
    if(!isEmailEmpty && !isEmailInvalid && !isPasswordInvalid) {
      loginLoading=true;
      _signInWithEmailAndPassword();
    }
    else{
      isEmailInvalid = true;
    print("invalid");
    }
    notifyListeners();
  }
  void _register() async {
    final User? user = (await
    auth.createUserWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
    ).user;
    if (user != null) {
       _success = true;
        userEmail = (user.email)??"";
    } else {
        _success = true;
    }
    loading =false;
  }
  void _signInWithEmailAndPassword() async {
    final User? user = (await
    auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
    ).user;
    if (user != null) {
       _success = true;
        userEmail = (user.email)??"";
    } else {
        _success = true;
    }
    loginLoading =false;
  }

}