import '../models/task_model.dart';

class TodoController {
  List<TaskModel> tasks = [];

  // Add a new task to the list
  void addTask(TaskModel task) {
    tasks.add(task);
  }

  // Remove a task from the list
  void deleteTask(String taskId) {
    tasks.removeWhere((task) => task.id == taskId);
  }

  // Toggle task completion state
  void toggleTaskCompletion(String taskId) {
    var index = tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      tasks[index] = tasks[index].toggleCompletion();
    }
  }

  // Get tasks based on card type
  List<TaskModel> getTasksByCardType(String cardType) {
    return tasks.where((task) => task.cardType == cardType).toList();
  }
}
