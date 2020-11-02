import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt/Screens/addTode.dart';
import 'package:tt/state/HedState.dart';
import '../state/Todo.dart';

class SingleTodo extends StatefulWidget {
  @override
  _SingleTodoState createState() => _SingleTodoState();
}

class _SingleTodoState extends State<SingleTodo> {
  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<Todo>(context);
    final todos = Provider.of<HeadState>(context, listen: false);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AddTodo.routeName, arguments: todo.id);
              // print("Edit");
            },
            child: Text(
              "${todo.title}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                decoration: todo.complite ? TextDecoration.lineThrough : null,
              ),
            ),
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.delete, size: 30),
            color: Colors.red,
            onPressed: () {
              Scaffold.of(context).removeCurrentSnackBar();
              todos.deleteTodo(todo.id);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 2),
                  content: Text("TODO DELETED"),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(todo.complite
                ? Icons.check_box
                : Icons.check_box_outline_blank),
            color: Colors.blue,
            onPressed: () {
              todo.togleComplit();
            },
          )
        ],
      ),
    );
  }
}
