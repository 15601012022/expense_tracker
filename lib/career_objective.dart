import 'package:flutter/material.dart';

class CareerObjectivePage extends StatefulWidget {
  final Map<String, dynamic> data;
  CareerObjectivePage({required this.data});

  @override
  _CareerObjectivePageState createState() => _CareerObjectivePageState();
}

class _CareerObjectivePageState extends State<CareerObjectivePage> {
  final TextEditingController _objectiveController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill data if already exists
    _objectiveController.text = widget.data['careerObjective'] ?? '';
    _designationController.text = widget.data['currentDesignation'] ?? '';
  }

  void _saveData() {
    widget.data['careerObjective'] = _objectiveController.text;
    widget.data['currentDesignation'] = _designationController.text;

    Navigator.pop(context, widget.data);
  }

  void _clearFields() {
    setState(() {
      _objectiveController.clear();
      _designationController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Career Objective"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _objectiveController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Career Objective",
                hintText: "Write your career objective here...",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _designationController,
              decoration: InputDecoration(
                labelText: "Current Designation (for experienced candidates)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _saveData,
                  child: Text("Save"),
                ),
                ElevatedButton(
                  onPressed: _clearFields,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text("Clear"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
