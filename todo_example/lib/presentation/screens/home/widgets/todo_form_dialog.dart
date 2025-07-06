import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo_example/data/models/todo_model.dart';
import 'package:todo_example/presentation/controllers/todo_controller.dart';

class TodoFormDialog extends ConsumerStatefulWidget {
  const TodoFormDialog({super.key, this.data});

  final TodoModel? data;

  @override
  ConsumerState<TodoFormDialog> createState() => _TodoFormDialogState();
}

class _TodoFormDialogState extends ConsumerState<TodoFormDialog> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController title;
  late TextEditingController desc;

  @override
  void initState() {
    super.initState();

    title = TextEditingController(text: widget.data?.title);
    desc = TextEditingController(text: widget.data?.desc);
  }

  @override
  void dispose() {
    title.dispose();
    desc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.data != null ? 'Edit' : 'Add'} Todo'),
      actions: [
        ElevatedButton(onPressed: context.pop, child: Text('Cancel')),
        FilledButton(onPressed: onSubmitTap, child: Text('Submit')),
      ],
      content: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: title,
              validator: (v) => v!.isEmpty ? 'required' : null,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              maxLines: 5,
              controller: desc,
              validator: (v) => v!.isEmpty ? 'required' : null,
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSubmitTap() {
    if (!formKey.currentState!.validate()) return;

    if (widget.data != null) {
      ref
          .read(todoControllerProvider.notifier)
          .put(
            id: widget.data!.id,
            desc: desc.text.trim(),
            title: title.text.trim(),
          );
    } else {
      ref
          .read(todoControllerProvider.notifier)
          .add(title: title.text.trim(), desc: desc.text.trim());
    }

    context.pop();
  }
}
