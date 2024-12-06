import 'package:flutter/material.dart';
import 'package:practice_4/presentation/task_flow/task_model.dart';

class CreateModifyScreen extends StatefulWidget {
  final TaskModel taskModel;
  final int index;

  const CreateModifyScreen({
    super.key,
    required this.taskModel,
    required this.index
  });

  @override
  _CreateModifyScreen createState() => _CreateModifyScreen();
}

class _CreateModifyScreen extends State<CreateModifyScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    if (widget.index < widget.taskModel.tasks.length) {
      _titleController = TextEditingController(
        text: widget.taskModel.tasks[widget.index].title);
      _descriptionController = TextEditingController(
        text: widget.taskModel.tasks[widget.index].description);
    } else {
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addTask() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (title.isNotEmpty) {
      widget.taskModel.addTask(Task(title, description));
      _titleController.clear();
      _descriptionController.clear();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
          Text('Введите название заметки'),
          duration: Duration(milliseconds: 1500)
        ),
      );
    }
  }

  void _modifyTask() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    if (title.isNotEmpty) {
      widget.taskModel.modifyTask(Task(title, description), widget.index);
      _titleController.clear();
      _descriptionController.clear();
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
          Text('Введите название заметки'),
          duration: Duration(milliseconds: 1500)
        ),
      );
    }
  }

  void _saveTask() {
    if (widget.index < widget.taskModel.tasks.length) {
      _modifyTask();
    } else {
      _addTask();
    }
  }

  void _removeTask() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
          Text('Заметка ${widget.taskModel.tasks[widget.index].title} удалена'),
        duration: const Duration(milliseconds: 1500)
      ),
    );
    widget.taskModel.removeTask(widget.index);
    Navigator.pop(context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.index < widget.taskModel.tasks.length
          ? 'Заметка ${widget.taskModel.tasks[widget.index].title}'
          : 'Новая заметка'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12),
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'Название заметки',
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    hintText: 'Описание',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextButton(
                onPressed: () => _saveTask(),
                child: const Text(
                  'Сохранить заметку',
                  style: TextStyle(fontSize: 20.0)
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextButton(
                onPressed: () => _removeTask(),
                child: const Text(
                  'Удалить заметку',
                  style: TextStyle(fontSize: 20.0)
                )
              )
            ),
            const SizedBox(
              height: 50
            ),
          ],
        ),
      ),
    );
  }
}