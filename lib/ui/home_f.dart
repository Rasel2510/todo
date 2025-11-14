import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/servise/provider.dart';
import 'package:todo/widget/todo.dart';

class HomeF extends StatefulWidget {
  const HomeF({super.key});

  @override
  State<HomeF> createState() => _HomeFState();
}

class _HomeFState extends State<HomeF> {
  @override
  void initState() {
    super.initState();
    // Load todos when screen starts
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TodoProvider>(context, listen: false).loadTodos();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu),
            const Text("TODO", style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          // Show loading indicator
          if (todoProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show empty state
          if (todoProvider.todos.isEmpty) {
            return const Center(
              child: Text(
                "No todos found",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          // Show todo list
          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              final item = todoProvider.todos[index];
              return Card(
                elevation: 4,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: ListTile(
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.age),
                  trailing: IconButton(
                    onPressed: () async {
                      await todoProvider.deleteTodo(item.id);
                      
                    },
                    icon: const Icon(Icons.remove, color: Colors.red),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red[200],
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Todo()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
