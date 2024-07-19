import 'package:ecommerce_task/common_widgets/custom_text_field.dart';
import 'package:ecommerce_task/common_widgets/my_elevated_button.dart';
import 'package:ecommerce_task/helper/asset_constants.dart';
import 'package:ecommerce_task/providers/auth_provider.dart';
import 'package:ecommerce_task/theme/button_style.dart';
import 'package:ecommerce_task/theme/colors.dart';
import 'package:ecommerce_task/view/authentication/signup_view.dart';
import 'package:ecommerce_task/view/dashboard/dashboard_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return  SafeArea(child: Scaffold(
      backgroundColor: lightGrey,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18,vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex:3,child: Image(image: AssetImage(AssetConstants.topBackImg),fit: BoxFit.cover,)),
            Text("E-shop",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,color: primaryColor),),
            SizedBox(height: 15,),
            Expanded(flex: 4,
              child: Container(alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(AssetConstants.loginTopImg
                      ,),fit: BoxFit.contain)
                ),
              ),
            ),
            SizedBox(height: 35,),

            Expanded(flex: 6,
              child: ListView(
                shrinkWrap: true,
                children: [

                  CustomTextField(
                    fillColor: white,
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkGrey),
                        borderRadius: BorderRadius.circular(7)),
                    enableBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkGrey),
                        borderRadius: BorderRadius.circular(7)),
                    focusBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkGrey),
                        borderRadius: BorderRadius.circular(7)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: redColor),
                        borderRadius: BorderRadius.circular(7)),
                    hintText: "Email",
                    controller: authProvider.emailController,
                    inputType: TextInputType.emailAddress,
                    inputFormatter: [
                    ],
                    // maxlength: 40,
                    // maxLines: 3,
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    onChanged: (w) {
                      authProvider.validateEmail(w);
                    },
                    errorText:
                    authProvider.isEmailEmpty ? "Enter email address" :  authProvider.isEmailInvalid ? "Enter valid email address": null,
                  ),
                  SizedBox(height: 18,),
                  CustomTextField(hintText: "Password",
                      fillColor: white,controller:authProvider.passwordController,hintSize: 13,
                      enableBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: darkGrey),
                          borderRadius: BorderRadius.circular(10)),
                      focusBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                          borderRadius: BorderRadius.circular(10)),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: redColor),
                          borderRadius: BorderRadius.circular(10)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: darkGrey),
                          borderRadius: BorderRadius.circular(10)),
                      onChanged: (w) {
                        authProvider.validatePassword(w);
                      },
                      contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 12),
                      isPassword: authProvider.isObscure,suffix:Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: InkWell(
                            onTap: ()=>
                            authProvider.onChangeObscure(),
                            child: Icon(!authProvider.isObscure?Icons.visibility_off_rounded:Icons.remove_red_eye_rounded,size: 24,color: darkGrey,)),
                      ) ),


                ],
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: authProvider.loginLoading ?CircularProgressIndicator():MyElevatedButton(child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 18)),
              ), onPressed: () async{
                await authProvider.validateLogin(context);
                if(authProvider.userEmail.isNotEmpty) {
                  navigateDashboard(context);
                }
              }, style: colorBtnWithRadiusStyle),
            ),SizedBox(height: 10,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("New here ? ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
                SizedBox(width: 5,),
                GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => SignupView()),);
                    },
                    child: Text("Signup",style: TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.w700),)),
              ],
            ),
          ],
        ),
      ),
    ));
  }
  navigateDashboard(BuildContext context) {
    Navigator.push(context,  MaterialPageRoute(builder: (context) => DashboardView()),);
  }
}
