import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() =>
      _AddTaskPageState();
}

class _AddTaskPageState
    extends State<AddTaskPage> {
  final titleController =
      TextEditingController();

  final descriptionController =
      TextEditingController();

  Future saveTask() async {
    if (titleController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      return;
    }

    await FirebaseFirestore.instance
        .collection('tasks')
        .add({
      'title':
          titleController.text.trim(),
      'description':
          descriptionController.text.trim(),
      'completed': false,
      'createdAt': Timestamp.now(),
      'userId':
          FirebaseAuth.instance.currentUser!.uid,
    });

    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF6F1F6),
      appBar: AppBar(
        backgroundColor:
            const Color(0xFFF6F1F6),
        elevation: 0,
        title: Text(
          'Add Task',
          style:
              GoogleFonts.poppins(
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller:
                  titleController,
              decoration:
                  InputDecoration(
                labelText: 'Title',
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller:
                  descriptionController,
              maxLines: 4,
              decoration:
                  InputDecoration(
                labelText:
                    'Description',
                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          20),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width:
                  double.infinity,
              height: 55,
              child:
                  ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.deepPurple,
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                ),
                onPressed:
                    saveTask,
                child: Text(
                  'Save Task',
                  style:
                      GoogleFonts.poppins(
                    color:
                        Colors.white,
                    fontSize:
                        16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}