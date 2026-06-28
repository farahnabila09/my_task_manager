import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTaskPage extends StatefulWidget {
  final String docId;
  final String title;
  final String description;

  const EditTaskPage({
    super.key,
    required this.docId,
    required this.title,
    required this.description,
  });

  @override
  State<EditTaskPage> createState() =>
      _EditTaskPageState();
}

class _EditTaskPageState
    extends State<EditTaskPage> {
  late TextEditingController
      titleController;

  late TextEditingController
      descriptionController;

  @override
  void initState() {
    super.initState();

    titleController =
        TextEditingController(
      text: widget.title,
    );

    descriptionController =
        TextEditingController(
      text: widget.description,
    );
  }

  Future updateTask() async {
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(widget.docId)
        .update({
      'title':
          titleController.text.trim(),
      'description':
          descriptionController.text.trim(),
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
          'Edit Task',
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
                    updateTask,
                child: Text(
                  'Update Task',
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