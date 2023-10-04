part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeSuccess extends HomeState {}
class HomeFailure extends HomeState {}
class HomeBestSellerLoading extends HomeState {}
class HomeBestSellerSuccess extends HomeState {}
class HomeBestSellerFailure extends HomeState {}
class HomeChangeIndexSuccess extends HomeState{}
class GetAllBooksSuccess extends HomeState{}
class GetAllBooksFailure extends HomeState{}
class GetAllBooksLoading extends HomeState{}
class GetAllCategoriesSuccess extends HomeState{}
class GetAllCategoriesFailure extends HomeState{}
class GetAllCategoriesLoading extends HomeState{}
class GetNewArrivalsSuccess extends HomeState{}
class GetNewArrivalsFailure extends HomeState{}
class GetNewArrivalsLoading extends HomeState{}
class MoreDataLoadedSuccessfully extends HomeState{}
class SearchLoading extends HomeState{}
class SearchSuccess extends HomeState{}
class SearchFailed extends HomeState{}
class LogOutSuccessfully extends HomeState{}
class LogOutFailed extends HomeState{}




