import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/src/models/color_result.dart';
import 'package:riverpod_tutorial/src/services/api_services.dart';

final colorDetailProvider = FutureProvider<ColorResult?>((ref) async {
  return await ApiServices().retrieve("#000000");
});
