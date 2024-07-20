import 'package:ecommerce_task/common_widgets/custom_text_field.dart';
import 'package:ecommerce_task/common_widgets/my_elevated_button.dart';
import 'package:ecommerce_task/helper/asset_constants.dart';
import 'package:ecommerce_task/providers/auth_provider.dart';
import 'package:ecommerce_task/theme/button_style.dart';
import 'package:ecommerce_task/theme/colors.dart';
import 'package:ecommerce_task/view/authentication/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class SignupView extends StatelessWidget {
   const SignupView({super.key});



  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return  SafeArea(child: Scaffold(
      backgroundColor: lightGrey,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 18),
            child: const Text("E-shop",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700,color: primaryColor),),
          ),
          Expanded(flex: 5,
            child: Container(alignment: Alignment.center,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AssetConstants.loginTopImg
                    ,),fit: BoxFit.fill)
              ),
            ),
          ),
          const SizedBox(height: 35,),

          Expanded(flex: 6,
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 18),
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
                  hintText: "Name",
                  controller: authProvider.nameController,
                  inputType: TextInputType.name,
                  inputFormatter: const [
                  ],
                  // maxlength: 40,
                  // maxLines: 3,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  onChanged: (w) {
                    authProvider.validateName(w);
                  },
                  errorText:
                  authProvider.nameInvalid ? "Enter name" : null,
                ),
                const SizedBox(height: 18,),
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
                  inputFormatter: const [
                  ],
                  // maxlength: 40,
                  // maxLines: 3,
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  onChanged: (w) {
                      authProvider.validateEmail(w);
                  },
                  errorText:
                  authProvider.emailEmpty ? "Enter email address" :  authProvider.emailInvalid ? "Enter valid email address": null,
                ),
                const SizedBox(height: 18,),
                CustomTextField(hintText: "Password",
                    fillColor: white,controller:authProvider.passwordController,hintSize: 13,
                    enableBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkGrey),
                        borderRadius: BorderRadius.circular(10)),
                    focusBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: redColor),
                        borderRadius: BorderRadius.circular(10)),
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(color: darkGrey),
                        borderRadius: BorderRadius.circular(10)),
                    onChanged: (w) {
                      authProvider.validatePassword(w);
                    },
                    errorText:
                    authProvider.passInvalid ? "Enter password" : null,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 15,vertical: 12),isPassword: authProvider.isObscure,suffix:Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: InkWell(
                          onTap: ()=>authProvider.onChangeObscure(),
                          child: Icon(!authProvider.isObscure?Icons.visibility_off_rounded:Icons.remove_red_eye_rounded,size: 24,color: darkGrey,)),
                    ) ),


              ],
            ),
          ),
          const SizedBox(height: 20,),
          Center(
            child: authProvider.loading ?const CircularProgressIndicator():MyElevatedButton(onPressed: (){
              authProvider.validateSignUp(context);
            }, style: colorBtnWithRadiusStyle, child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
              child: Text('Signup',style: TextStyle(color: Colors.white,fontSize: 18)),
            )),
          ),const SizedBox(height: 10,),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an account ? ",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400),),
              const SizedBox(width: 5,),
              GestureDetector(
                  onTap: (){
                    authProvider.clearInputs();
                    Navigator.pushReplacement(context,  MaterialPageRoute(builder: (context) => const LoginView()),);
                  },
                  child: const Text("Login",style: TextStyle(color: primaryColor,fontSize: 18,fontWeight: FontWeight.w700),)),
            ],
          ),
          const SizedBox(height: 25,),

        ],
      ),
    ));
  }
}
