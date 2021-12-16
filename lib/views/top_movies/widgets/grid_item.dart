import 'package:flutter/material.dart';
import 'package:movie_task/views/homeScreen/model.dart';
import 'package:movie_task/views/movie_details/view.dart';
import 'package:movie_task/views/top_movies/controller.dart';

class GridItem extends StatelessWidget {
  final int index;
  final List<Results> movies;

  const GridItem(
      {Key? key, required this.index, required this.movies})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetails(
              id: movies[index].id,
            ),
          )),
      child: GridTile(
        child: Image.network(
          movies[index].posterPath == null
              ? "https://th.bing.com/th/id/R.a7458095c4173dd63fad59aaeffca73b?rik=YVRpJndzARmcVQ&pid=ImgRaw&r=0"
              : "https://image.tmdb.org/t/p/w500/" + movies[index].backdropPath,
          fit: BoxFit.fill,
        ),
        footer: Container(
          height: 40,
          color: Colors.red.withOpacity(.5),
          child: Text(
            movies[index].title,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    ));
  }
}
