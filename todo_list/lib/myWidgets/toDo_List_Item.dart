import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/toDo.dart';

class ToDoListItem extends StatelessWidget {
  const ToDoListItem({
    Key? key,
    required this.toDo,
    required this.onComplete,
  }) : super(key: key);

  final ToDo
      toDo; //parâmetro obrigatório que vai receber o valor do nome da tarefa
  final Function(ToDo) onComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Slidable(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.grey[200],
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, //alinhar na esquerda
            children: [
              Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(toDo.dataHora),
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Text(
                toDo.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ], //children da column
          ),
        ),
        actionExtentRatio: 0.20,
        actionPane: const SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            color: Colors.green,
            icon: Icons.fact_check_outlined,
            caption: 'Concluir',
            onTap: () {
              onComplete(toDo);
            },
          )
        ],
      ),
    );
  }
}
