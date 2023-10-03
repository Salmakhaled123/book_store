part of 'favorite_cubit.dart';

@immutable
abstract class FavoriteState {}

class FavoriteInitial extends FavoriteState {}
class ShowWishListSuccessFully extends FavoriteState {}
class ShowWishListFailed extends FavoriteState {}
class AddToWishListSuccessFully extends FavoriteState {}
class AddToWishListFailed extends FavoriteState {}
class RemoveFromWishListSuccessFully extends FavoriteState {}
class RemoveFromWishListFailed extends FavoriteState {}