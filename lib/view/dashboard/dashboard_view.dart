import 'package:ecommerce_task/common_widgets/appbar.dart';
import 'package:ecommerce_task/common_widgets/custom_text_field.dart';
import 'package:ecommerce_task/common_widgets/my_elevated_button.dart';
import 'package:ecommerce_task/theme/button_style.dart';
import 'package:ecommerce_task/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isObscure = false;
  @override
  Widget build(BuildContext context) {
    return  SafeArea(child: Scaffold(
      backgroundColor: lightGrey,
      appBar: CustomAppbar(title:"E-shop"),
      body: ListView(
        shrinkWrap: true,
        children: [
          Text("E-shop",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: primaryColor),),
          SizedBox(height: 15,),
          GridView.builder( shrinkWrap: true,physics: ClampingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10,childAspectRatio: 0.7
          ), itemBuilder: (context, index) {
            return Card(
              color: white,elevation: 0.7,shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            );
          },)

        ],
      ),
    ));
  }
}
