import 'package:flutter/material.dart';
import 'resume_workspace.dart'; // Assuming ResumeWorkspace is in this file.

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> resumes = []; // List to store resume data.

  void _navigateToResumeBuilder() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ResumeWorkspace()), // Navigate to ResumeBuilder
    );

    if (result != null) {
      setState(() {
        resumes.add(result); // Add the resume details returned from ResumeBuilder.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Builder"),
        backgroundColor: const Color.fromARGB(255, 73, 177, 105),
      ),
      body: resumes.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Create new Resume",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: resumes.length,
              itemBuilder: (context, index) {
                final resume = resumes[index];
                return ListTile(
                  title: Text(resume['title'] ?? 'Resume ${index + 1}'),
                  subtitle: Text("Last updated: ${DateTime.now().toLocal()}"),
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // Optionally navigate to a resume details page
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToResumeBuilder,
        backgroundColor: Color.fromARGB(255, 73, 177, 105),
        child: const Icon(Icons.add),
      ),
    );
  }
}
