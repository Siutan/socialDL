import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsTab extends StatelessWidget {
  final String githubUrl = 'https://github.com/your_project';

  const SettingsTab({Key? key}) : super(key: key);

  void _launchGitHubUrl() async {
    const url = 'https://www.github.com';
    final Uri open = Uri.parse(url);
    if (!await launchUrl(open)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Features',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'So far this app has the following features:',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Text(
              '- Download TikTok videos',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Text(
              '- Download Tiktok Images',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Text(
              'Upcoming features:',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Text(
              '- Download Youtube videos with support for multiple formats and resolutions',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Text(
              '- Download Youtube audio with support for multiple formats and bitrates',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            InkWell(
              onTap: _launchGitHubUrl,
              child: const Row(
                children: [
                  Icon(Icons.link, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    'GitHub Repository',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
