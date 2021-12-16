import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/views/homeScreen/model.dart';
import 'package:movie_task/views/top_movies/states.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopController extends Cubit<TopStates> {
  TopController() : super(TopInitialState());

  static TopController of(context) => BlocProvider.of(context);
  MovieModel? topModel;
  List<Results>? movies = [];
  List<Results>? newMovies = [];
  var refreshController = RefreshController();
  var pageNumber = 1;

  Future<void> getData() async {
    // emit(TopLoadingState());
    try {
      newMovies!.clear();
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=d98aa27d88f3cdb976e11e13b93a9def&page=$pageNumber');
      // Print(response.data);
      topModel = MovieModel.fromJson(response.data);
      newMovies = topModel!.results;
      movies!.addAll(newMovies!);
      print('new movies length=  ' + newMovies!.length.toString());
      print('movies length=  ' + movies!.length.toString());
    } catch (e, s) {
      print(e);
      print(s);
    }
    emit(TopInitialState());
  }

  refresh() {
    pageNumber = 1;
    movies!.clear();
    getData();
    refreshController.refreshCompleted();
    emit(GetTopMoviesRefreshState());
  }

  loading() {
    pageNumber++;
    getData();
    refreshController.loadComplete();
    emit(TopLoadingState());
  }

  bool isOnline = false;

  getInternetConnection() {
    Connectivity c = Connectivity();
    var stream = c.onConnectivityChanged;
    stream.listen((ConnectivityResult event) {
      if (event == ConnectivityResult.none) {
        print("no internet");
        isOnline = false;
      } else if (event == ConnectivityResult.mobile) {
        print("internet with data");
        isOnline = true;
      } else {
        print("internet with wifi");
        isOnline = true;
      }
      emit(TopInternetState());
    });
  }
}
