import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagStateController extends GetxController{
  var listTags = List<String>.empty(growable: true).obs;
}