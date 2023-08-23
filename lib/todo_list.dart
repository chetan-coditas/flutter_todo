import 'package:flutter/material.dart';
import 'package:flutter_todo_app_assignement/Model/todo.dart';
import 'package:intl/intl.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});
  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  int taskCount = todos.length;
  final TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    todos[index].name,
                    style: todos[index].checked
                        ? const TextStyle(
                            decoration: TextDecoration.lineThrough)
                        : const TextStyle(decoration: TextDecoration.none),
                  ),
                  leading: Checkbox(
                      value: todos[index].checked,
                      onChanged: (bool? newBool) {
                        setState(() {
                          todos[index].checked = newBool!;
                          List<Todo> outputList =
                              todos.where((o) => o.checked == false).toList();
                          taskCount = outputList.length;
                        });
                      }),
                  trailing: todos[index].checked
                      ? null
                      : Text(
                          getTimeOnly(todos[index].dateTime),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                  onTap: () {},
                );
              },
              itemCount: todos.length),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 80,
              child: Row(
                children: [
                  const Divider(
                    color: Colors.black,
                    height: 10,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('${taskCount.toString()} TASKS'),
                  ),
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        _displayDialog(context);
                      },
                      child: const Text('ADD NEW +'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String getTimeString() {
    return DateFormat.Hm().format(DateTime.now());
  }

  String getTimeOnly(DateTime date) {
    return DateFormat.Hm().format(date);
  }

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    setState(() {
      final Todo newTodo =
          Todo(name: title, dateTime: DateTime.now(), checked: false);
      todos.add(newTodo);
    });
    _textFieldController.clear();
  }

  String errorText() {
    // at any time, we can get the text from _controller.value.text
    final text = _textFieldController.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text.length < 2) {
      return 'Too short';
    }
    // return null if the text is valid
    return '';
  }

  // Generate a single item widget
  // ignore: unused_element
  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: _textFieldController,
              // decoration: const InputDecoration(
              //   hintText: 'Enter task here',
              //   errorText: "Cant be empty",
              // ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ADD'),
                onPressed: () {
                  if (_textFieldController.text.isNotEmpty) {
                    Navigator.of(context).pop();
                    _addTodoItem(_textFieldController.text);
                    setState(() {
                      List<Todo> outputList =
                          todos.where((o) => o.checked == false).toList();
                      taskCount = outputList.length;
                    });
                  } else {
                    setState(() {});
                  }
                },
              ),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
