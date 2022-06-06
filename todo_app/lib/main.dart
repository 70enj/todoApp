import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todoapp/redux/todo/todo_action.dart';
import './page/todo_page.dart';
import './redux/store.dart';
import './redux/app_state.dart';

void main() async {
  final Store<AppState> store = await createStore();
  store.dispatch(InitTodoAction());
  runApp(MyApp(store: store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  const MyApp({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: TodoPage(
          title: 'Todo App',
        ),
      ),
    );
  }
}
