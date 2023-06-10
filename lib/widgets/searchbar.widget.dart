import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:socialdl/api/detect.api.dart';
import 'package:socialdl/themes/dark.theme.dart';
import 'package:socialdl/widgets/snackbar.widget.dart';

import 'package:socialdl/db/dbHelper.db.dart' as database;

import 'package:socialdl/models/saved.model.dart';

class ModernSearchInput extends StatefulWidget {
  const ModernSearchInput({Key? key}) : super(key: key);

  @override
  _ModernSearchInputState createState() => _ModernSearchInputState();
}

class _ModernSearchInputState extends State<ModernSearchInput> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _onSearchPressed(value) async {
    if (value.isEmpty) {
      return;
    }

    Snackbar.create('Downloading...', 1, context);

    final response = await handleLink(value);

    if (response != null) {
      log('response: $response');
      final savedItem = Saved(
        title: response['title'],
        created: response['created'] ?? DateTime.now().toString(),
        provider: response['provider'],
        url: response['url'],
        path: response['path'],
        type: response['type'],
      );

      log('savedItem: $savedItem');
      database.DatabaseHelper.insertSaved(savedItem);
      Snackbar.create('Downloaded: $value', 2, context);
    } else {
      log('response: $response');
      Snackbar.create('Invalid Link', 2, context);
    }


  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _searchController,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              fillColor: DarkTheme.darkTheme.hintColor,
              filled: true,
              hintText: 'Enter Link',
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              suffixIcon: Container(
                margin: const EdgeInsets.only(
                    right: 12, left: 12, top: 10, bottom: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 45),
                    backgroundColor: DarkTheme.darkTheme.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  child: const Text("Search"),
                  onPressed: () {
                    _onSearchPressed(_searchController.text);
                  },
                ),
              ),
            ),
            onSubmitted: (value) {
              log('Submitted: $value');
              _onSearchPressed(value);
            },
          ),
        ),
      ],
    );
  }
}
