import 'package:flutter/material.dart';

class TopBar extends StatefulWidget implements PreferredSizeWidget {
  final List<Widget> mainContent;
  final Color backgroundColor;
  final Color iconColor;
  final double padding;
  final double gap;
  final bool isMenuShown;

  const TopBar({
    super.key,
    this.mainContent = const [],
    this.backgroundColor = const Color.fromARGB(255, 50, 50, 50),
    this.iconColor = const Color.fromARGB(255, 41, 224, 175),
    this.padding = 8.0,
    this.gap = 16.0,
    this.isMenuShown = true,
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
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w500
      ),
      iconTheme: const IconThemeData(
        color: Color.fromARGB(255, 41, 224, 175)
      ),
      title: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Wrap(
              spacing: 8,
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: widget.mainContent,
            ),
            if (widget.isMenuShown)
              IconButton(
                onPressed: () => {},
                iconSize: 32,
                splashRadius: 24,
                icon: Icon(
                  Icons.menu,
                  color: widget.iconColor,
                ),
              ),
          ],
        ),
      )
    );
  }
}
