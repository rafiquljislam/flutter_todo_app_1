import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/HomePage.dart';
import 'Screens/addTode.dart';
import 'state/HedState.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => HeadState(),
      child: MaterialApp(
        home: HomePage(),
        routes: {
          AddTodo.routeName: (ctx) => AddTodo(),
          HomePage.routeName: (ctx) => HomePage(),
        },
      ),
    );
  }
}
