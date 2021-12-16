import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/views/movie_details/components/movie_details.dart';
import 'package:movie_task/views/movie_details/controller.dart';

class MovieDetails extends StatelessWidget {
  final int id;

  const MovieDetails({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailsController()..getDetails(id),
      child: Scaffold(
          backgroundColor: Colors.blue[200],
          appBar: AppBar(
            title: const Text('Movie Details'),
          ),
          body: const MovieData()),
    );
  }
}
