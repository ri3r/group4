import 'package:flutter/material.dart';

import 'movie.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (movie.poster.isNotEmpty)
              Center(
                child: Image.network(
                  movie.poster,
                  height: 300,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            const SizedBox(height: 16),
            _DetailRow(label: 'Director', value: movie.director),
            _DetailRow(label: 'Actors', value: movie.actors),
            _DetailRow(label: 'Genre', value: movie.genre),
            _DetailRow(label: 'IMDb Rating', value: movie.imdbRating),
            const SizedBox(height: 8),
            Text('Plot', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(movie.plot),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
