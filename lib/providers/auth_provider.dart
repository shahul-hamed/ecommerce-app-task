
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_task/helper/base_constants.dart';
import 'package:ecommerce_task/utils/utility.dart';
import 'package:ecommerce_task/view/authentication/login_view.dart';
import 'package:ecommerce_task/view/dashboard/dashboard_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ecommerce_task/main.dart' as app;


class AuthProvider with ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool get nameInvalid => _isNameInvalid;
  bool get passInvalid => _isPasswordInvalid;
  bool get emailEmpty => _isEmailEmpty;
  bool get emailInvalid => _isEmailInvalid;
  bool loading = false;
  bool loginLoading = false;
  bool _isNameInvalid = false;
  bool _isEmailInvalid = false;
  bool _isEmailEmpty = false;
  bool _isPasswordInvalid = false;
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
    _isNameInvalid =false;
    _isNameInvalid = s.isEmpty;
    notifyListeners();
  }
  validateEmail(String s) {

    if(s.isEmpty){
      _isEmailEmpty = true;
      _isEmailInvalid = false;
    }
    else if(!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(s)) {
      _isEmailInvalid = true;
      _isEmailEmpty = false;
    }
    else{
      _isEmailInvalid = false;
      _isEmailEmpty = false;
    }
    notifyListeners();
  }
  validatePassword(String s) {
    if(s.isEmpty){
      _isPasswordInvalid = true;
    }
    else{
      _isPasswordInvalid = false;
    }
    notifyListeners();
  }
  validateSignUp(BuildContext context) {
    if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && !emailInvalid && passwordController.text.isNotEmpty) {
      loading=true;
      _register(context);
    }
    else{
      validateName(nameController.text);
      validateEmail(emailController.text);
      validatePassword(passwordController.text);
    }
    notifyListeners();
  }
  validateLogin(BuildContext context) {
    if(emailController.text.isNotEmpty && !emailInvalid && passwordController.text.isNotEmpty) {
      loginLoading=true;
      notifyListeners();
      _signInWithEmailAndPassword(context);
    }
    else{
      validateEmail(emailController.text);
      validatePassword(passwordController.text);
      notifyListeners();
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
        _createUser(user.uid);
      } else {
        _success = true;
      }
      loading =false;
      notifyListeners();
      Utility.showToast("Successfully registered ${user?.email}");
      if (!context.mounted) return;
      navigateLogin(context);
    }
    catch(e){
      debugPrint(e.toString());
      loading = false;
      notifyListeners();
      /// handling if email already existing or not
      if(e.toString().contains(BaseConstants.emailAlreadyInUseCode)){
        Utility.showToast(BaseConstants.emailAlreadyInUseMsg);
        navigateLogin(context);
      }
      else
        {
          Utility.showToast(BaseConstants.registrationFailed);
        }
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
    print("user${await user!.getIdToken()}");
    GetStorage().write('token', await user.getIdToken());
      userEmail = (user.email)??"";
      loginLoading =false;
    notifyListeners();
    Utility.showToast(BaseConstants.loggedInSuccess);
    if (!context.mounted) return;
    navigateDashboard(context);
  }
  navigateDashboard(BuildContext context) {
    GetStorage().write('isLoggedIn', true);
    app.main();
    Navigator.push(context,  MaterialPageRoute(builder: (context) => const DashboardView()),);
  }
  navigateLogin(BuildContext context) {
    Navigator.push(context,  MaterialPageRoute(builder: (context) => const LoginView()),);
  }
  clearInputs() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    GetStorage().write('isLoggedIn', false);
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