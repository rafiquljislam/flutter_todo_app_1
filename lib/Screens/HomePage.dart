import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tt/Screens/addTode.dart';
import 'package:tt/state/HedState.dart';
import 'package:tt/widgets/SingleTodo.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Provider.of<HeadState>(context, listen: false).getTodo();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<HeadState>(context).todo;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.blue,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(AddTodo.routeName);
        },
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14),
                    child: Icon(
                      Icons.today_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "Todo App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${todo.length}",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Colors.white,
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView.builder(
                itemCount: todo.length,
                itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: todo[i],
                  child: SingleTodo(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
