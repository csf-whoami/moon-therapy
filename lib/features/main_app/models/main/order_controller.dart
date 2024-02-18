import 'package:get/get.dart';
import 'package:moon/features/main_app/models/main/db_helper.dart';
import 'package:moon/features/main_app/models/main/order_model.dart';

class CreateOrderController extends GetxController {
  @override
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({OrderResponseModel? task}) async {
    return await DBHelper.insert(task);
  }
}
