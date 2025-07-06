import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:todo_example/app/services/routers/app_routes.dart';
import 'package:todo_example/data/models/todo_model.dart';
import 'package:todo_example/presentation/controllers/todo_controller.dart';
import 'package:todo_example/presentation/screens/home/widgets/todo_form_dialog.dart';
import 'package:todo_example/presentation/screens/home/widgets/todo_item.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(todoControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Todos'),
        actions: [
          IconButton(
            onPressed: () => SearchRoute().go(context),
            icon: Icon(Icons.search),
          ),
        ],
      ),
      body: state.when(
        error: (error, stackTrace) => Center(child: Text('$error')),
        loading: () => Center(child: CircularProgressIndicator()),
        data: (items) {
          if (items.isEmpty) return Center(child: Text('NO DATA'));

          return ListView.builder(
            itemCount: items.length,
            padding: EdgeInsets.all(20),
            itemBuilder: (context, index) {
              var data = items[index];
              return TodoItem(
                data: data,
                onTap: () => showTodoFormDialog(data: data),
                onDeleteTap: () => onDeleteTap(data),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: showTodoFormDialog,
        child: Icon(Icons.add),
      ),
    );
  }

  void showTodoFormDialog({TodoModel? data}) {
    showDialog(
      context: context,
      builder: (context) => TodoFormDialog(data: data),
    );
  }

  void onDeleteTap(TodoModel data) {
    ref.read(todoControllerProvider.notifier).delete(data.id);
  }
}
