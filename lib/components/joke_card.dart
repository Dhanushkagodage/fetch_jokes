import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final dynamic joke;

  const JokeCard({super.key, required this.joke});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      color: Colors.white,
      shadowColor: Colors.black.withOpacity(0.3), // Shadow effect
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon with an optional image, here using Icons for simplicity
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(
                Icons.mood, // Fun, playful icon
                color: Colors.green,
                size: 45,
              ),
            ),
            const SizedBox(width: 16), // Spacing between icon and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Joke Type Header: Single Joke or Setup
                  Text(
                    joke.type == 'single' ? 'Single Joke' : 'Joke Setup',
                    style: const TextStyle(
                      fontSize: 18,
                      fontFamily: 'Lato-Italic',
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Joke content: dynamic size based on content
                  Text(
                    joke.type == 'single'
                        ? joke.joke!
                        : '${joke.setup}\n\n- ${joke.delivery}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      height: 1.5,
                      fontFamily: 'Lato-Regular',
                    ),
                    textAlign: TextAlign.justify,
                    maxLines:
                        6, // Limiting the number of lines to keep the layout neat
                    overflow: TextOverflow
                        .ellipsis, // Truncates long jokes if necessary
                  ),
                  const SizedBox(height: 8),
                  // Optional Button or action (for additional interaction)
                  if (joke.type == 'setup')
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Tell me more!',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
