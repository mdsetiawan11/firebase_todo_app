import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todo_app/presentation/home/widgets/add_todo.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../services/todo_service.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final TodoService todoService = TodoService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showShadSheet(
            side: ShadSheetSide.bottom,
            context: context,
            builder: (context) => const AddTodo(side: ShadSheetSide.bottom),
          );
        },
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: todoService.getTodosStream(uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List todosList = snapshot.data!.docs;

            return ListView.builder(
                itemCount: todosList.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot document = todosList[index];
                  String docId = document.id;
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String todoText = data['todo'];
                  bool todoIsCompleted = data['isCompleted'];

                  return ListTile(
                    // text
                    title: Text(
                      todoText,
                      style: TextStyle(
                        decoration: todoIsCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),

                    // check box
                    leading: ShadCheckbox(
                      value: todoIsCompleted,
                      onChanged: (value) =>
                          todoService.toggleComplete(docId, todoIsCompleted),
                    ),

                    // delete button
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        todoService.delete(docId);
                        ShadToaster.of(context).show(
                          const ShadToast(
                            description: Text('Deleted!'),
                          ),
                        );
                      },
                    ),
                  );
                });
          } else {
            return const Center(
              child: Text('no data'),
            );
          }
        },
      ),
    );
  }
}
