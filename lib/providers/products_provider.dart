


import 'package:ecommerce_task/model/product_model.dart';
import 'package:ecommerce_task/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductsProvider with ChangeNotifier {
  late ProductsModel data;

  bool loading = false;
  ProductService service = ProductService();

  getProducts(context) async {
    loading = true;
    data = await service.getProducts(context);
    loading = false;

    notifyListeners();
  }
}