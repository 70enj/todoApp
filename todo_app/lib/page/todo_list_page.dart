import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:todoapp/model/todo.dart';
import '../redux/app_state.dart';
import './show_todo_page.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StoreConnector<AppState, List<TodoContent>>(
            converter: (store) => store.state.todoState.selectTodos,
            builder: (context, todos) {
              return Expanded(
                child: ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ShowTodoPage(
                                      todo: todos[index],
                                    )));
                      },
                      child: ListTile(
                        title: Text(
                            "${todos[index].title}(${todos[index].getStateString()})"),
                        subtitle: Text(todos[index].content),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
