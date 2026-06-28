import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth_service.dart';
import 'add_task_page.dart';
import 'edit_task_page.dart';
import 'package:intl/intl.dart';
import 'login_page.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F1F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F1F6),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Hello, ${user?.email ?? 'User'} 👋',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.black,
            ),
onPressed: () async {
            await auth.logout();

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      const LoginPage(),
                ),
                (route) => false,
              );
            }
          },
                    ),
        ],
      ),

      body: StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance
      .collection('tasks')
      .where(
        'userId',
        isEqualTo:
            FirebaseAuth
                .instance
                .currentUser!
                .uid,
      )
      .snapshots(),

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(),
            );
          }

          final tasks =
              snapshot.data?.docs ?? [];

          final completed = tasks
              .where(
                (task) =>
                    task['completed'] ==
                    true,
              )
              .length;

          return Padding(
            padding:
                const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                Text(
                  'Manage your daily tasks',
                  style:
                      GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                    height: 20),

                TextField(
                  decoration:
                      InputDecoration(
                    hintText:
                        'Search task...',
                    prefixIcon:
                        const Icon(
                      Icons.search,
                    ),
                    filled: true,
                    fillColor:
                        Colors.white,
                    border:
                        OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(
                              20),
                      borderSide:
                          BorderSide.none,
                    ),
                  ),
                ),

                const SizedBox(
                    height: 25),

                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 140,
                        decoration:
                            BoxDecoration(
                          gradient:
                              const LinearGradient(
                            colors: [
                              Color(
                                  0xFFD9C2E9),
                              Color(
                                  0xFFEADCF3),
                            ],
                          ),
                          borderRadius:
                              BorderRadius.circular(
                                  25),
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                          children: [
                            const Icon(
                              Icons.assignment,
                              size: 40,
                              color:
                                  Colors.deepPurple,
                            ),
                            const SizedBox(
                                height:
                                    10),
                            Text(
                              'Total Tasks',
                              style:
                                  GoogleFonts
                                      .poppins(),
                            ),
                            const SizedBox(
                                height:
                                    8),
                            Text(
                              '${tasks.length}',
                              style:
                                  GoogleFonts
                                      .poppins(
                                fontSize:
                                    35,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(
                        width: 15),

                    Expanded(
                      child: Container(
                        height: 140,
                        decoration:
                            BoxDecoration(
                          gradient:
                              const LinearGradient(
                            colors: [
                              Color(
                                  0xFFDCC6E0),
                              Color(
                                  0xFFF2E7F8),
                            ],
                          ),
                          borderRadius:
                              BorderRadius.circular(
                                  25),
                        ),
                        child: Column(
                          mainAxisAlignment:
                              MainAxisAlignment
                                  .center,
                          children: [
                            const Icon(
                              Icons.check_circle,
                              size: 40,
                              color:
                                  Colors.green,
                            ),
                            const SizedBox(
                                height:
                                    10),
                            Text(
                              'Completed',
                              style:
                                  GoogleFonts
                                      .poppins(),
                            ),
                            const SizedBox(
                                height:
                                    8),
                            Text(
                              '$completed',
                              style:
                                  GoogleFonts
                                      .poppins(
                                fontSize:
                                    35,
                                fontWeight:
                                    FontWeight
                                        .bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                    height: 30),

                Text(
                  'My Tasks',
                  style:
                      GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),

                const SizedBox(
                    height: 20),

                Expanded(
                  child:
                      tasks.isEmpty
                          ? Center(
                              child:
                                  Text(
                                'No Tasks Yet',
                                style:
                                    GoogleFonts.poppins(),
                              ),
                            )
                          : ListView.builder(
                              itemCount:
                                  tasks.length,
                              itemBuilder:
                                  (context,
                                      index) {
                                final task =
                                    tasks[index];

                                return Card(
                                  color: task[
                                          'completed']
                                      ? Colors
                                          .green
                                          .shade50
                                      : Colors
                                          .white,
                                  elevation:
                                      4,
                                  margin:
                                      const EdgeInsets.only(
                                          bottom:
                                              15),
                                  shape:
                                      RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(
                                            20),
                                  ),
                                  child:
                                      ListTile(
                                    leading:
                                        Checkbox(
                                      value:
                                          task['completed'],
                                      onChanged:
                                          (value) async {
                                        await FirebaseFirestore
                                            .instance
                                            .collection(
                                                'tasks')
                                            .doc(
                                                task.id)
                                            .update({
                                          'completed':
                                              value,
                                        });
                                      },
                                    ),

                                    title:
                                        Text(
                                      task['title'],
                                      style:
                                          GoogleFonts.poppins(
                                        fontWeight:
                                            FontWeight.w600,
                                        decoration:
                                            task['completed']
                                                ? TextDecoration.lineThrough
                                                : null,
                                      ),
                                    ),

                                     subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            task['description'],
                                            style: GoogleFonts.poppins(
                                              decoration:
                                                  task['completed']
                                                      ? TextDecoration.lineThrough
                                                      : null,
                                            ),
                                          ),

                                          const SizedBox(height: 8),

                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.schedule,
                                                size: 14,
                                                color: Colors.grey,
                                              ),

                                              const SizedBox(width: 5),

                                              Text(
                                                task['createdAt'] != null
                                                    ? DateFormat(
                                                        'dd MMM yyyy • hh:mm a',
                                                      ).format(
                                                        (task['createdAt']
                                                                as Timestamp)
                                                            .toDate(),
                                                      )
                                                    : '',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),

                                    trailing:
                                        Row(
                                      mainAxisSize:
                                          MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon:
                                              const Icon(
                                            Icons.edit,
                                            color:
                                                Colors.blue,
                                          ),
                                          onPressed:
                                              () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (_) =>
                                                        EditTaskPage(
                                                  docId:
                                                      task.id,
                                                  title:
                                                      task['title'],
                                                  description:
                                                      task['description'],
                                                ),
                                              ),
                                            );
                                          },
                                        ),

                                        IconButton(
                                          icon:
                                              const Icon(
                                            Icons.delete,
                                            color:
                                                Colors.red,
                                          ),
                                          onPressed:
                                              () async {
                                            final result =
                                                await showDialog(
                                              context:
                                                  context,
                                              builder:
                                                  (context) {
                                                return AlertDialog(
                                                  title:
                                                      const Text(
                                                    'Delete Task',
                                                  ),
                                                  content:
                                                      const Text(
                                                    'Are you sure you want to delete this task?',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed:
                                                          () {
                                                        Navigator.pop(
                                                            context,
                                                            false);
                                                      },
                                                      child:
                                                          const Text(
                                                        'Cancel',
                                                      ),
                                                    ),
                                                    ElevatedButton(
                                                      onPressed:
                                                          () {
                                                        Navigator.pop(
                                                            context,
                                                            true);
                                                      },
                                                      child:
                                                          const Text(
                                                        'Delete',
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );

                                            if (result ==
                                                true) {
                                              await FirebaseFirestore
                                                  .instance
                                                  .collection(
                                                      'tasks')
                                                  .doc(
                                                      task.id)
                                                  .delete();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton:
          FloatingActionButton.extended(
        backgroundColor:
            Colors.deepPurple,
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text(
          'Add Task',
          style:
              GoogleFonts.poppins(
            color: Colors.white,
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddTaskPage(),
            ),
          );
        },
      ),
    );
  }
}