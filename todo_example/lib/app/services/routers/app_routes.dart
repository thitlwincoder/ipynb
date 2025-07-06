import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_example/presentation/screens/home/home_screen.dart';
import 'package:todo_example/presentation/screens/search/search_screen.dart';

part 'app_routes.g.dart';

@TypedGoRoute<HomeRoute>(
  path: '/',
  routes: [TypedGoRoute<SearchRoute>(path: 'search')],
)
class HomeRoute extends GoRouteData with _$HomeRoute {
  const HomeRoute();

  @override
  Widget build(_, _) => HomeScreen();
}

class SearchRoute extends GoRouteData with _$SearchRoute {
  const SearchRoute();

  @override
  Widget build(_, _) => SearchScreen();
}
