import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'storage_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> storage(Ref ref) {
  return SharedPreferences.getInstance();
}
