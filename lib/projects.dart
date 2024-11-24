import 'package:flutter/material.dart';

class ProjectPage extends StatefulWidget {
  final List<Map<String, dynamic>> existingProjects; // Projects already added

  const ProjectPage({super.key, required this.existingProjects});

  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  final _projectTitleController = TextEditingController();
  final _rolesController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final _teamSizeController = TextEditingController();

  final List<String> _availableTechnologies = [
    'C Programming',
    'C++',
    'Flutter',
    'Python',
    'Java',
    'JavaScript',
  ];

  final Set<String> _selectedTechnologies = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, widget.existingProjects), // Return existing projects if back is pressed
          color: Colors.white,
        ),
        title: const Text(
          'Projects',
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
              _buildSectionTitle('Project Title'),
              TextField(
                controller: _projectTitleController,
                decoration: InputDecoration(
                  hintText: 'Enter project title',
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
              _buildSectionTitle('Technologies'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _availableTechnologies.map((tech) {
                  return FilterChip(
                    label: Text(tech),
                    selected: _selectedTechnologies.contains(tech),
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedTechnologies.add(tech);
                        } else {
                          _selectedTechnologies.remove(tech);
                        }
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: const Color.fromARGB(255, 73, 177, 105).withOpacity(0.2),
                    checkmarkColor: const Color.fromARGB(255, 73, 177, 105),
                    side: BorderSide(
                      color: _selectedTechnologies.contains(tech)
                          ? const Color.fromARGB(255, 73, 177, 105)
                          : Colors.grey,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Roles'),
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
                maxLines: 2,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Team Size'),
              TextField(
                controller: _teamSizeController,
                decoration: InputDecoration(
                  hintText: 'Enter team size',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Project Description'),
              TextField(
                controller: _projectDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter project description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: 4,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveProject,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 73, 177, 105),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
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
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 73, 177, 105),
        ),
      ),
    );
  }

  void _saveProject() {
    // Collect project details
    final project = {
      'title': _projectTitleController.text.trim(),
      'technologies': _selectedTechnologies.toList(),
      'roles': _rolesController.text.trim(),
      'teamSize': _teamSizeController.text.trim(),
      'description': _projectDescriptionController.text.trim(),
    };

    // Add new project to the existing list
    setState(() {
      widget.existingProjects.add(project);
    });

    // Return the updated projects list
    Navigator.pop(context, widget.existingProjects);
  }

  @override
  void dispose() {
    _projectTitleController.dispose();
    _rolesController.dispose();
    _projectDescriptionController.dispose();
    _teamSizeController.dispose();
    super.dispose();
  }
}
