// import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
import 'package:moon/features/lead_mod/models/models.dart';

import '../../../config/api_endpoints.dart';

class OrderProvider extends ChangeNotifier {
  final Dio _dioClient = Dio();
  bool isLoading = false;

  // var taskList = <OrderDataResponse>[].obs;

  List<OrderDataResponse> _orders = [];

  void getAll({bool input = true}) async {
    if (isLoading == true) {
      isLoading = false;
    }

    Response res = await _dioClient.get(ApiEndpoint.events);
    if (res.statusCode == 200) {
      print("Response data: " + res.data);
      List<dynamic> movieMapList = res.data;
      _orders =
          movieMapList.map((data) => OrderDataResponse.fromMap(data)).toList();
      isLoading = true;
      input = false;
      notifyListeners();
    }
  }

  List<OrderDataResponse>? get orders {
    if (_orders != null && isLoading == true) {
      return _orders!;
    }
    return null;
  }

  //
  // void fetchOrderData() async {
  //   Future.microtask(() async {
  //     OrderService es = OrderService();
  //     List<OrderDataResponse>? data = await es.getAll();
  //     print("Total data: " + data!.length.toString());
  //     _orders = data!;
  //     isLoaded = true;
  //     notifyListeners();
  //   });
  // }
}
