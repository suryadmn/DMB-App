import 'package:flutter/material.dart';

class DetailMoviePage extends StatefulWidget {
  const DetailMoviePage({super.key});

  @override
  State<DetailMoviePage> createState() => _DetailMoviePageState();
}

class _DetailMoviePageState extends State<DetailMoviePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Movie',
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: true,
      ),
    );
  }
}
