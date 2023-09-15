import 'package:flutter/material.dart';
import 'package:freo_task/app/constants/list_view_simmer.dart';
import 'package:freo_task/app/data/model/wiki_search_result_model.dart';
import 'package:freo_task/app/modules/web_view.dart';
import 'package:get/get.dart';
import '../controllers/result_view_controller.dart';

class ResultView extends GetView<ResultViewController> {
  const ResultView({required this.resultData,super.key});

  final Pages? resultData;

  @override
  Widget build(BuildContext context){
    return  Scaffold(
        appBar: AppBar(title: Text(resultData?.title??"N/A"),),
        body: GetBuilder<ResultViewController>(
          builder: (context)=>
          (controller.isLoading == true)?
          const ListViewSimmer(wrap: true,):
          (controller.clickData.query != null)?
          WebView(
              uri: controller.clickData.query?.pages?[0].fullurl??""):
          const SizedBox(),
        ));
  }
}