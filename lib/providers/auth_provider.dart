
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_task/view/dashboard/dashboard_view.dart';
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
  validateSignUp(BuildContext context) {
    validateName(nameController.text);
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    if(!isNameInvalid && !isEmailEmpty && !isEmailInvalid && !isPasswordInvalid) {
      loading=true;
      _register(context);
    }
    else{
      isNameInvalid = true;
      print("invalid");
    }
    notifyListeners();
  }
  validateLogin(BuildContext context) {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);

    if(!isEmailEmpty && !isEmailInvalid && !isPasswordInvalid) {
      // loginLoading=true;
      notifyListeners();
      _signInWithEmailAndPassword(context);

    }
    else{
      isEmailInvalid = true;
      notifyListeners();
    print("invalid");
    }
  }
   _register(BuildContext context) async {
    try{
      final User? user = (await
      auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
      ).user;
      if (user != null) {
        _success = true;
        userEmail = (user.email)??"";
        print("email$userEmail");
        _createUser(user.uid);
      } else {
        _success = true;
      }
      loading =false;
      notifyListeners();
      if (!context.mounted) return;
      navigateDashboard(context);

    }
    catch(e){
      debugPrint(e.toString());
      loading = false;
      notifyListeners();
    }

  }
  void _createUser(uid) async{
    try{
      var data =  {"name":nameController.text,"email":emailController.text} ;
      await FirebaseFirestore.instance
          .collection("user").doc(uid).set(data);
    }
    catch(e){
      debugPrint(e.toString());
      loading = false;
      notifyListeners();
    }
  }
   _signInWithEmailAndPassword(BuildContext context) async {
    final User? user = (await
    auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
    ).user;
    if (user != null) {
        userEmail = (user.email)??"";
    } else {
    }
    print("email$userEmail");
    loginLoading =false;
    notifyListeners();
    // if (!context.mounted) return;
    // navigateDashboard(context);
  }
  navigateDashboard(BuildContext context) {
    Navigator.push(context,  MaterialPageRoute(builder: (context) => DashboardView()),);
  }
 @override
  void dispose() {
    loginLoading = false;
    loading = false;
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}