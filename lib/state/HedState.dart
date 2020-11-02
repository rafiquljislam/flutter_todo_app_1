import 'package:flutter/cupertino.dart';
import 'package:tt/state/Todo.dart';
import './dbHelper.dart';

class HeadState with ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;

  List<Todo> _todos = [];

  List<Todo> get todo {
    return [..._todos];
  }

  Future<void> getTodo() async {
    var allrows = await dbHelper.quaryallrows();
    List<Todo> dddddd = allrows
        .map(
          (e) => Todo(
            id: e['id'].toString(),
            title: e['title'].toString(),
            complite: e['complite'] == 'true' ? true : false,
          ),
        )
        .toList();
    _todos = dddddd;
    notifyListeners();
  }

  Future<void> addTodo(String todo) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: todo,
      DatabaseHelper.columnComplit: false.toString(),
    };
    final id = await dbHelper.insert(row);
    print(id);
    Todo ttt = Todo(
      id: id.toString(),
      title: todo,
    );
    _todos.insert(0, ttt);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    _todos.removeWhere((element) => element.id == id);
    var row = await dbHelper.deleteData(int.parse(id));
    print(row);
    notifyListeners();
  }

  Todo findByID(String id) {
    return _todos.firstWhere((element) => element.id == id);
  }

  Future<void> update(String id, String title) async {
    var index = _todos.indexWhere((element) => element.id == id);
    Todo todo = Todo(
      id: id,
      title: title,
      complite: _todos[index].complite,
    );
    _todos[index] = todo;

    Map<String, dynamic> rows = {
      DatabaseHelper.columnName: title,
      DatabaseHelper.columnComplit: _todos[index].complite.toString(),
    };
    var row = await dbHelper.updateData(int.parse(id), rows);
    print(row);

    notifyListeners();
  }
}
