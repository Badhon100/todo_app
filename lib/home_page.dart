import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/data/todo.dart';
import 'package:todo_app/todo_bloc/todo_bloc.dart';
import 'package:todo_app/widget/custom_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  addTodo(Todo todo) {
    context.read<TodoBloc>().add(AddTodo(todo));
  }

  removeTodo(Todo todo) {
    context.read<TodoBloc>().add(RemoveTodo(todo));
  }

  alterTodo(int index) {
    context.read<TodoBloc>().add(AlterTodo(index));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Center(child: Text("Add a task")),
                  content: CustomDialog(titleController: titleController, descriptionController: descriptionController),
                  actions: [
                    TextButton(
                      onPressed: () {
                        addTodo(Todo(
                            title: titleController.text,
                            subtitle: descriptionController.text));
                            titleController.text = '';
                            descriptionController.text = '';
                            Navigator.pop(context);
                     },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: Theme.of(context).colorScheme.secondary),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor:
                              Theme.of(context).colorScheme.secondary),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                          child: Text(
                            "save",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              });
        },
        child: const Icon(
          CupertinoIcons.add,
          color: Colors.black,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        elevation: 0,
        title: Text(
          "Todo",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.status == TodoStatus.success) {
            return Container();
          } else if (state.status == TodoStatus.initial) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

