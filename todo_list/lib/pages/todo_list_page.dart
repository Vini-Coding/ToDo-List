import 'package:flutter/material.dart';
import 'package:todo_list/models/toDo.dart';
import 'package:todo_list/myWidgets/toDo_List_Item.dart';

class ToDoListPage extends StatefulWidget {
  ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  final TextEditingController toDoController = TextEditingController();

  List<ToDo> toDos = [];

  ToDo? completedToDo;
  int? completedToDoPos;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: toDoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma tarefa',
                          hintText: 'Exemplo: Estudar Flutter',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        String text = toDoController.text;
                        setState(() {
                          ToDo newToDo = ToDo(
                            title: text,
                            dataHora: DateTime.now(),
                          );
                          toDos.add(newToDo);
                        });
                        toDoController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ], //Children da Row
                ),

                const SizedBox(
                  height: 16,
                ), //Widget SizedBox invisível para espaçar os componentes verticlamente(height)

                Flexible(
                  // Flexible pra não dar erro de overflow
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for (ToDo toDo in toDos)
                        ToDoListItem(
                          toDo:
                              toDo, //passando o toDo como valor para o meu parâmetro title do meu Widget ToDoListItem
                          onComplete: onComplete,
                        ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 16,
                ), //Widget SizedBox invisível para espaçar os componentes verticlamente(height)

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${toDos.length} tarefas pendentes', //incrementei pra pegar o tamanho da lista
                      ),
                    ),

                    const SizedBox(width: 8), //widget invisível afastando

                    ElevatedButton(
                      onPressed: showCompleteToDosConfirmationDialog,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurpleAccent,
                        padding: const EdgeInsets.all(14),
                      ),
                      child: const Text('Limpar tudo'),
                    )
                  ], //Children Da Row
                ),
              ], //Children da Coluna
            ),
          ),
        ),
      ),
    );
  }

  void onComplete(ToDo toDO) {
    completedToDo = toDO;
    completedToDoPos = toDos.indexOf(toDO);

    setState(() {
      toDos.remove(toDO);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      //SNACK BAR DESFAZER DELEÇÃO
      SnackBar(
        content: Text(
          'Tarefa ${toDO.title} foi realizada com sucesso.',
          style: const TextStyle(
            color: Color.fromARGB(255, 61, 0, 71),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 234, 234, 255),
        action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            setState(() {
              toDos.insert(completedToDoPos!, completedToDo!);
            });
          },
          textColor: Color.fromARGB(255, 79, 0, 216),
          disabledTextColor: Color.fromARGB(255, 255, 0, 191),
        ),
        duration: const Duration(seconds: 4),
      ),
    ); //Metodo scaffold
  }

  void showCompleteToDosConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpar tudo?'),
        content:
            const Text('Você tem certeza que deseja apagar todas as tarefas?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              primary: Color.fromARGB(255, 41, 223, 255),
            ),
            child: const Text(
              'Cancelar',
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              deleteAllToDos();
            },
            style: TextButton.styleFrom(
              primary: Colors.red,
            ),
            child: const Text(
              'Limpar tudo',
            ),
          ),
        ],
      ),
    );
  }

  void deleteAllToDos() {
    setState(() {
      toDos.clear();
    });
  }
}
