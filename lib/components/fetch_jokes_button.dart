import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/joke_state.dart';

class FetchJokesButton extends StatelessWidget {
  final JokeState jokeState;

  const FetchJokesButton({super.key, required this.jokeState});

  @override
  Widget build(BuildContext context) {
    // Use Consumer to listen to the jokeState and rebuild the button when isLoading changes
    return Consumer<JokeState>(
      builder: (context, jokeState, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ElevatedButton(
            onPressed: jokeState.isLoading ? null : () => _fetchJokes(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: jokeState.isLoading
                  ? Colors.white
                  : Color(0xFFaaff03), // Button color changes when loading
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: jokeState.isLoading
                ? const SizedBox(
                    width: 16.0,
                    height: 16.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.mood, // Replace with any desired icon
                        color: Colors.black,
                        size: 24,
                      ),
                      SizedBox(width: 8), // Space between icon and text
                      Text(
                        "Fetch Jokes",
                        style: TextStyle(
                          fontFamily: 'Lato-Italic',
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  // Function to fetch jokes
  void _fetchJokes(BuildContext context) {
    // Call the fetchJokes method in jokeState and update loading state
    jokeState.fetchJokes(context);
  }
}
