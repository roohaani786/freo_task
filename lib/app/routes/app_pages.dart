import 'package:freo_task/app/data/model/wiki_page_click_model.dart';
import 'package:freo_task/app/data/model/wiki_search_result_model.dart';
import 'package:freo_task/app/modules/home/views/result_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  static const RESULTVIEW = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RESULTVIEW,
      page: () => ResultView(resultData: Get.arguments as Pages,),
      binding: HomeBinding(),
    ),
  ];
}
