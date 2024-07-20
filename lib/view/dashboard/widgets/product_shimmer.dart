import 'package:ecommerce_task/common_widgets/custom_shimmer.dart';
import 'package:ecommerce_task/theme/colors.dart';
import 'package:flutter/material.dart';

class ProductShimmerWidget extends StatelessWidget {
  final bool isLoad;
  const ProductShimmerWidget({this.isLoad =false,super.key});

  @override
  Widget build(BuildContext context) {
    return  CustomShimmer(baseColor: darkGrey,highlightColor: lightGrey,enable: isLoad,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            border: Border.all(color: darkGrey.withOpacity(0.7)),
            color: white,boxShadow: [BoxShadow(color: lightGrey,blurRadius: 3,spreadRadius: 4)]
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(flex: 7,
                  child: Container(
                    decoration: BoxDecoration(
                      color: lightGrey,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomLeft:Radius.circular(15) ),
                    ),
                  )),
              SizedBox(height: 17,),
              Expanded(flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    shimmerContainer(width: 180,height: 10),
                    SizedBox(height: 12,),
                    shimmerContainer(width: 190,height: 8),
                    SizedBox(height: 6,),
                    shimmerContainer(width: 190,height: 8),
                    SizedBox(height: 6,),
                    shimmerContainer(width: 190,height: 8),
                    SizedBox(height: 12,),
                    shimmerContainer(width: 180,height: 10)
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
  Widget shimmerContainer({double height=10,double width=40}) {
    return Container(width: width,height: height,
      decoration: BoxDecoration(
          color: lightGrey,
          borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
