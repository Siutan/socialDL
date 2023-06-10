import 'package:flutter/material.dart';
import 'package:socialdl/pages/home.page.dart';
import 'package:socialdl/themes/dark.theme.dart';


void main() {
  runApp(const SocialDL());
}

// test link: https://vt.tiktok.com/ZSLY3Cp6t/

class SocialDL extends StatelessWidget {
  const SocialDL({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Social DL',
      theme: DarkTheme.darkTheme,
      home: const SocialHome(title: 'Social DL'),
    );
  }
}

