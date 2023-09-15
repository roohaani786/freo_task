import 'package:flutter/material.dart';
import 'package:freo_task/app/constants/list_view_simmer.dart';
import 'package:freo_task/app/widgets/app_text_field.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'widgets/wiki_result_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                controller.query.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              AppTextField(
                  controller: controller.queryController,
                  hintText: "Search for a personality"),
              TextButton(onPressed: () async {
                await controller.getWikiSearchResults(controller.queryController.text);
              }, child:  const Text("Search")),

              GetBuilder<HomeController>(
                  builder: (context)=>
                  Container(
                    child: (controller.isLoading)?
                    const ListViewSimmer(wrap: true,):
                    (controller.wikiSearchResult?.query?.pages != null)?
                    ListView.builder(
                      itemCount: controller.wikiSearchResult?.query?.pages?.length,
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>
                           WikiResultWidget(resultData: controller.wikiSearchResult?.query?.pages?[index],),
                    ):const SizedBox(),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
