import 'package:flutter/material.dart';
import 'package:socialdl/db/dbHelper.db.dart' as database;
import 'package:socialdl/themes/dark.theme.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  _HistoryTabState createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  late Future<List<Map<String, dynamic>>> _savedLinks;

  @override
  void initState() {
    super.initState();
    _savedLinks = _fetchSavedLinks();
  }

  Future<List<Map<String, dynamic>>> _fetchSavedLinks() async {
    await database.DatabaseHelper.initDatabase();
    return database.DatabaseHelper.fetchSavedLinks();
  }

  void openLink(String url) async {
    final Uri open = Uri.parse(url);
    if (!await launchUrl(open)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _savedLinks,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final savedLinks = snapshot.data!;
              if (savedLinks.isNotEmpty) {
                return ListView.builder(
                  itemCount: savedLinks.length,
                  itemBuilder: (context, index) {
                    final link = savedLinks[index];
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: DarkTheme.darkTheme.hintColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: DarkTheme.darkTheme.hintColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: DarkTheme.darkTheme.primaryColor,
                                padding: const EdgeInsets.all(20),
                              ),
                              onPressed: () {
                                openLink(link['url']);
                              },
                              child: Text(
                                'Open',
                                style: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: DarkTheme.darkTheme.primaryColor,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 70,
                                      padding: const EdgeInsets.all(1),
                                      color: DarkTheme.darkTheme.primaryColor,
                                      child: Text(
                                        link['provider'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Container(
                                      width: 70,
                                      padding: const EdgeInsets.all(2),
                                      color: DarkTheme.darkTheme.primaryColor,
                                      child: Text(
                                        link['type'],
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  link['title'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '03/05/2023',
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                  ),
                                ),
                                Text(
                                  link['path'],
                                  style: TextStyle(
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                      'Save a link to get started',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                      ),
                  ),
                );
              }
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
          }

          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2.0,
            ),
          );
        },
      ),
    );
  }
}
