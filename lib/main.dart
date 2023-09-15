import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/data/mapper.dart';
import 'app/routes/app_pages.dart';
import 'logger.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MapperFactory.initialize();
  Logger.setLogger(true);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
