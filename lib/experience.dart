import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExperiencePage extends StatefulWidget {
  final Map<String, dynamic> data;

  const ExperiencePage({Key? key, required this.data}) : super(key: key);

  @override
  _ExperiencePageState createState() => _ExperiencePageState();
}

class _ExperiencePageState extends State<ExperiencePage> {
  final _companyController = TextEditingController();
  final _positionController = TextEditingController();
  final _rolesController = TextEditingController();
  final _dateController = TextEditingController();
  String _employmentStatus = 'Previously Employed';

  @override
  void initState() {
    super.initState();
    if (widget.data.isNotEmpty) {
      // Pre-fill fields if data exists
      _companyController.text = widget.data['company'] ?? '';
      _positionController.text = widget.data['position'] ?? '';
      _rolesController.text = widget.data['roles'] ?? '';
      _dateController.text = widget.data['dateJoined'] ?? '';
      _employmentStatus = widget.data['employmentStatus'] ?? 'Previously Employed';
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _saveExperience() {
    if (_companyController.text.isEmpty || _positionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final experience = {
      'company': _companyController.text,
      'position': _positionController.text,
      'roles': _rolesController.text,
      'employmentStatus': _employmentStatus,
      'dateJoined': _dateController.text,
    };

    widget.data.addAll(experience);

    Navigator.pop(context, widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Colors.white,
        ),
        title: const Text(
          'Experience',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 73, 177, 105),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Company Name'),
              TextField(
                controller: _companyController,
                decoration: InputDecoration(
                  hintText: 'Enter company name and location',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Position'),
              TextField(
                controller: _positionController,
                decoration: InputDecoration(
                  hintText: 'Enter your position',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Roles (optional)'),
              TextField(
                controller: _rolesController,
                decoration: InputDecoration(
                  hintText: 'Describe your roles and responsibilities',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Employment Status'),
              Row(
                children: [
                  Radio<String>(
                    value: 'Previously Employed',
                    groupValue: _employmentStatus,
                    onChanged: (String? value) {
                      setState(() {
                        _employmentStatus = value!;
                      });
                    },
                    activeColor: const Color.fromARGB(255, 73, 177, 105),
                  ),
                  const Text('Previously Employed'),
                  const SizedBox(width: 16),
                  Radio<String>(
                    value: 'Currently Employed',
                    groupValue: _employmentStatus,
                    onChanged: (String? value) {
                      setState(() {
                        _employmentStatus = value!;
                      });
                    },
                    activeColor: const Color.fromARGB(255, 73, 177, 105),
                  ),
                  const Text('Currently Employed'),
                ],
              ),
              const SizedBox(height: 24),

              _buildSectionTitle('Date Joined'),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'DD/MM/YYYY',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _companyController.clear();
                        _positionController.clear();
                        _rolesController.clear();
                        _dateController.clear();
                        setState(() {
                          _employmentStatus = 'Previously Employed';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Clear', style: TextStyle(color: Colors.black87)),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveExperience,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 73, 177, 105),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Save', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 73, 177, 105),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _companyController.dispose();
    _positionController.dispose();
    _rolesController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
