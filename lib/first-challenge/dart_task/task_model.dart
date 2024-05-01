class Task {
  final String description;
  final String title;
  bool isCompleted = false;
  Task(
      {required this.description,
      required this.title,
      required this.isCompleted});

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      description: json['description'],
      title: json['title'],
      isCompleted: json['isCompleted'] as bool);

  Map<String, dynamic> toJson() =>
      {'description': description, 'title': title, 'isCompleted': isCompleted};
}
