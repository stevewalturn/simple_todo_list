import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_todo_list/models/todo.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'todos';

  Stream<List<Todo>> getTodosStream() {
    try {
      return _firestore
          .collection(_collection)
          .orderBy('createdAt', descending: true)
          .snapshots()
          .map((snapshot) {
        return snapshot.docs
            .map((doc) => Todo.fromMap({...doc.data(), 'id': doc.id}))
            .toList();
      });
    } catch (e) {
      throw Exception('Failed to get todos: ${e.toString()}');
    }
  }

  Future<void> addTodo(Todo todo) async {
    try {
      final todoMap = todo.toMap();
      await _firestore.collection(_collection).doc(todo.id).set(todoMap);
    } catch (e) {
      throw Exception('Failed to add todo: ${e.toString()}');
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      final todoMap = todo.toMap();
      await _firestore
          .collection(_collection)
          .doc(todo.id)
          .update(todoMap);
    } catch (e) {
      throw Exception('Failed to update todo: ${e.toString()}');
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete todo: ${e.toString()}');
    }
  }
}