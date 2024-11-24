import 'package:flutter/material.dart';

class ContactInfoPage extends StatefulWidget {
  final Map<String, dynamic> data;

  ContactInfoPage({required this.data});

  @override
  _ContactInfoPageState createState() => _ContactInfoPageState();
}

class _ContactInfoPageState extends State<ContactInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();


  @override
  void initState() {
    super.initState();
    // Pre-fill data if already exists
    _nameController.text = widget.data['name'] ?? '';
    _emailController.text = widget.data['email'] ?? '';
    _phoneController.text = widget.data['phone'] ?? '';
    _addressLine1Controller.text = widget.data['addressLine1'] ?? '';
    _addressLine2Controller.text = widget.data['addressLine2'] ?? '';
  }

  void _saveData() {
    widget.data['name'] = _nameController.text;
    widget.data['email'] = _emailController.text;
    widget.data['phone'] = _phoneController.text;
    widget.data['addressLine1'] = _addressLine1Controller.text;
    widget.data['addressLine2'] = _addressLine2Controller.text;

    Navigator.pop(context, widget.data);
  }

  void _clearFields() {
    setState(() {
      _nameController.clear();
      _emailController.clear();
      _phoneController.clear();
      _addressLine1Controller.clear();
      _addressLine2Controller.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact Info"),
        backgroundColor: const Color.fromARGB(255, 73, 177, 105),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Email ID",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressLine1Controller,
              decoration: const InputDecoration(
                labelText: "Address Line 1",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _addressLine2Controller,
              decoration: const InputDecoration(
                labelText: "Address Line 2",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
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
