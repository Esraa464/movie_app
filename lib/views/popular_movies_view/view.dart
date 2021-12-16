import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/views/movie_details/view.dart';
import 'package:movie_task/views/popular_movies_view/controller.dart';
import 'package:movie_task/views/popular_movies_view/states.dart';

class PopularMovies extends StatelessWidget {
  const PopularMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = HomeController.of(context).movieModel;
    return BlocBuilder<HomeController, HomeStates>(
      builder: (context, state) => state is HomeLoadingState
          ? const Center(child: Center(child: CircularProgressIndicator()))
          : HomeController.of(context).movieModel == null
              ? const Text('No result')
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      height: 1,
                    ),
                    itemCount:
                        HomeController.of(context).movieModel!.results.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetails(
                                id: HomeController.of(context).movies![index].id,

                                // HomeController.of(context)
                                //     .movieModel!
                                //     .results[index]
                                //     .id,
                              ),
                            )),
                        child: Container(
                          color: Colors.orangeAccent,
                          child: Column(
                            children: [
                              Image.network("https://image.tmdb.org/t/p/w500/" +
                                  HomeController.of(context)
                                      .movieModel!
                                      .results[index]
                                      .posterPath),
                              Center(
                                  child: Text(
                                HomeController.of(context)
                                    .movieModel!
                                    .results[index]
                                    .title,
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.blue),
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
