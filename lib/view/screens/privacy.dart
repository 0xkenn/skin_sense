import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  PrivacyPolicyScreen({super.key});
  final List<String> titles = [
    "Information We Collect",
    "How We Use Your Information",
    "Data Storage and Security",
    "Sharing of Information",
    "Your Rights",
    "Third-Party Services",
    "Children's Privacy",
    "Changes to This Policy",
    "Contact Us",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Action for back button
          },
        ),
        title: const Text('Privacy Policy'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "SkinSense ('we,' 'our,' or 'us') is committed to protecting your privacy. "
              "This Privacy Policy explains how we collect, use, disclose, and safeguard your information "
              "when you use our mobile application.",
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 8),
            const Text(
              "Effective Date: October 1, 2024",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: titles.length,
                itemBuilder: (context, index) {
                  return PrivacyCard(
                    title: titles[index],
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => BottomDrawerContent(
                          title: titles[index],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PrivacyCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const PrivacyCard({required this.title, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(title),
        trailing: const Icon(Icons.keyboard_arrow_down),
        onTap: onTap,
      ),
    );
  }
}

class BottomDrawerContent extends StatelessWidget {
  final String title;

  const BottomDrawerContent({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            "This is where the detailed information about $title will be displayed. "
            "You can replace this text with the actual content.",
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
