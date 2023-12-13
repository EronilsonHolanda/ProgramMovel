import 'package:flutter/material.dart';
import 'package:todo_app/app_settings.dart';
import 'package:todo_app/controller/post_controller.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _HomePageState();
}

class _HomePageState extends State<PostPage> {
  final controller = HomeController();

  

  _success() {
    return ListView.builder(
      itemCount: controller.todos.length,
      itemBuilder: (context, index) {
        var todo = controller.todos[index];

        return ListTile(
          leading: Checkbox(
            value: todo.completed ?? false,
            onChanged: (bool? value) {
              setState(() {
                todo.completed = value;
              });
            },
          ),
          title: Text(todo.title ?? ''),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              if (todo.completed ?? false) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirmação'),
                    content: Text('Tem certeza de que deseja excluir esta tarefa?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            controller.removeTodo(todo);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text('Confirmar'),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Marque a tarefa como concluída antes de excluí-la.'),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  _error() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          controller.start();
        },
        child: const Text('Tentar Novamente'),
      ),
    );
  }

  _loading() {
    return const Center(child: CircularProgressIndicator());
  }

  _start() {
    return Container();
  }

  manageState(HomeState state) {
    switch (state) {
      case HomeState.start:
        return _start();
      case HomeState.loading:
        return _loading();
      case HomeState.success:
        return _success();
      case HomeState.error:
        return _error();
      default:
        return _start();
    }
  }

  @override
  void initState() {
    super.initState();
    controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Todo List'),
        actions: [
          Switch(
            value: AppSettings.instance.isDarkMode,
            onChanged: (value) {
              setState(() {
                AppSettings.instance.changeDarkMode(value);
              });
            },
          ),
          IconButton(
            onPressed: () => controller.start(),
            icon: const Icon(Icons.refresh_outlined),
          )
        ],
      ),
      body: AnimatedBuilder(
        animation: controller.state,
        builder: (context, child) {
          return manageState(controller.state.value);
        },
      ),
    );
  }
}
