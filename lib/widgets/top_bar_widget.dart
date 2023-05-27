import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget> mainContent;
  final Color backgroundColor;
  final Color iconColor;
  final double padding;
  final double gap;
  final bool isMenuShown;
  final bool isPopAble;

  const TopBar({
    super.key,
    this.mainContent = const [],
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.padding = 8.0,
    this.gap = 16.0,
    this.isMenuShown = true,
    this.isPopAble = true
  });

  @override
  TopBarState createState() => TopBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: widget.backgroundColor,
      title: Wrap(
        spacing: 8,
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: widget.mainContent,
      ),
      actions: [
        if (widget.isMenuShown)
          IconButton(
            onPressed: () => Scaffold.of(context).openEndDrawer(),
            iconSize: 32,
            splashRadius: 24,
            icon: Icon(
              Icons.menu,
              color: widget.iconColor,
            ),
          ),
      ],
      automaticallyImplyLeading: widget.isPopAble,
    );
  }
}
