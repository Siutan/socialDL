import 'package:flutter/material.dart';
import 'package:socialdl/themes/dark.theme.dart';

class BottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelect;

  const BottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onTabSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      decoration: BoxDecoration(
        color: DarkTheme.darkTheme.primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(15)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomNavItem(Icons.history, currentIndex, 0, onTabSelect),
          _buildBottomNavItem(Icons.home, currentIndex, 1, onTabSelect),
          _buildBottomNavItem(Icons.settings, currentIndex, 2, onTabSelect),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData iconData, int currentIndex, int itemIndex,
      ValueChanged<int> onTabSelect) {
    final color = currentIndex == itemIndex ? Colors.white : DarkTheme.darkTheme.hintColor;
    return SizedBox(
      height: 50,
      width: 50,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          onTap: () => onTabSelect(itemIndex),
          child: Icon(
            iconData,
            color: color,
          ),
        ),
      ),
    );
  }
}
