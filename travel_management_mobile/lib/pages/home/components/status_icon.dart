import 'package:flutter/material.dart';

class StatusIcons extends StatelessWidget {
  final String status;

  StatusIcons({required this.status});

  Color getButtonColor() {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'COMPLETED':
        return Colors.teal;
      case 'CANCELED':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: getButtonColor(),
          minimumSize: Size(100.0, 44.0),
        ),
        child: Text(
          status.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }
}
