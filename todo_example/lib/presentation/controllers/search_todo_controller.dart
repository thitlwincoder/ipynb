import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_example/data/models/todo_model.dart';
import 'package:todo_example/presentation/controllers/todo_controller.dart';

part 'search_todo_controller.g.dart';

@riverpod
class SearchTodoController extends _$SearchTodoController {
  @override
  List<TodoModel> build() {
    return [];
  }

  void search(String query) {
    var items = ref.read(todoControllerProvider).valueOrNull ?? [];
    state =
        items
            .where((e) => e.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
  }
}
