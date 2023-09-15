import 'package:freo_task/app/modules/home/controllers/result_view_controller.dart';
import 'package:get/get.dart';

import '../../../networking/api_service.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ResultViewController>(
          () => ResultViewController(),
    );
    Get.put<ApiService>(ApiService.getInstance(), permanent: true);
  }
}
