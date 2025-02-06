import 'package:flutter/material.dart';

class AddTask extends StatefulWidget{
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask>{
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Enter task',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: (){
                Navigator.pop(context, _controller.text);
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
