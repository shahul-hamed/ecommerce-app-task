import 'package:ecommerce_task/helper/asset_constants.dart';
import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String img;
  const CustomImageWidget({this.img="",super.key});

  @override
  Widget build(BuildContext context) {
    return img.isEmpty?
     errorImage():
    Image.network(img,fit: BoxFit.cover,
      errorBuilder: (context,child,stack)=>errorImage(),
      loadingBuilder: (context,child,loadingProgress)=> loadingProgress == null?child:const Center(child: SizedBox(height: 30,width: 30,child: CircularProgressIndicator(),),),);
  }
  Widget errorImage(){
    return Image.network(AssetConstants.placeholderImg,fit: BoxFit.cover,);
  }
}
