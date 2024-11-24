import 'package:flutter/material.dart';
import 'career_objective.dart';
import 'personal_details.dart';
import 'contact_info.dart';
import 'education.dart';
import 'experience.dart';
import 'technical_skills.dart';
import 'projects.dart';
import 'achievements.dart';
import 'declaration.dart';


class ResumeWorkspace extends StatefulWidget {
  @override
  _ResumeWorkspaceState createState() => _ResumeWorkspaceState();
}

class _ResumeWorkspaceState extends State<ResumeWorkspace> {
  final List<String> sections = [
    "Contact Info",
    "Career Objective",
    "Personal Details",
    "Education",
    "Experience",
    "Technical Skills",
    "Projects",
    "Achievements",
    "Declarations",
  ];

  final Map<String, dynamic> data = {}; // Store data for all sections
  List<String> skills = []; // This holds the user's skills
  List<Map<String, dynamic>> _projects = [];
  

  void _navigateToSection(BuildContext context, String section) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          switch (section) {
            case "Contact Info":
              return ContactInfoPage(data: data);
            case "Career Objective":
              return CareerObjectivePage(data: data);
            case "Personal Details":
              return PersonalDetailsPage(data: data);
            case "Education":
              return EducationPage(data: data);
            case "Experience":
              return ExperiencePage(data: data);
            case "Technical Skills":
              return TechnicalSkillsPage(data: data, skills: const [],);
            case "Projects":
              return ProjectPage(existingProjects : _projects);
            case "Achivements":
              return AchievementPage(existingAchievements: data["Achievements"] ?? [],);
            case "Declaration":
              return DeclarationPage(data : data);
            default:
              return PlaceholderPage(section: section);
          }
        },
      ),
    );

    // Update the data after returning from the page
    if (result != null) {
      setState(() {
        data[section] = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Resume Workspace"),
        backgroundColor: const Color.fromARGB(255, 73, 177, 105),
        actions: [
          IconButton(
            icon: Icon(Icons.picture_as_pdf),
            tooltip: "Finalize Resume",
            onPressed: () {
              Navigator.pop(context, data);
            },
          )
        ],
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.arrow_right),
            title: Text(sections[index]),
            onTap: () => _navigateToSection(context, sections[index]),
          );
        },
      ),
    );
  }
}

// Placeholder for sections without implemented logic
class PlaceholderPage extends StatelessWidget {
  final String section;
  const PlaceholderPage({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(section)),
      body: Center(child: Text("$section is under development")),
    );
  }
}
