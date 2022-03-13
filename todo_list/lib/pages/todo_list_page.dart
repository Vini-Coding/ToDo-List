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
                      onPressed: () {},
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
    setState(() {
      toDos.remove(toDO);
    });
  }
}
