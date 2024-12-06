import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:practice_4/presentation/task_flow/create_modify_page/create_modify_screen.dart';
import 'package:practice_4/presentation/task_flow/task_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key,});

  final TaskModel taskModel = TaskModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заметки'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Observer(
              builder: (_) => ListView.builder(
                itemCount: taskModel.tasks.length,
                itemBuilder: (_, index) {
                  final task = taskModel.tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_circle_right_outlined),
                      onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CreateModifyScreen(taskModel: taskModel, index: index)
                        )
                      ),
                    ),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CreateModifyScreen(taskModel: taskModel, index: index)
                      )
                    ),
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CreateModifyScreen(taskModel: taskModel, index: taskModel.tasks.length)
                )
              ),
              // onPressed: () => Navigator.of(context).pushNamed('/counter'),
              child: const Text('Создать заметку', style: TextStyle(fontSize: 20.0))
            )
          ),
          const SizedBox(
            height: 50
          ),
        ],
      ),
    );
  }
}