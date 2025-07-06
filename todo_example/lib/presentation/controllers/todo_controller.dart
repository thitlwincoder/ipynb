import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_example/app/services/storages/storage_provider.dart';
import 'package:todo_example/data/models/todo_model.dart';
import 'package:uuid/uuid.dart';

part 'todo_controller.g.dart';

@Riverpod(keepAlive: true)
class TodoController extends _$TodoController {
  @override
  Future<List<TodoModel>> build() async {
    await Future.delayed(Duration(seconds: 1));
    var pref = await ref.watch(storageProvider.future);
    var items = pref.getStringList('todos') ?? [];
    return items.map((e) => TodoModel.fromJson(jsonDecode(e))).toList();
  }

  Future<void> add({required String title, required String desc}) async {
    await update((state) async {
      state.add(
        TodoModel(
          desc: desc,
          title: title,
          id: Uuid().v4(),
          createdAt: DateTime.now(),
        ),
      );

      await writeData(state);

      return state;
    });
  }

  Future<void> put({
    required String id,
    required String title,
    required String desc,
  }) async {
    await update((state) async {
      var i = state.indexWhere((e) => e.id == id);
      state[i] = state[i].copyWith(
        title: title,
        desc: desc,
        updatedAt: DateTime.now(),
      );
      await writeData(state);

      return state;
    });
  }

  Future<void> delete(String id) async {
    await update((state) async {
      state.removeWhere((e) => e.id == id);

      await writeData(state);

      return state;
    });
  }

  Future<void> writeData(List<TodoModel> items) async {
    var pref = await ref.read(storageProvider.future);
    await pref.setStringList(
      'todos',
      items.map((e) => jsonEncode(e.toJson())).toList(),
    );
  }
}
