import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/views/top_movies/controller.dart';
import 'package:movie_task/views/top_movies/states.dart';
import 'package:movie_task/views/top_movies/widgets/grid_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopMovies extends StatelessWidget {
  const TopMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = TopController.of(context);

    return BlocBuilder<TopController, TopStates>(
        builder: (context, state) => Padding(
              padding: const EdgeInsets.all(20),
              child: controller.movies!.isNotEmpty
                  ? SmartRefresher(
                      enablePullUp: true,
                      controller: controller.refreshController,
                      onRefresh: controller.refresh,
                      onLoading: controller.loading,
                      child: controller.movies!.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : GridView.count(
                              crossAxisCount: 2,
                              // scrollDirection: Axis.vertical,
                              children: List.generate(
                                  controller.movies!.length,
                                  (index) => GridItem(
                                        index: index,
                                        movies: controller.movies!,
                                      )),
                            ),
                    )
                  : const Center(child: CircularProgressIndicator()),
            ));
  }
}
