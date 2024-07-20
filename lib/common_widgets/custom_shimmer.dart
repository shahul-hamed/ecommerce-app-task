
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomShimmer extends StatelessWidget{
  final Widget child;
  final bool enable;
  final Color baseColor;
  final Color highlightColor;

  const CustomShimmer({Key? key,required this.child,required this.enable,required this.baseColor,required this.highlightColor}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return enable?Shimmer.fromColors(baseColor: baseColor, highlightColor: highlightColor, child: child):child;
  }

}