import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/model_class.dart';
import 'package:todo/servise/db_helper.dart';
import 'package:todo/servise/provider.dart';

class Todo extends StatefulWidget {
  const Todo({super.key});

  @override
  State<Todo> createState() => _TodoState();
}

class _TodoState extends State<Todo> {
  final name = TextEditingController();
  final ageint = TextEditingController();
  final DbHelper dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: name,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              TextField(
                controller: ageint,
                minLines: 3,
                maxLines: 5,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFFF5F5F5),
                  hintText: 'Description',
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red[200],
                        ),
                        onPressed: () {
                          name.clear();
                          ageint.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),

                  const SizedBox(width: 20),

                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[200],
                        ),
                        onPressed: () async {
                          //   Validation
                          if (name.text.isEmpty || ageint.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Filed the form'),
                                backgroundColor: Colors.redAccent,
                              ),
                            );
                            return;
                          }
                          final todoProvider = Provider.of<TodoProvider>(
                            context,
                            listen: false,
                          );
                          await todoProvider.addTodo(
                            ModelClass(
                              id: DateTime.now().millisecondsSinceEpoch,
                              name: name.text,
                              age: ageint.text,
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('successfully added TODO'),
                              backgroundColor: Colors.green,
                            ),
                          );

                          name.clear();
                          ageint.clear();

                          Navigator.pop(context);
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
