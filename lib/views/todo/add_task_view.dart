import 'package:flutter/material.dart';
import '../../controller/todo_controller.dart';
import '../../models/task_model.dart';
import 'package:uuid/uuid.dart';

class AddTaskView extends StatefulWidget {
  final TodoController controller;

  AddTaskView({required this.controller});

  @override
  _AddTaskViewState createState() => _AddTaskViewState();
}

class _AddTaskViewState extends State<AddTaskView> {
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCardType = 'To-Do'; // Default card type

  void _saveTask() {
    final task = TaskModel(
      id: Uuid().v4(),
      description: _descriptionController.text,
      dueDate: _selectedDate,
      cardType: _selectedCardType, // Assign the selected card type
    );
    widget.controller.addTask(task); // Add task using the controller
    Navigator.pop(context); // Close the view after saving
  }

  void _pickDueDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Tugas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Deskripsi Tugas',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Jatuh Tempo: ${_selectedDate.toLocal()}'.split(' ')[0]),
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: _pickDueDate,
                ),
              ],
            ),
            SizedBox(height: 20),
            // Dropdown for selecting card type
            DropdownButton<String>(
              value: _selectedCardType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCardType = newValue!;
                });
              },
              items: <String>['To-Do', 'Meeting', 'Idea', 'Blank']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
