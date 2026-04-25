import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'database_helper.dart';
import 'movie.dart';
import 'movie_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(
        title: 'Movies',
        movieUri:
            'https://git.fiw.fhws.de/introduction-to-flutter-2025ss/unit-07-http-and-bloc/-/raw/329759b27023c59828215b51dd081b58c5c07d50/http_demo/movie_data.json',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.movieUri});

  final String title;
  final String movieUri;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> _movies = [];
  bool _isLoading = false;
  final _searchController = TextEditingController();
  final _db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    _loadAndShow();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadAndShow() async {
    setState(() => _isLoading = true);
    final dbCount = await _db.count();
    if (dbCount == 0) {
      final fetched = await _loadMovies();
      if (fetched.isNotEmpty) {
        await _db.insertMovies(fetched);
      }
    }
    final stored = await _db.getAllMovies();
    setState(() {
      _movies = stored;
      _isLoading = false;
    });
  }

  Future<List<Movie>> _loadMovies() async {
    try {
      final response = await http.get(Uri.parse(widget.movieUri));
      if (response.statusCode == 200) {
        final movies = jsonDecode(response.body) as List;
        return movies
            .map((e) => Movie.fromJson(e as Map<String, dynamic>))
            .toList();
      }
    } catch (_) {}
    return [];
  }

  void _onSearchChanged(String query) async {
    final results = query.isEmpty
        ? await _db.getAllMovies()
        : await _db.searchByTitle(query);
    setState(() => _movies = results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search movies…',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _movies.length,
              itemBuilder: (context, index) {
                final movie = _movies[index];
                return ListTile(
                  leading: movie.poster.isNotEmpty
                      ? Image.network(
                          movie.poster,
                          width: 40,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              const Icon(Icons.movie),
                        )
                      : const Icon(Icons.movie),
                  title: Text(movie.title),
                  subtitle: Text(movie.director),
                  trailing: Text(
                    movie.imdbRating.isNotEmpty ? '★ ${movie.imdbRating}' : '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailScreen(movie: movie),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
