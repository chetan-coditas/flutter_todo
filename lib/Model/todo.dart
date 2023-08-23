class Todo {
  Todo({
    required this.name,
    required this.dateTime,
    required this.checked,
  });

  final String name;
  final DateTime dateTime;
  bool checked;
}

final List<Todo> todos = [
  Todo(
    name: 'Morning run',
    dateTime: DateTime.now(),
    checked: false,
  ),
  Todo(
    name: 'Meeting',
    dateTime: DateTime.now(),
    checked: false,
  ),
];
