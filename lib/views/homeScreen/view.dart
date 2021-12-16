import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/views/popular_movies_view/view.dart';
import 'package:movie_task/views/popular_movies_view/controller.dart';
import 'package:movie_task/views/top_movies/controller.dart';
import 'package:movie_task/views/top_movies/view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => HomeController()..getData(),
          ),
          BlocProvider(
            create: (BuildContext context) => TopController()..getData(),
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Movie App'),
            bottom: const TabBar(tabs: [
              Tab(
                text: 'Top Movies',
              ),
              Tab(
                text: 'Popular',
              ),
              // Tab(
              //   text: 'Now Playing',
              // ),
            ]),
          ),
          body: TabBarView(
            children: [
              TopMovies(),
              PopularMovies(),
              // Text('3'),
            ],
          ),
        ),
      ),
    );
  }
}

///https://api.themoviedb.org/3/movie/550?api_key=d98aa27d88f3cdb976e11e13b93a9def
