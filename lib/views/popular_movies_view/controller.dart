import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/views/homeScreen/model.dart';
import 'package:movie_task/views/popular_movies_view/states.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeController extends Cubit<HomeStates> {
  HomeController() : super(InitialState());

  static HomeController of(context) => BlocProvider.of(context);
  MovieModel? movieModel;
  List<Results>? movies = [];
  List<Results>? newMovies = [];
  var refreshController = RefreshController();
  var pageNumber = 1;

  Future<void> getData() async {
    movies!.clear();
    emit(HomeLoadingState());
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/popular?api_key=d98aa27d88f3cdb976e11e13b93a9def&page=$pageNumber');
      movieModel = MovieModel.fromJson(response.data);
      print(response.data);
      newMovies = movieModel!.results;
      movies!.addAll(newMovies!);
      print('movies length=  ' + movies!.length.toString());
      print('new movies length=  ' + newMovies!.length.toString());
    } catch (e, s) {
      print(e);
      print(s);
    }
    emit(InitialState());
  }

  refresh() {
    pageNumber = 1;
    movies!.clear();
    getData();
    refreshController
        .refreshCompleted(); //if this is don't exist the refresh icon will continue to appear.
    emit(GetMoviesRefreshState());
  }

  loading() {
    pageNumber++;
    getData();
    refreshController.loadComplete();
    emit(HomeLoadingState());
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
      emit(InternetState());
    });
  }
}
