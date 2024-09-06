import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/services/todo_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:shadcn_ui/shadcn_ui.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key, required this.side});
  final ShadSheetSide side;

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final formKey = GlobalKey<ShadFormState>();
  bool isLoading = false;
  final TodoService todoService = TodoService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ShadForm(
      key: formKey,
      child: ShadSheet(
          constraints: widget.side == ShadSheetSide.left ||
                  widget.side == ShadSheetSide.right
              ? const BoxConstraints(maxWidth: 512)
              : null,
          title: const Text('Add Todo'),
          actions: [
            ShadButton(
              enabled: isLoading ? false : true,
              icon: isLoading == true
                  ? const SizedBox.square(
                      dimension: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : null,
              onPressed: () {
                if (formKey.currentState!.saveAndValidate()) {
                  setState(() => isLoading = true);
                  final User? user = auth.currentUser;
                  final uid = user!.uid;
                  todoService.addTodo(formKey.currentState!.value['todo'], uid);
                  setState(() => isLoading = false);
                  context.pop();
                } else {}
              },
              child: Text(isLoading == true ? 'Please Wait' : 'Save'),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 320),
              child: ShadInputFormField(
                id: 'todo',
                placeholder: const Text('Todo'),
                keyboardType: TextInputType.text,
                validator: (v) {
                  if (v.isEmpty) {
                    return 'Todo cannot be empty';
                  }
                  return null;
                },
              ),
            ),
          )),
    );
  }
}
