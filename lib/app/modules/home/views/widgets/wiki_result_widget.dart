import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/color_constnts.dart';
import '../../../../constants/text_styles.dart';
import '../../../../constants/ui_helpers.dart';
import '../../../../data/model/wiki_search_result_model.dart';
import '../../../../routes/app_pages.dart';
import '../../controllers/home_controller.dart';

class WikiResultWidget extends StatelessWidget{
   WikiResultWidget({this.resultData,super.key});

  final Pages? resultData;
  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {

    return (resultData!=null)?Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: ColorConstants.white,
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 2),
                color: ColorConstants.black.withOpacity(.08),
                blurRadius: 8
            )]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              decoration: const BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0)),
              ),
              padding: const EdgeInsets.only(left: 16.0,right: 16.0,top: 10.0,bottom: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(onPressed: ()  {
                    Get.toNamed(Routes.RESULTVIEW,arguments: resultData);
                    // await homeController.getWikiDetailById(resultData?.pageid??0);
                    }, child: Text("ok")),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(resultData?.title??"N/A",
                          style: textStyles.mdTextRegularStyle.copyWith(
                            color: ColorConstants.white,
                          ),),
                      ),
                      // horizontalSpace_46,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          horizontalSpace_8,
                          // Text(resultData?.description??"N/A" , style: textStyles.h7TextStyle.copyWith(
                          //   color: ColorConstants.white,
                          // ),)
                        ],
                      )
                    ],
                  ),

                  Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2.0,),
                        child:
                        Text(resultData?.terms?.description?[0]??"N/A" ,style: textStyles.h7TextStyle.copyWith(
                          color: ColorConstants.white,
                        ),
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                          softWrap: true,
                          ),
                      )),
                ],
              )),
          Padding(
            padding: const EdgeInsets.only(left: 16.0,right:  16.0, bottom: 16.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(resultData?.description??"N/A",style: textStyles.xxsTextRegularStyle.copyWith(
                      color: ColorConstants.greyScaleOTPField,
                    ),),
                    verticalSpace_8,
                  ],
                ),
                verticalSpace_8,
                (resultData?.thumbnail?.source !=null || resultData?.thumbnail?.source == "")?
                SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: CachedNetworkImage(
                          imageUrl: resultData!.thumbnail!.source.toString(),
                          fit: BoxFit.cover,)),
                ):const SizedBox(),

              ],
            ),
          ),


       // Padding(
       //        padding: const EdgeInsets.only(left: 16.0, right: 16.0),
       //        child: PrimaryElevatedBtn("Download", () {
       //          // medicalRecordsController.downloadFile("https://mhedev.s3.amazonaws.com/files/appointment/80cbf76a-7118-41c1-b963-32228f1592dd/documents/80cbf76a-7118-41c1-b963-32228f1592dd.jpg","test1.jpg");
       //        },
       //          padding: EdgeInsets.zero,
       //          buttonWidth: Get.width,)
       //    ),
          verticalSpace_12,
        ],
      ),
    ):
    const SizedBox();
  }

}