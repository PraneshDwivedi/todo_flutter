/*
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/main.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final titleController =TextEditingController();
  final descriptionController =TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    //final todo = ModalRoute.of(context)!.settings.arguments as ToDo;
    final todo= Provider.of<Operations>(context,listen: false).getSelectedTo();
    final index= Provider.of<Operations>(context,listen: false).selectedIndex();
    titleController.text= todo.title;
    descriptionController.text=todo.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),

    );
  }
}
*/
