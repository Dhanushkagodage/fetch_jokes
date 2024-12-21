import 'package:flutter/material.dart';
import '../../state/joke_state.dart';

class JokeCategoryDropdown extends StatelessWidget {
  final JokeState jokeState;

  const JokeCategoryDropdown({super.key, required this.jokeState});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 16.0), // Add margin to the left and right
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 32), // Add padding to the top and bottom
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0), // Set border radius
          border: Border.all(
              color: Colors.blueAccent, width: 2.0), // Border color and width
        ),

        child: DropdownButton<String>(
          value: jokeState.selectedCategory.isEmpty
              ? null
              : jokeState.selectedCategory,
          onChanged: (String? newValue) {
            jokeState.updateSelectedCategory(newValue);
          },
          iconSize: 36,
          items: <String>[
            'Programming',
            'Misc',
            'Dark',
            'Pun',
            'Spooky',
            'Christmas'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0), // Margin around each dropdown item
                child: Text(
                  value,
                  style: const TextStyle(
                    fontFamily: 'LobsterTwo-Regular',
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }).toList(),
          iconEnabledColor: Colors.blue, // Make the dropdown arrow more visible
          isExpanded: true, // Ensure the dropdown occupies the full width
          underline: const SizedBox(), // Remove default underline
          dropdownColor: Colors.white,
        ),
      ),
    );
  }
}
