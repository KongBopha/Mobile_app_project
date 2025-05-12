import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/model/taskprovider.dart';
import 'package:task_manager_app/model/categoriesprovider.dart';
import 'package:task_manager_app/model/task.dart';
import 'package:task_manager_app/addtaskscreen.dart';
import 'package:intl/intl.dart';
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  late Future<void> _taskFuture;
  late Future<void> _categoryFuture;
  @override
  void initState() {
    super.initState();
    _taskFuture = Provider.of<TaskProvider>(context, listen: false).getPost();
    _categoryFuture = Provider.of<CategoriesProvider>(context, listen: false).getCategories();

  }

  @override
  Widget build(BuildContext context) {
    final today = DateFormat('MMM dd, yyyy').format(DateTime.now());

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFF1E2A4A),
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: Column(
              children: [
                _buildHeader(today),
                const SizedBox(height: 20),
                Expanded(child: _buildTaskList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const CircleAvatar(
          backgroundColor: Color(0xFF2F3C5E),
          child: Icon(Icons.person, color: Colors.white),
        ),
        Text(
          date,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        const CircleAvatar(
          backgroundColor: Color(0xFF2F3C5E),
          child: Icon(Icons.search_outlined, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildTaskList() {
    return FutureBuilder(
      future: _taskFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error fetching tasks: ${snapshot.error}',
              style: const TextStyle(color: Colors.white),
            ),
          );
        }

        final tasks = Provider.of<TaskProvider>(context).tasks;

        if (tasks.isEmpty) {
          return const Center(
            child: Text(
              'No tasks yet. Tap "+" to add one!',
              style: TextStyle(color: Colors.white70),
            ),
          );
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: task.isCompleted ? Colors.green[300] : const Color(0xFF2F3C5E),
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                title: Text(
                  task.title,
                  style: TextStyle(
                    color: Colors.white,
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  task.description ?? "Leave a note",
                  style: const TextStyle(color: Colors.white70),
                ),
                leading: Checkbox(
                  value: task.isCompleted,
                  activeColor: Color.fromARGB(255, 238, 101, 101),
                  checkColor: Color.fromARGB(255, 255, 255, 255),
                  onChanged: (value) {
                    Provider.of<TaskProvider>(context, listen: false).toggleTaskCompleted(task);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(value! ? 'Task marked completed' : 'Task marked incomplete'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );

  }
  BottomAppBar _buildBottomNavigationBar() {
    return BottomAppBar(
      color: const Color(0xFF1E2A4A),
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home_filled, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () => _showAddTaskDialog(context),
            ),
            IconButton(
              icon: const Icon(Icons.settings, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
    
  void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();
    DateTime selectedDateTime = DateTime.now();

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Add new task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Task Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: 'Task Description'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(hintText: 'Task Category'),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Selected: ${DateFormat('dd MMM yyyy – hh:mm a').format(selectedDateTime)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedDateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                          );
                          if (time != null) {
                            setState(() {
                              selectedDateTime = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        }
                      },
                      child: const Text('Pick Date'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Confirm'),
              onPressed: () {
                final newTask = Task(
                  title: titleController.text,
                  description: descriptionController.text,
                  categoryId: '',
                  dueDate: selectedDateTime,
                  isCompleted: false,
                  dateTime: selectedDateTime,
                   id:'', 
                );
                Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateTaskDialog(BuildContext context, Task task) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);
    //final categoryController = TextEditingController(text: task.categoryId);
    DateTime selectedDateTime = task.dateTime;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Update task'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Task Title'),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(hintText: 'Task Description'),
                ),
                // TextField(
                //   controller: categoryController,
                //   decoration: const InputDecoration(hintText: 'Task Category'),
                // ),

                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Selected: ${DateFormat('dd MMM yyyy – hh:mm a').format(selectedDateTime)}',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: selectedDateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (date != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                          );
                          if (time != null) {
                            setState(() {
                              selectedDateTime = DateTime(
                                date.year,
                                date.month,
                                date.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        }
                      },
                      child: const Text('Pick Date'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: const Text('Update'),
              onPressed: () {
                Provider.of<TaskProvider>(context, listen: false).updateTask(
                  Task(
                    id: task.id,
                    title: titleController.text,
                    description: descriptionController.text,
                    isCompleted: task.isCompleted,
                    dateTime: selectedDateTime,
                    categoryId: task.categoryId,
                    dueDate: selectedDateTime, 
                  ),
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
