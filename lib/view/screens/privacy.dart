import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  final List<String> description = [
    'We may collect the following types of information:\n\nImages:\nPhotos of your skin that you voluntarily capture for analysis.\n\nUsage Data:\nInformation on how you interact with the app, such as usage frequency, features accessed, and errors. We do not collect personal identifiers such as your name, contact details, or location unless explicitly provided.',
    'We use the information we collect for the following purposes:\n\nImage Analysis:\nTo detect potential skin types from the photos you captured.\n\nImprovement of App Features:\nTo monitor and improve the performance and functionality of the App.\n\nResearch:\nFor academic purposes, as part of a thesis project. Data collected will be anonymized and used solely for research and development.',
    'We are committed to ensuring that your information is secure. We implement appropriate technical and organizational measures to protect your data from unauthorized access, disclosure, or alteration.\n\nImage Data:\nPhotos captured for skin type analysis are processed in real-time and are not saved on the device or any server.\n\nAnonymization:\nAny data used for research purposes will be anonymized and not linked to any personal identifiers.',
    'We do not sell, trade, or share your personal data with third parties except in the following cases:\n\nAcademic Research:\nAnonymized data may be used for academic research as part of the thesis project.\n\nLegal Requirements:\nIf required by law or to comply with legal processes.',
    'Access and Delete Your Data:\nYou may request access to or deletion of any data you have provided.\n\nWithdraw Consent:\nYou may withdraw your consent to data collection at any time by discontinuing the use of the app.',
    'Our App may contain links to third-party websites or services that are not operated by us. We are not responsible for the privacy practices of these third-party sites and recommend you review their privacy policies.',
    'The App is not intended for use by individuals under the age of 13. We do not knowingly collect personal information from children under 13.',
    'We may update this Privacy Policy from time to time. Any changes will be posted in the App with an updated effective date.',
    'If you have any questions or concerns about this Privacy Policy, please contact us at hazelmontiaora@gmail.com.'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(248, 237, 221, 1),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
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
                          description: description[index],
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
  final String description;

  const BottomDrawerContent(
      {required this.title, required this.description, super.key});

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
            description,
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
