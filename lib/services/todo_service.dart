import 'package:cloud_firestore/cloud_firestore.dart';

class TodoService {
  //get collection
  final CollectionReference todos =
      FirebaseFirestore.instance.collection('todos');

  //create
  Future<void> addTodo(String todo, String uid) {
    return todos.add({
      'todo': todo,
      'uid': uid,
      'isCompleted': false,
      'createdAt': Timestamp.now(),
    });
  }

  //read
  Stream<QuerySnapshot> getTodosStream(String uid) {
    final todosStream = todos.where('uid', isEqualTo: uid).snapshots();
    return todosStream;
  }

  //update isCompleted
  Future<void> toggleComplete(String docId, bool isCompleted) {
    return todos.doc(docId).update({'isCompleted': !isCompleted});
  }

  //delete
  Future<void> delete(String docId) {
    return todos.doc(docId).delete();
  }
}
