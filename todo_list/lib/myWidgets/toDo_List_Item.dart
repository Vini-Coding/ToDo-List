import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/models/toDo.dart';

class ToDoListItem extends StatelessWidget {
  const ToDoListItem({ Key? key, required this.toDo }) : super(key: key);

  final ToDo toDo; //parâmetro obrigatório que vai receber o valor do nome da tarefa


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey[200],
      ),
      
      margin: const EdgeInsets.symmetric(vertical: 2),

      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, //alinhar na esquerda
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
        ],
      ),
    );
  }
}