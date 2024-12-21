import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/joke_state.dart';
import '../components/fetch_jokes_button.dart';
import '../components/joke_card.dart';
import '../components/joke_category_dropdown.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final jokeState = Provider.of<JokeState>(context);

    // Handle loading state when jokes are empty
    if (!jokeState.isLoading && jokeState.jokes.isNotEmpty) {
      // Scroll to the top when jokes are fetched
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(0);
        }
      });
    }

    return Scaffold(
      body: Column(
        children: [
          // Top background image
          Container(
            width: double.infinity,
            height: 400 * jokeState.sizeRatio,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/laughing_group.jpg'),
                fit: BoxFit.cover,
                opacity: 0.9,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Fetch-Jokes',
                  style: TextStyle(
                    fontSize: 60 * jokeState.sizeRatio,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'LobsterTwo-Bold',
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(6, 3),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Select the category",
              style: TextStyle(
                fontFamily: 'LobsterTwo-italic',
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
          // Joke Category Dropdown
          JokeCategoryDropdown(jokeState: jokeState),

          // Fetch jokes button
          FetchJokesButton(jokeState: jokeState),

          const SizedBox(height: 20),

          // // Show loading spinner while jokes are loading
          // if (jokeState.isLoading)
          //   const Center(
          //     child: CircularProgressIndicator(),
          //   ),

          // If no jokes fetched
          if (!jokeState.isLoading && jokeState.jokes.isEmpty)
            const Center(
              child: Text(
                "No jokes fetched yet!",
                style:
                    TextStyle(fontFamily: 'Lato-Italic', color: Colors.black87),
              ),
            ),

          // List of jokes or pull-to-refresh area
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                jokeState.fetchJokes(context);
              },
              child: Scrollbar(
                thumbVisibility: true, // Ensure the scrollbar is always visible
                controller: _scrollController, // Use the same ScrollController
                child: ListView.builder(
                  controller: _scrollController, // Assign the ScrollController
                  itemCount: jokeState.jokes.length,
                  itemBuilder: (context, index) {
                    return JokeCard(joke: jokeState.jokes[index]);
                  },
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
