class TaskModel {
  final String id;
  final String description;
  final DateTime dueDate;
  final String cardType;
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.description,
    required this.dueDate,
    required this.cardType,
    this.isCompleted = false,
  });

  TaskModel toggleCompletion() {
    return TaskModel(
      id: id,
      description: description,
      dueDate: dueDate,
      cardType: cardType,
      isCompleted: !isCompleted,
    );
  }
}
