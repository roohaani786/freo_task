import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/material.dart';
import 'package:freo_task/app/constants/list_view_simmer.dart';
import 'package:freo_task/app/constants/text_styles.dart';
import 'package:freo_task/app/constants/ui_helpers.dart';
import 'package:freo_task/app/widgets/app_text_field.dart';

import 'package:get/get.dart';

import '../../../constants/color_constants.dart';
import '../controllers/home_controller.dart';
import 'widgets/wiki_result_widget.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wiki Search View',
          textScaleFactor: 1.0,
        ),
        centerTitle: true,
        backgroundColor: ColorConstants.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // AppTextField(
              //
              //     actionKeyboard: TextInputAction.done,
              //     controller: controller.queryController,
              //     isOutlineBorder: true,
              //     prefixIcon: const Icon(Icons.book_outlined,color: ColorConstants.black,),
              //     suffixIcon: const Icon(Icons.search_sharp,color: ColorConstants.secondaryColor,),
              //     hintText: "Search for a personality"),
              // verticalSpace_6,
              // Text("You can also search for multiple personalities by separating each one by | , for ex: Salman Khan | Aamir Khan",
              // textScaleFactor: 1.0,
              // style: textStyles.smTextRegularStyle.copyWith(
              //   color: ColorConstants.greyScaleOTPField,
              // ),),
              // verticalSpace_16,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Material(
              //       color: Colors.transparent,
              //       borderRadius: BorderRadius.circular(20.0),
              //       child: InkWell(
              //         borderRadius: BorderRadius.circular(20.0),
              //       onTap: () async {
              //       await controller.getWikiSearchResults(controller.queryController.text);
              //       },
              //           child: Container(
              //           padding: EdgeInsets.zero,
              //           decoration: BoxDecoration(color: ColorConstants.primaryColor,
              //           borderRadius: BorderRadius.circular(20.0)),
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
              //             child: Text("Get Results",
              //               textScaleFactor: 1.0,style: textStyles.mdTextBoldStyle.copyWith(
              //               color: ColorConstants.white
              //             ),),
              //           ))
              //       ),
              //     ),
              //   ],
              // ),
              // verticalSpace_16,

              GetBuilder<HomeController>(
                  builder: (context) => Container(
                        child: (controller.isLoading)
                            ? const ListViewSimmer(
                                wrap: true,
                              )
                            : (controller.wikiSearchResult?.query?.pages !=
                                    null)
                                ? ListView.builder(
                                    itemCount: controller
                                        .wikiSearchResult?.query?.pages?.length,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) =>
                                        WikiResultWidget(
                                      resultData: controller.wikiSearchResult
                                          ?.query?.pages?[index],
                                    ),
                                  )
                                : const SizedBox(),
                      ))
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      bottomSheet: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
          ),
          color: Colors.grey[50],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "You can also search for multiple personalities by separating each one by | , for ex: Salman Khan | Aamir Khan",
                textScaleFactor: 1.0,
                style: textStyles.smTextRegularStyle.copyWith(
                  color: ColorConstants.greyScaleOTPField,
                ),
              ),

              verticalSpace_10,

              AppTextField(
                actionKeyboard: TextInputAction.search,
                onSubmitField: () async {
                  await controller.getWikiSearchResults(
                      controller.queryController.text);
                },
                controller: controller.queryController,
                isOutlineBorder: true,
                prefixIcon: const Icon(
                  Icons.book_outlined,
                  color: ColorConstants.primaryColor,
                ),
                suffixIcon: InkWell(
                    onTap: () async {
                      await controller.getWikiSearchResults(
                          controller.queryController.text);
                    },
                    child: const Icon(
                      Icons.search_sharp,
                      color: ColorConstants.secondaryColor,
                    )
                ),
                hintText: "Search for a personality",
              ),

              // verticalSpace_16,
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     Material(
              //       color: Colors.transparent,
              //       borderRadius: BorderRadius.circular(20.0),
              //       child: InkWell(
              //           borderRadius: BorderRadius.circular(20.0),
              //           onTap: () async {
              //             await controller.getWikiSearchResults(controller.queryController.text);
              //           },
              //           child: Container(
              //               padding: EdgeInsets.zero,
              //               decoration: BoxDecoration(color: ColorConstants.primaryColor,
              //                   borderRadius: BorderRadius.circular(20.0)),
              //               child: Padding(
              //                 padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 16.0),
              //                 child: Text("Get Results",
              //                   textScaleFactor: 1.0,style: textStyles.mdTextBoldStyle.copyWith(
              //                       color: ColorConstants.white
              //                   ),),
              //               ))
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
