import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_ap/models.dart/product.dart';

class ProductController extends GetxController with StateMixin {
  Product product = Product();
  var isDataLoading = false.obs;

  TextEditingController searchTextEditController = TextEditingController();
  RxString searchVal = ''.obs;

  List<String> dropdownitems = [];

  @override
  void onInit() {
    super.onInit();
    getApi();
  }

  getApi() async {
    try {
      isDataLoading(true);
      http.Response response = await http.get(
        Uri.tryParse('https://dummyjson.com/products')!,
      );
      if (response.statusCode == 200) {
        getCategoryList();
        return product = Product.fromJson(json.decode(response.body));
      } else {
        'Retry';
      }
    } catch (e) {
      log('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }

  getCategory(String categoryItem) async {
    try {
      isDataLoading(true);
      http.Response response = await http.get(
        Uri.tryParse('https://dummyjson.com/products/category/$categoryItem')!,
      );
      if (response.statusCode == 200) {
        return product = Product.fromJson(json.decode(response.body));
      } else {
        'Retry';
      }
    } catch (e) {
      log('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }

  getCategoryList() async {
    try {
      isDataLoading(true);
      http.Response response = await http.get(
        Uri.tryParse('https://dummyjson.com/products/categories')!,
      );
      if (response.statusCode == 200) {
        dropdownitems =
            (jsonDecode(response.body) as List<dynamic>).cast<String>();
        change(dropdownitems);
      } else {
        'Retry';
      }
    } catch (e) {
      log('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }

  getSearch(String keyword) async {
    try {
      isDataLoading(true);
      http.Response response = await http.get(
        Uri.tryParse('https://dummyjson.com/products/search?q=$keyword')!,
      );
      if (response.statusCode == 200) {
        return product = Product.fromJson(json.decode(response.body));
      } else {
        'Retry';
      }
    } catch (e) {
      log('Error while getting data is $e');
    } finally {
      isDataLoading(false);
    }
  }
}
