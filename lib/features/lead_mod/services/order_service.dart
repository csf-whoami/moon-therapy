import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:moon/config/config.dart';
import 'package:moon/features/lead_mod/models/models.dart';

class OrderService {
  final AppHttp _http = AppHttp(
    baseUrl: ApiEndpoint.events,
    headers: {'token': Config.token},
  );

  Future<List<TherapyOrderRequest>?> getAll() async {
    Response res = await _http.get(ApiEndpoint.events);
    if (res.statusCode == 200) {
      print("response data: " + res.toString());
      List<TherapyOrderRequest> enquery =
          json.decode(res.data).map((data) => TherapyOrderRequest.fromJson(data)).toList();
      return enquery;
    }
    return null;
  }
}
