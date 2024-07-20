import 'package:ecommerce_task/theme/colors.dart';
import 'package:flutter/material.dart';


class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {

  final String leadingIcon;
  final Color leadingIconColor;
  final IconData? trailingIcon;
  final Function? leadingOnTap;
  final Function? trailingOnTap;
  final String title;
  final double height;
  final bool isBackRequired;
  final Key? iconKey;
  const CustomAppbar({this.isBackRequired=false,this.height=30,this.leadingIconColor = primaryColor,this.title="",this.trailingOnTap,this.leadingOnTap,this.leadingIcon="",this.trailingIcon,this.iconKey,super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Container(color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !isBackRequired?Container(width: 18,):
              IconButton(
                onPressed: () {
                  if(leadingOnTap!=null){
                    leadingOnTap!();
                  }
                  else{
                    // Get.back();
                  }
                },
                icon:  Icon(Icons.arrow_back_ios,size:20,color: black,key: iconKey,semanticLabel: "backIcon"),
              ),
              Expanded(
                child: Text(title,
                  style: const TextStyle(
                      color: white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500
                  ),),
              ),
              // const Spacer(),

              IconButton(
                onPressed: () {
                  trailingOnTap!();
                },
                icon:  const Icon(
                 Icons.logout_rounded,
                  size: 24,color: white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
