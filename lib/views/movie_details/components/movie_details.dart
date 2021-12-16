import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/views/movie_details/controller.dart';
import 'package:movie_task/views/movie_details/states.dart';

class MovieData extends StatelessWidget {
  const MovieData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailsController, DetailsStates>(
      builder: (context, state) => state is DetailsLoadingState
          ? Center(child: const CircularProgressIndicator())
          : Column(
        children: [
          Image.network(
            "https://image.tmdb.org/t/p/w500/" +
                DetailsController.of(context)
                    .detailsModel!
                    .backdropPath,
            height: 400,
          ),
          Center(
              child: Text(
                (DetailsController.of(context).detailsModel!.title),
                style: const TextStyle(fontSize: 25),
              ))
        ],
      ),
    );
  }
}
