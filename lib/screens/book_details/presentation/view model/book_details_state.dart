part of 'book_details_cubit.dart';

@immutable
abstract class BookDetailsState {}

class BookDetailsInitial extends BookDetailsState {}
class ShowProductSuccess extends BookDetailsState {}
class ShowProductFailed extends BookDetailsState {}

