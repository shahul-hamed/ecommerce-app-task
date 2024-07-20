


import 'package:ecommerce_task/model/product_model.dart';
import 'package:ecommerce_task/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  List<Products> products = [];

  bool loading = false;
  ProductService service = ProductService();

  getProducts(context) async {
    try {
      loading = true;
      ProductsModel data = await service.getProducts(context);
      products = data.products ?? [];
      loading = false;
      notifyListeners();
    }
    catch(e){
      debugPrint(e.toString());
      loading = false;
      notifyListeners();
    }
  }
  double calculateDiscountPrice(Products data) {
    double discountedAmt = ((double.parse(data.discountPercentage.toString()) / 100) * double.parse(data.price.toString()));
    data.discountedPrice = (double.parse(data.price.toString()) -  discountedAmt);
    return data.discountedPrice.roundToDouble();
  }
  @override
  void dispose() {
    products.clear();
    super.dispose();
  }
}