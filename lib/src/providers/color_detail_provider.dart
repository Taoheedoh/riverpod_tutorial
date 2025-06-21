
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_tutorial/src/models/color_result.dart';
import 'package:riverpod_tutorial/src/services/api_services.dart';

part 'color_detail_provider.g.dart';

@Riverpod(keepAlive: true)
// ignore: deprecated_member_use_from_same_package, functional_ref
Future<ColorResult?> colorDetail(ColorDetailRef ref, String hexcode) async {
  return await ApiServices().retrieve(hexcode);
}
