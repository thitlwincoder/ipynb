import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_example/app/services/routers/app_routes.dart';

part 'router_config.g.dart';

@Riverpod(keepAlive: true)
GoRouter routerConfig(Ref ref) {
  return GoRouter(routes: $appRoutes, initialLocation: HomeRoute().location);
}
