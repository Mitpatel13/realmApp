import 'package:flutter/material.dart';
import 'package:flutter_todo/realm/app_services.dart';
import 'package:flutter_todo/realm/realm_services.dart';
import 'package:get/get.dart';
import 'package:realm/realm.dart';

import '../realm/schemas.dart';

class DashboardController extends GetxController {
  final RxString selectedClass = 'Class A'.obs;
  final RxString selectedDivision = 'Division I'.obs;

  final List<String> classes = ['Class A', 'Class B', 'Class C'];
  final List<String> divisions = ['Division I', 'Division II', 'Division III'];
  final formKey2 = GlobalKey<FormState>();
  RealmResults? items;
  final TextEditingController itemEditingController = TextEditingController();

}
