import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt/state/HedState.dart';

class AddTodo extends StatefulWidget {
  static const routeName = '/add-todo';
  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  final _formKey = GlobalKey<FormState>();
  String _formData;
  var _initvalue = '';

  void _formSubmit() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    final id = ModalRoute.of(context).settings.arguments;
    if (id != null) {
      Provider.of<HeadState>(context, listen: false).update(id, _formData);
    } else {
      Provider.of<HeadState>(context, listen: false).addTodo(_formData);
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    if (id != null) {
      final todo = Provider.of<HeadState>(context, listen: false).findByID(id);
      _initvalue = todo.title;
    }
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: Text("ADD TODO"),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  initialValue: id != null ? _initvalue : "",
                  validator: (v) {
                    if (v.isEmpty) {
                      return "Enter Some Text";
                    }
                    return null;
                  },
                  onSaved: (v) {
                    _formData = v;
                  },
                  cursorColor: Colors.white,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: "ADD TODO",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Colors.red,
                        width: 2.0,
                      ),
                    ),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                MaterialButton(
                  padding: EdgeInsets.all(10),
                  color: Colors.redAccent,
                  onPressed: _formSubmit,
                  child: Text(
                    id != null ? "Update Todo" : "Add Todo",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
