import 'package:flutter/cupertino.dart';
import './dbHelper.dart';

class Todo with ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;

  final String id;
  final String title;
  bool complite;

  Todo({
    @required this.id,
    @required this.title,
    this.complite = false,
  });

  Future<void> togleComplit() async {
    complite = !complite;
    Map<String, dynamic> row = {
      DatabaseHelper.columnName: title,
      DatabaseHelper.columnComplit: complite.toString(),
    };
    var rows = await dbHelper.updateData(int.parse(id), row);
    print(rows);
    notifyListeners();
  }
}
