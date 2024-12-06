import 'package:mobx/mobx.dart';

part 'task_model.g.dart';

class TaskModel = _TaskStore with _$TaskModel;
/*
class Task {
  String title;
  String content;

  Task(this.title, this.content);
}
*/
class Task {
  String title;
  String description;

  Task(this.title, this.description);
}

abstract class _TaskStore with Store {
  @observable
  ObservableList<Task> tasks = ObservableList<Task>();

  @action
  void addTask(Task task) {
    tasks.add(task);
  }

  @action
  void modifyTask(Task task, int index) {
    tasks[index] = task;
  }

  @action
  void removeTask(int index) {
    tasks.removeAt(index);
  }
}