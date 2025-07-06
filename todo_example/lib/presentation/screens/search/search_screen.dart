import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:todo_example/presentation/controllers/search_todo_controller.dart';
import 'package:todo_example/presentation/screens/home/widgets/todo_item.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var items = ref.watch(searchTodoControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (query) {
            ref.read(searchTodoControllerProvider.notifier).search(query);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Search ...',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) {
          var data = items[index];
          return ListTile(title: Text(data.title), subtitle: Text(data.desc));
        },
      ),
    );
  }
}
