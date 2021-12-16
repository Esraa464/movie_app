import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_task/views/movie_details/model.dart';
import 'package:movie_task/views/movie_details/states.dart';

class DetailsController extends Cubit<DetailsStates> {
  DetailsController() : super(DetailsInitialState());

  static DetailsController of(context) => BlocProvider.of(context);
  // Dio? dio;
  DetailsModel? detailsModel;

  Future<void> getDetails(int id) async {
    emit(DetailsLoadingState());
    try {
      var response = await Dio().get(
          'https://api.themoviedb.org/3/movie/$id?api_key=d98aa27d88f3cdb976e11e13b93a9def');
      detailsModel = DetailsModel.fromJson(response.data);
      print(response.data);
    } catch (e, s) {
      print(e);
      print(s);
    }
    emit(DetailsInitialState());
  }
}
