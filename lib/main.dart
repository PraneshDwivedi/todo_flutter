import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_provider/detailScreen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Operations(),
      child: MyApp(),
    ),
  );
}

class Operations with  ChangeNotifier{
  var todos =<Todo>[];
  var selectIndex =-1;

  delete(BuildContext context,int index)
  {
    todos.removeAt(index);
    notifyListeners();
  }
  create(BuildContext context,Todo result)
  {
    todos.add(result);
    notifyListeners();
  }
  update( context,index, Todo result)
  {
    todos[index]=result;
    notifyListeners();
  }
  selectedIndex( int index)
  {
    selectIndex=index;
    notifyListeners();
  }
  getSelectedTo(){
    return todos[selectIndex];
  }
}

class Todo {
  final String title;
  final String description;
  const Todo(this.title,this.description);// if varibale is neither late nor ? type definition
}

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
    final index= Provider.of<Operations>(context,listen: false).selectIndex;
    titleController.text= todo.title;
    descriptionController.text=todo.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(controller: titleController,),
          TextField(controller: descriptionController,),
          ElevatedButton(onPressed: (){

            Todo value= Todo(titleController.text, descriptionController.text);
            Provider.of<Operations>(context,listen: false).update(context, index, value);
            Navigator.pop(context);
          }, child: Text("Update"))
        ],
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}): super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo"),
      ),
      body: Consumer<Operations>(
        builder: (context,operations,child)=>ListView.builder(
          itemCount: operations.todos.length,
          itemBuilder: (context,index){
            return ListTile(
              trailing: Padding(
                padding: EdgeInsets.all(10.0),
                child: GestureDetector(
                  child: Icon(Icons.delete),
                  onTap: (){
                    operations.delete(context,index);
                  },
                ),
              ),
              title: Text(operations.todos[index].title),

              //on tap on tiles move to next screen
              onTap: (){
                Provider.of<Operations>(context,listen: false).selectedIndex(index);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const DetailsScreen(),
                settings: RouteSettings(arguments: operations.todos[index]),
                )
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const CreateScreen()));
        },
        tooltip: 'Create new',
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class CreateScreen extends StatefulWidget {
  const CreateScreen({Key? key}) : super(key: key);

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Create new task"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextField(controller: titleController,),
          TextField(controller: descriptionController,),
          ElevatedButton(onPressed: (){
            Todo value= Todo(titleController.text, descriptionController.text);
            Provider.of<Operations>(context,listen: false).create(context, value);
            Navigator.pop(context);
          }, child: Text("Save"))
        ],
      ),
    );
  }
}


