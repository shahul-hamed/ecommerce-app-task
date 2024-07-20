import 'dart:convert';

import 'package:ecommerce_task/helper/api_constants.dart';
import 'package:ecommerce_task/model/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ProductService{
  Future<ProductsModel> getProducts(context) async {
     ProductsModel data = ProductsModel();
    try {
      final response = await http.get(
        Uri.parse(ApiConstants.productListApi),
      );
      if (response.statusCode == 200) {
        final item = json.decode(response.body);
        data = ProductsModel.fromJson(item);// Mapping json response to our data model
      } else {
        debugPrint('Error Occurred');
      }
    } catch (e) {
      debugPrint('Error Occurred$e');
    }
    return data;
  }
}