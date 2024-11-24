import 'package:flutter/material.dart';

class DeclarationPage extends StatefulWidget {
  final Map<String, dynamic> data;
  const DeclarationPage({Key? key, required this.data}) : super(key: key);

  @override
  _DeclarationPageState createState() => _DeclarationPageState();
}

class _DeclarationPageState extends State<DeclarationPage> {
  final TextEditingController _signatureController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  static const primaryGreen = Color(0xFF4CAF50);

  void _submitDeclaration() {
    if (_signatureController.text.isEmpty || _dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all the fields"),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // You can process the data or navigate back with the result
    Navigator.pop(context, {
      "signature": _signatureController.text,
      "date": _dateController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: const Text(
          'Declaration',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: primaryGreen,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Declaration',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2E2E2E),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "I hereby declare that all the information provided in this resume is true and accurate to the best of my knowledge. I take full responsibility for the authenticity of the details provided.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 32),
              // Signature Input
              TextField(
                controller: _signatureController,
                decoration: InputDecoration(
                  labelText: "Signature",
                  labelStyle: const TextStyle(color: primaryGreen),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.person, color: primaryGreen),
                ),
              ),
              const SizedBox(height: 16),
              // Date Input
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: "Date",
                  labelStyle: const TextStyle(color: primaryGreen),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.calendar_today, color: primaryGreen),
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitDeclaration,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Submit Declaration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _signatureController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
