import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import '../redux/app_state.dart';
import '../redux/todo/todo_action.dart';
import '../model/todo.dart';

class ShowTodoPage extends StatefulWidget {
  final TodoContent todo;
  const ShowTodoPage({Key? key, required this.todo}) : super(key: key);

  @override
  _ShowTodoState createState() => _ShowTodoState();
}

class _ShowTodoState extends State<ShowTodoPage> {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.todo.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("タイトル: ${widget.todo.title}"),
            const Text("内容"),
            Text(widget.todo.content),
            Text("状態: ${widget.todo.getStateString()}"),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.todo.setNextState();
                });
                store.dispatch(UpdateTodoAction(todo: widget.todo));
                store.dispatch(RefreshSelectTodoAction());
                ScaffoldMessenger.of(context)
                    .showSnackBar(const SnackBar(content: Text("状態を更新しました")));
              },
              child: const Text("状態を更新"),
            ),
            ElevatedButton(
                onPressed: () {
                  store.dispatch(DeleteTodoAction(id: widget.todo.id));
                  store.dispatch(RefreshSelectTodoAction());
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("削除しました")));
                  Navigator.pop(context);
                },
                child: const Text("削除"))
          ],
        ),
      ),
    );
  }
}
