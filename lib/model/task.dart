class Task {
  final String id;
  final String title;
  final String ?description;
  final DateTime dateTime;
  final DateTime dueDate;
  final String categoryId;
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.dueDate,
    required this.categoryId,
    this.isCompleted = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title']?? '',
      description: json['description']?? '',
      dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
      dueDate: DateTime.fromMillisecondsSinceEpoch(json['dueDate']),
      categoryId: json['categoryId'],
      isCompleted: json['isCompleted']?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'categoryId': categoryId,
      'isCompleted': isCompleted,
    };
  }
}
  