import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:marketplace/data/models/products_model.dart';
import 'package:marketplace/utils/constans/app_constans.dart';

import '../response/my_response.dart';

class ApiProvider {
  static Future<MyResponse> getProducts() async {
    Uri uri = Uri.https(AppConstants.baseUrl, '/api/v1/products');
    try {
      http.Response data = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKey}",
          "Content-Type": "application/json",
        },
      );
      if (data.statusCode == 200) {
        return MyResponse(
          data: (jsonDecode(data.body)['items'] as List?)
                  ?.map((e) => ProductsModel.fromJson(e))
                  .toList() ??
              [],
        );
      }
      return MyResponse(error: data.statusCode.toString());
    } catch (e) {
      return MyResponse(error: e.toString());
    }
  }
  static Future<MyResponse> addProducts(ProductsModel json) async {
    Uri uri = Uri.https(AppConstants.baseUrl, '/api/v1/products');
    try {
      http.Response data = await http.post(
        uri,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKey}",
          "Content-Type": "application/json",
        },
        body: jsonEncode([json.toJson()])
      );
      if (data.statusCode == 201) {
        return MyResponse(
          data: "Success"
        );
      }
      return MyResponse(error: data.statusCode.toString());
    } catch (e) {
      return MyResponse(error: e.toString());
    }
  }
  static Future<MyResponse> deleteProduct(String productUUID) async {
    Uri uri = Uri.https(AppConstants.baseUrl, "/api/v1/products");
    try {
      http.Response response = await http.delete(
        uri,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKey}",
          "Content-Type": "application/json",
        },
        body: jsonEncode([
          {"_uuid": productUUID}
        ]),
      );
      if (response.statusCode == 200) {
        return MyResponse(data: "Product deleted successfully!");
      }
      return MyResponse(error: response.statusCode.toString());
    } catch (error) {
      return MyResponse(error: error.toString());
    }
  }
  static Future<MyResponse> updateProduct(ProductsModel productModel) async {
    Uri uri = Uri.https(AppConstants.baseUrl, "/api/v1/products");
    try {
      http.Response response = await http.put(
        uri,
        headers: {
          "Authorization": "Bearer ${AppConstants.apiKey}",
          "Content-Type": "application/json",
        },
        body: jsonEncode([productModel.toJsonForUpdate()]),
      );
      if (response.statusCode == 200) {
        return MyResponse(data: "Product updated successfully!");
      }
      return MyResponse(error: response.statusCode.toString());
    } catch (error) {
      return MyResponse(error: error.toString());
    }
  }
}
