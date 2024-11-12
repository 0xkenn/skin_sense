import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About',
            style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
        automaticallyImplyLeading: true, // Shows the back button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop(); // Go back
          },
        ),
        elevation: 0,
      ),
      backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Text('About the Application',
                style: GoogleFonts.montserrat(
                    fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 15),
          Text(
            'SkinSense was developed solely for research purposes as part of a thesis project. The app uses advanced computer vision technology to analyze photos of the facial skin and detect common skin types such as normal skin type, oily skin type, dry skin type, combination, and acne-prone skin.',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              height: 1.5, // Line height for readability
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'For accurate results, users are encouraged to take photos under proper lighting and ensure that the skin area is clearly visible without any obstructions like makeup or shadows. Please note that this app is intended strictly for academic research and is not a substitute for professional medical advice or diagnosis.',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              height: 1.5,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'The goal of this thesis project is to explore how technology can be made accessible to everyday consumers, helping them detect skin types conveniently with minimal effort.',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              height: 1.5,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            textAlign: TextAlign.center,
            'About the Researchers',
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This mobile application was developed as part of a thesis project by a group of student researchers from Biliran Province State University.',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              height: 1.5,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildResearcherInfo(
              'Kenny Charles Tabon', 'Developer/Field Researcher'),
          _buildResearcherInfo(
              'Hazel Delda', 'UI/UX Designer/Field Researcher'),
          _buildResearcherInfo('Marc Jigson Alcantara', 'Project Assistant'),
          _buildResearcherInfo('Mark Victor Del Rosario', 'Field Researcher'),
        ],
      ),
    );
  }

  Widget _buildResearcherInfo(String name, String role) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
        children: [
          Text(
            name,
            textAlign: TextAlign.center, // Center text within the Text widget
            style: GoogleFonts.montserrat(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
              height: 4), // Adds a bit of space between name and role
          Text(
            role,
            textAlign: TextAlign.center, // Center text within the Text widget
            style: GoogleFonts.montserrat(
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: Colors.black54, // Slightly dimmed color for the role
            ),
          ),
        ],
      ),
    );
  }
}
