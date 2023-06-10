import 'package:flutter/material.dart';
import 'package:socialdl/themes/light.theme.dart';
import 'package:socialdl/widgets/navbar.widget.dart' as navbar;
import 'package:socialdl/widgets/appbar.widget.dart' as appbar;

// import tabs
import 'package:socialdl/tabs/home.tab.dart' as home_tab;
import 'package:socialdl/tabs/history.tab.dart' as history_tab;
import 'package:socialdl/tabs/settings.tab.dart' as settings_tab;

class SocialHome extends StatefulWidget {
  const SocialHome({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<SocialHome> createState() => _SocialHomeState();
}

class _SocialHomeState extends State<SocialHome> {
  int _currentIndex = 1;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<Widget> _tabs = [
    const history_tab.HistoryTab(),
    const home_tab.HomeTab(),
    const settings_tab.SettingsTab(),
  ];

  void _onTabSelect(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar.ModernAppBar(
        title: 'Social DL',
        backgroundColor: LightTheme.lightTheme.primaryColor, // Customize the background color
        textColor: Colors.white, // Customize the text color
        leadingIcon: null, // Customize the leading icon
        onLeadingIconPressed: () {
          // Handle leading icon pressed
        },
      ),
      body: PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      children: _tabs,
    ),
      bottomNavigationBar: navbar.BottomNavigationBar(
        currentIndex: _currentIndex,
        onTabSelect: _onTabSelect,
      ),
    );
  }
}
