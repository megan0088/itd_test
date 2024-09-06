import 'package:flutter/material.dart';
import '../../controller/todo_controller.dart';
import 'add_task_view.dart';

class TodoListView extends StatefulWidget {
  @override
  _TodoListViewState createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {
  final _todoController = TodoController();
  String _sortOption = 'To-Do'; // Default sorting option

  void _navigateToAddTask() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTaskView(controller: _todoController)),
    ).then((_) {
      setState(() {});
    });
  }

  // Helper method to filter tasks by card type
  List<Widget> _buildTaskSection(String cardType) {
    var tasks = _todoController.getTasksByCardType(cardType);

    if (tasks.isEmpty) {
      return [
        Center(child: Text('No tasks in $cardType section')),
      ];
    }

    return tasks.map((task) {
      return Card(
        child: ListTile(
          leading: Checkbox(
            value: task.isCompleted,
            onChanged: (bool? value) {
              setState(() {
                _todoController.toggleTaskCompletion(task.id);
              });
            },
          ),
          // Title with strikethrough if task is completed
          title: Text(
            task.description,
            style: TextStyle(
              decoration: task.isCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
          subtitle: Text('Due Date: ${task.dueDate.toLocal()}'.split(' ')[0]),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _todoController.deleteTask(task.id);
              });
            },
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 600;

        return Scaffold(
          appBar: AppBar(
            title: Text('To-Do List'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen ? 150 : 16.0,
            ),
            child: Column(
              children: [
                // Sorting Cards
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSortCard(Icons.check_box, 'To-Do'),
                    _buildSortCard(Icons.event, 'Meeting'),
                    _buildSortCard(Icons.lightbulb, 'Idea'),
                    _buildSortCard(Icons.blur_on, 'Blank'),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: ListView(
                    children: [
                      _buildTaskSectionWithTitle('To-Do', Icons.check_box),
                      SizedBox(height: 20),
                      _buildTaskSectionWithTitle('Meeting', Icons.event),
                      SizedBox(height: 20),
                      _buildTaskSectionWithTitle('Idea', Icons.lightbulb),
                      SizedBox(height: 20),
                      _buildTaskSectionWithTitle('Blank', Icons.blur_on),
                    ],
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _navigateToAddTask,
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildSortCard(IconData icon, String option) {
    return Column(
      children: [
        Card(
          color: _sortOption == option ? Colors.pink : Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(
              icon,
              color: _sortOption == option ? Colors.white : Colors.pink,
              size: 30,
            ),
          ),
          margin: EdgeInsets.all(8.0),
        ),
        SizedBox(height: 8),
        Text(
          option,
          style: TextStyle(
            color: _sortOption == option ? Colors.pink : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Helper method to build task section with title
  Widget _buildTaskSectionWithTitle(String title, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.pink),
            SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Column(
          children:
              _buildTaskSection(title), // Build task section based on title
        ),
      ],
    );
  }
}
