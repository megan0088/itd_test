import 'package:flutter/material.dart';
import 'views/login/login_view.dart';
import 'views/todo/todo_list_view.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => LoginView(),
  '/todo': (context) => TodoListView(),
};
