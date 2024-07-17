import 'package:ecommerce_task/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class  CustomTextField extends StatelessWidget {

  final Color cursorColor;
  final bool isSuffix;
  final bool isPassword;
  final bool obscureText;
  final bool autofocus;
  final bool enable;
  final Widget? suffix;
  final String hintText;
  final String? errorText;
  final Color hintColor;
  final Color fillColor;
  final double hintSize;
  final double textSize;
  final double horizontalPadding;
  final int maxLines;
  final int? maxlength;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? enableBorder;
  final InputBorder? focusBorder;
  final InputBorder? errorBorder;
  final InputBorder? border;
  final TextInputType? inputType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatter;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String prefixIcon;
  final Function? suffixOnTap;
  final Function? onTap;
  final Function(String)? onChanged;
  final BoxConstraints? prefixConstraints;
  final BoxConstraints? suffixConstraints;
  final Function? onEditComplete;
  const CustomTextField({
    this.cursorColor =primaryColor,
    this.prefixIcon="",
    this.onTap,
    this.errorBorder,
    this.contentPadding=const EdgeInsets.only(bottom: 10),
    this.prefixConstraints,
    this.errorText,
    this.suffixConstraints,
    this.enableBorder,
    this.focusBorder,
    this.border,
    this.autofocus=false,
    this.enable=true,
    this.onChanged,
    this.onEditComplete,
    this.inputType,
    this.textCapitalization =TextCapitalization.none,
    this.inputFormatter,
    this.controller,
    this.focusNode,
    this.horizontalPadding=15,
    this.maxLines=1,
    this.maxlength,
    this.hintSize =12,
    this.obscureText=false,
    this.suffixOnTap,
    this.textSize=18,this.fillColor=white,this.isSuffix=false,this.isPassword=false,this.hintText="",this.suffix,this.hintColor= black,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextField(controller: controller,
      keyboardType: inputType,maxLength: maxlength,focusNode: focusNode,
     maxLines: maxLines,
     style: const TextStyle(color: black),
     textCapitalization: textCapitalization,
      inputFormatters: inputFormatter ?? [
        if(inputType == TextInputType.number)
        FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: onChanged,
      onEditingComplete:(){
        if(onEditComplete!=null){
          onEditComplete!();
        }
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onTap:(){
      if(onTap!=null){
        onTap!();
      }
      },obscureText: isPassword,
      decoration:  InputDecoration(
        hintText: hintText,counterText: "",
        errorText: errorText,fillColor: fillColor,
          enabled: enable,
        hintStyle: TextStyle(
          fontSize: hintSize,color: hintColor
        ),
        // prefixIcon:  prefixIcon.isEmpty?null:MyImage(img: prefixIcon,color: black,height: 17,fit: BoxFit.fitHeight,),
          suffixIcon:
        suffix==null?null:InkWell(
          onTap: suffixOnTap==null?null:(){suffixOnTap!();},
          child: suffix),
        prefixIconConstraints: const BoxConstraints(
            minHeight: 18,
            minWidth: 20
        ),
        suffixIconConstraints: const BoxConstraints(
            minHeight: 18,
            minWidth: 20
        ),
        contentPadding: contentPadding,
        enabledBorder: enableBorder,
        focusedBorder: focusBorder,
        errorBorder: errorBorder,
        border: border ),
    );
  }
}