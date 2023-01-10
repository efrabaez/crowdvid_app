import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.entrance,
    required this.exit,
    required this.primaryButtonTitle,
    required this.secondaryButtonTitle,
    required this.colour,
    required this.icon,
    required this.onPressedPrimaryButton,
    required this.onPressedSecondaryButton,
  });

  final String title;
  final String subtitle;
  final String entrance;
  final String exit;
  final String primaryButtonTitle;
  final String secondaryButtonTitle;
  final Color colour;
  final IconData icon;
  final VoidCallback onPressedPrimaryButton;
  final VoidCallback onPressedSecondaryButton;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: colour,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              minVerticalPadding: 8.0,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(
                subtitle,
                style: const TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  entrance,
                  style: const TextStyle(color: Colors.white, fontSize: 15.0),
                ),
                Text(
                  exit,
                  style: const TextStyle(color: Colors.white, fontSize: 15.0),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  onPressed: onPressedPrimaryButton,
                  child: Text(
                    primaryButtonTitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(width: 8.0),
                TextButton(
                  onPressed: onPressedSecondaryButton,
                  child: Text(
                    secondaryButtonTitle,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
