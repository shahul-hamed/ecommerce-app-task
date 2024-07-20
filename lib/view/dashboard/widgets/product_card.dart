import 'package:ecommerce_task/helper/asset_constants.dart';
import 'package:ecommerce_task/model/product_model.dart';
import 'package:ecommerce_task/theme/colors.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  final bool isDiscountApply;
  final double calculatedDiscountPrice;
  const ProductCard({required this.product,required this.calculatedDiscountPrice,this.isDiscountApply=false,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: white,border: Border.all(color: darkGrey.withOpacity(0.7)),
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [BoxShadow(color: lightGrey,blurRadius: 2)]
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 6,
              child: product.images == null?Image.network(AssetConstants.placeholderImg,fit: BoxFit.cover,):Image.network("${product.images?.last}",fit: BoxFit.cover,loadingBuilder: (context,child,loadingProgress)=> loadingProgress == null?child:const Center(child: SizedBox(height: 35,width: 35,child: CircularProgressIndicator(),),),)),

          Expanded(flex:6,child: ListView(
            shrinkWrap: true,physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 10),
            children: [
              Text("${product.title}",style: const TextStyle(fontSize: 12,color: black,fontWeight: FontWeight.w700),),
              const SizedBox(height: 7,),
              Text("${product.description}",style: const TextStyle(fontSize: 12,color: black,fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,maxLines: 3,),
              const SizedBox(height: 10,),
              !isDiscountApply?Text("\$${product.price}",style: const TextStyle(fontSize: 12,color: black,fontWeight: FontWeight.w400),overflow: TextOverflow.ellipsis,):
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("\$${product.price}",style: const TextStyle(fontSize: 11,decoration: TextDecoration.lineThrough,color: darkGrey,fontWeight: FontWeight.w500),),
                    const SizedBox(width: 6.5,),
                    Text("\$$calculatedDiscountPrice",style: const TextStyle(fontSize: 12,color: black,fontWeight: FontWeight.w400),),
                    const SizedBox(width: 6.5,),
                    Text("${product.discountPercentage}% off",style: const TextStyle(fontSize: 12,color: Colors.green,fontWeight: FontWeight.w700),),
                  ],
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}
