import 'package:flutter/material.dart';

class FilterDialog extends StatelessWidget {
  final List<String> etatOptions;
  final Function(String) onFilterSelected;

  FilterDialog({required this.etatOptions, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    String selectedEtat = etatOptions.isNotEmpty ? etatOptions[0] : '';

    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filter by Etat',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              isExpanded: true,
              value: selectedEtat,
              onChanged: (newValue) {
                onFilterSelected(newValue!);
                Navigator.pop(context);
              },
              items: etatOptions.map((etat) {
                return DropdownMenuItem<String>(
                  value: etat,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      etat,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
