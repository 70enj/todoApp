import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todoapp/redux/app_state.dart';
import '../redux/todo/todo_action.dart';

class NewTodoPage extends StatelessWidget {
  const NewTodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final _titleController = TextEditingController();
    final _contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("新規登録"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin:
                  const EdgeInsets.only(top: 0, right: 30, bottom: 0, left: 30),
              child: TextField(
                obscureText: false,
                maxLines: 1,
                controller: _titleController,
                decoration:
                    const InputDecoration(labelText: "タイトル", hintText: "買い物"),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 0, right: 30, bottom: 0, left: 30),
              child: TextField(
                obscureText: false,
                maxLines: 8,
                controller: _contentController,
                decoration:
                    const InputDecoration(labelText: "内容", hintText: "りんごを買う"),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_titleController.text.isNotEmpty &&
                      _contentController.text.isNotEmpty) {
                    //DBに登録してtodoState.newIdを取得
                    store.dispatch(NewTodoAction(
                        title: _titleController.text,
                        content: _contentController.text));
                    //todosに反映
                    store.dispatch(AddTodoAction(
                        id: store.state.todoState.newId,
                        title: _titleController.text,
                        content: _contentController.text));
                    store.dispatch(RefreshSelectTodoAction());
                    Navigator.pop(context);
                  }
                },
                child: const Text("登録"))
          ],
        ),
      ),
    );
  }
}
