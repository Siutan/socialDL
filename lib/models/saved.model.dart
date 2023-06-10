import 'dart:developer';

class Saved {
  final String title;
  final DateTime created;
  final String provider;
  final String url;
  final String path;
  final String type;

  const Saved({
    required this.title,
    required this.created,
    required this.provider,
    required this.url,
    required this.path,
    required this.type,
  });

  factory Saved.fromMap(Map<String, dynamic> map) {
    return Saved(
      title: map['title'],
      created: map['date'],
      provider: map['provider'],
      url: map['url'],
      path: map['path'],
      type: map['type']
    );
  }

  Map<String, dynamic> toMap() {
    log('toMap');
    log('title: $title, date: $created, provider: $provider, url: $url, path: $path, type: $type');
    return {
      'title': title,
      'date': created.toIso8601String(),
      'provider': provider,
      'url': url,
      'path': path,
      'type': type
    };
  }

  @override
  String toString() {
    return 'Saved(title: $title, date: $created, provider: $provider, url: $url, path: $path, type: $type)';
  }
}
