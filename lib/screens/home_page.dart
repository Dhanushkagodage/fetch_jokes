// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/joke_state.dart';
import '../components/fetch_jokes_button.dart';
import '../components/joke_card.dart';

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
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Color(0xFFaaff03),
          title: Text(
            'Fetch-Jokes',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'LobsterTwo-Bold',
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          elevation: 0, // Remove shadow
          automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Welcome to The Fetch Jokes!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Lato-Regular',
                color: Colors.black,
              ),
            ),
            // Top background image
            Container(
              width: double.infinity,
              height: 220,
              decoration: const BoxDecoration(
                
                image: DecorationImage(
                  image: AssetImage('assets/images/emoji.png'),
                  fit: BoxFit.contain,
                  opacity: 0.9,
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FetchJokesButton(jokeState: jokeState),
              ),
            ),

            // FetchJokesButton(jokeState: jokeState),

            const SizedBox(height: 20),

            if (!jokeState.isLoading && jokeState.jokes.isEmpty)
              Expanded(
                // Use Expanded to fill the remaining space
                child: Center(
                  // Center vertically within the Expanded area
                  child: Column(
                    mainAxisSize:
                        MainAxisSize.min, // Center contents vertically
                    children: [
                      Icon(
                        Icons.sentiment_dissatisfied_outlined,
                        size: 70,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "No jokes fetched yet!",
                        style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Lato-Italic',
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // List of jokes or pull-to-refresh area
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  jokeState.fetchJokes(context);
                },
                child: Scrollbar(
                  thumbVisibility:
                      true, // Ensure the scrollbar is always visible
                  controller:
                      _scrollController, // Use the same ScrollController
                  child: ListView.builder(
                    controller:
                        _scrollController, // Assign the ScrollController
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
      ),
    );
  }
}
