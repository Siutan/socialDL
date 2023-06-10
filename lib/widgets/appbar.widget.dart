import 'package:flutter/material.dart';

class ModernAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final IconData? leadingIcon;
  final VoidCallback? onLeadingIconPressed;
  final List<Widget>? actions;

  const ModernAppBar({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.leadingIcon,
    this.onLeadingIconPressed,
    this.actions,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: leadingIcon != null
          ? IconButton(
        icon: Icon(
          leadingIcon,
          color: textColor,
        ),
        onPressed: onLeadingIconPressed,
      )
          : null,
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }
}
