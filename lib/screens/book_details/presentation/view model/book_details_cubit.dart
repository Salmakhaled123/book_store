import 'package:bloc/bloc.dart';
import 'package:bookstore/core/diohelper/dio.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
part 'book_details_state.dart';

class BookDetailsCubit extends Cubit<BookDetailsState>
{
  BookDetailsCubit() : super(BookDetailsInitial());
  showBookDetails(id)async
  {
    try {
      Response response=await DioHelper.getData(endPoint: '/products/$id');
      print(response.data);
      emit(ShowProductSuccess());
    } on Exception catch (e) {
      if( e is DioException)
        {
          print(e.response?.data);
        }
      print(e.toString());
      emit(ShowProductFailed());

    }


  }
}
