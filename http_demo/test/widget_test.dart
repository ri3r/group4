import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http_demo/movie.dart';
import 'package:http_demo/movie_detail_screen.dart';

// ---------------------------------------------------------------------------
// Movie model tests
// ---------------------------------------------------------------------------

void main() {
  group('Movie.fromJson', () {
    test('parses all fields correctly', () {
      final json = {
        'Title': 'Avatar',
        'Director': 'James Cameron',
        'Actors': 'Sam Worthington, Zoe Saldana',
        'Genre': 'Action, Adventure, Fantasy',
        'Plot': 'A marine goes to Pandora.',
        'Poster': 'http://example.com/avatar.jpg',
        'imdbRating': '7.9',
      };

      final movie = Movie.fromJson(json);

      expect(movie.title, 'Avatar');
      expect(movie.director, 'James Cameron');
      expect(movie.actors, 'Sam Worthington, Zoe Saldana');
      expect(movie.genre, 'Action, Adventure, Fantasy');
      expect(movie.plot, 'A marine goes to Pandora.');
      expect(movie.poster, 'http://example.com/avatar.jpg');
      expect(movie.imdbRating, '7.9');
    });

    test('uses empty string for missing optional fields', () {
      final movie = Movie.fromJson({'Title': 'Unknown', 'Director': 'Nobody'});

      expect(movie.actors, '');
      expect(movie.genre, '');
      expect(movie.plot, '');
      expect(movie.poster, '');
      expect(movie.imdbRating, '');
    });
  });

  group('Movie.toJson', () {
    test('serialises all fields to the correct keys', () {
      final movie = Movie(
        title: 'Interstellar',
        director: 'Christopher Nolan',
        actors: 'Matthew McConaughey',
        genre: 'Sci-Fi',
        plot: 'A crew travels through a wormhole.',
        poster: 'http://example.com/interstellar.jpg',
        imdbRating: '8.6',
      );

      final json = movie.toJson();

      expect(json['Title'], 'Interstellar');
      expect(json['Director'], 'Christopher Nolan');
      expect(json['Actors'], 'Matthew McConaughey');
      expect(json['Genre'], 'Sci-Fi');
      expect(json['Plot'], 'A crew travels through a wormhole.');
      expect(json['Poster'], 'http://example.com/interstellar.jpg');
      expect(json['imdbRating'], '8.6');
    });

    test('round-trips through fromJson -> toJson', () {
      final original = {
        'Title': 'Avatar',
        'Director': 'James Cameron',
        'Actors': 'Sam Worthington',
        'Genre': 'Action',
        'Plot': 'Marines on Pandora.',
        'Poster': 'http://example.com/avatar.jpg',
        'imdbRating': '7.9',
      };

      final json = Movie.fromJson(original).toJson();

      expect(json, equals(original));
    });
  });

  // -------------------------------------------------------------------------
  // Navigation tests
  // -------------------------------------------------------------------------

  group('Navigation', () {
    final testMovie = Movie(
      title: 'The Avengers',
      director: 'Joss Whedon',
      actors: 'Robert Downey Jr.',
      genre: 'Action',
      plot: 'Heroes assemble.',
      poster: '',
      imdbRating: '8.1',
    );

    testWidgets('tapping a ListTile navigates to MovieDetailScreen',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                ListTile(
                  title: Text(testMovie.title),
                  onTap: () => Navigator.push(
                    tester.element(find.byType(ListTile)),
                    MaterialPageRoute(
                      builder: (_) => MovieDetailScreen(movie: testMovie),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailScreen), findsOneWidget);
      expect(find.text('The Avengers'), findsWidgets);
    });

    testWidgets('MovieDetailScreen displays movie fields', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: MovieDetailScreen(movie: testMovie)),
      );

      expect(find.text('The Avengers'), findsWidgets);
      expect(find.textContaining('Joss Whedon'), findsOneWidget);
      expect(find.textContaining('Robert Downey Jr.'), findsOneWidget);
      expect(find.textContaining('Action'), findsOneWidget);
      expect(find.textContaining('Heroes assemble.'), findsOneWidget);
      expect(find.textContaining('8.1'), findsOneWidget);
    });

    testWidgets('back button returns to previous screen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(title: const Text('Home')),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Navigator.push(
                  ctx,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailScreen(movie: testMovie),
                  ),
                ),
                child: const Text('Go to Detail'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Go to Detail'));
      await tester.pumpAndSettle();
      expect(find.byType(MovieDetailScreen), findsOneWidget);

      final backButton = find.byType(BackButton);
      await tester.tap(backButton);
      await tester.pumpAndSettle();

      expect(find.text('Home'), findsOneWidget);
      expect(find.byType(MovieDetailScreen), findsNothing);
    });
  });
}
