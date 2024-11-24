import 'package:flutter/material.dart';

class PersonalDetailsPage extends StatefulWidget {
  final Map<String, dynamic> data;
  PersonalDetailsPage({required this.data});

  @override
  _PersonalDetailsPageState createState() => _PersonalDetailsPageState();
}

class _PersonalDetailsPageState extends State<PersonalDetailsPage> {
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _languageController = TextEditingController();
  final TextEditingController _nationalityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Pre-fill data if already exists
    _dobController.text = widget.data['dob'] ?? '';
    _maritalStatusController.text = widget.data['maritalStatus'] ?? '';
    _languageController.text = widget.data['languages'] ?? '';
    _nationalityController.text = widget.data['nationality'] ?? '';
  }

  void _saveData() {
    widget.data['dob'] = _dobController.text;
    widget.data['maritalStatus'] = _maritalStatusController.text;
    widget.data['languages'] = _languageController.text;
    widget.data['nationality'] = _nationalityController.text;

    Navigator.pop(context, widget.data);
  }

  void _clearFields() {
    setState(() {
      _dobController.clear();
      _maritalStatusController.clear();
      _languageController.clear();
      _nationalityController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personal Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _dobController,
              decoration: InputDecoration(
                labelText: "Date of Birth (DD/MM/YYYY)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _maritalStatusController,
              decoration: InputDecoration(
                labelText: "Marital Status",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _languageController,
              decoration: InputDecoration(
                labelText: "Languages Known",
                hintText: "e.g., English, Hindi, French",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _nationalityController,
              decoration: InputDecoration(
                labelText: "Nationality",
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
