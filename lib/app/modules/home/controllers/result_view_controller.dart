import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freo_task/app/api/wikipedia_api.dart';
import 'package:freo_task/app/data/api_response.dart';
import 'package:freo_task/app/data/model/wiki_page_click_model.dart';
import 'package:get/get.dart';

import '../../../data/model/wiki_search_result_model.dart';

class ResultViewController extends GetxController {

  final GlobalKey webViewKey = GlobalKey();
  final WikiRepository wikiRepository = WikiRepository();
  WikiPageClickModel clickData = WikiPageClickModel();
  final urlController = TextEditingController();
  bool isLoading = false;

  @override
  void onInit() {
    final Pages? resultData = Get.arguments;
    getWikiDetailById(resultData?.pageid??0);
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getWikiDetailById(int pageId) async {
    isLoading = true;
    update();
    ApiResponse apiResponse = await  wikiRepository.getWikiDetailById(pageId: pageId);
    clickData = apiResponse.responseData;
    isLoading = false;
    update();
  }

}
