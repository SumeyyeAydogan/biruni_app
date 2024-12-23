// Tek bir iletişim bilgisi için özel widget
import 'package:flutter/material.dart';

class ContactInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final bool isLink;
  final VoidCallback? onTap;

  ContactInfoRow({
    required this.icon,
    required this.text,
    this.isLink = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLink ? onTap : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.blue),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isLink ? Colors.blue : Colors.black,
                decoration: isLink ? TextDecoration.underline : TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}