import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moon/features/lead_mod/models/models.dart';

import '../../../config/api_endpoints.dart';

class OrderProvider extends ChangeNotifier {
  final Dio _dioClient = Dio();
  bool isLoading = false;

  List<OrderDataResponse> _orders = [];

  void getAll({bool input = true}) async {
    if (isLoading == true) {
      isLoading = false;
    }

    Response res = await _dioClient.get(ApiEndpoint.events);
    if (res.statusCode == 200) {
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
}
