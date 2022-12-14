import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonTitle,
    required this.colour,
    required this.icon,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final String buttonTitle;
  final Color colour;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: colour,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              leading: Icon(
                icon,
                color: Colors.white,
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: onPressed,
                  child: Text(
                    buttonTitle,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
