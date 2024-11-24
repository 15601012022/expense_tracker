import 'package:flutter/material.dart';

class EducationPage extends StatefulWidget {
  final Map<String, dynamic>? data; // Accepting a data parameter

  EducationPage({Key? key, this.data}) : super(key: key); // Constructor

  @override
  _EducationPageState createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _collegeController = TextEditingController();
  final TextEditingController _cgpaController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      // Pre-fill fields if data exists
      _courseController.text = widget.data!['course'] ?? '';
      _collegeController.text = widget.data!['college'] ?? '';
      _cgpaController.text = widget.data!['cgpa'] ?? '';
      _yearController.text = widget.data!['year'] ?? '';
    }
  }

  void _clearFields() {
    setState(() {
      _courseController.clear();
      _collegeController.clear();
      _cgpaController.clear();
      _yearController.clear();
    });
  }

  void _saveDetails() {
    final course = _courseController.text;
    final college = _collegeController.text;
    final cgpa = _cgpaController.text;
    final year = _yearController.text;

    final educationData = {
      'course': course,
      'college': college,
      'cgpa': cgpa,
      'year': year,
    };

    Navigator.pop(context, educationData); // Return data to the previous screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("Education"),
        backgroundColor: Color.fromARGB(255, 73, 177, 105),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _courseController,
              decoration: const InputDecoration(
                labelText: "Course/Degree",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _collegeController,
              decoration: const InputDecoration(
                labelText: "College/Institute",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _cgpaController,
              decoration:const InputDecoration(
                labelText: "CGPA",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _yearController,
              decoration:const InputDecoration(
                labelText: "Year of Passing",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveDetails,
                  child:const Text("Save"),
                ),
                ElevatedButton(
                  onPressed: _clearFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text("Clear"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
