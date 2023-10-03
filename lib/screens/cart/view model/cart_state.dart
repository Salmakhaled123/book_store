part of 'cart_cubit.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}
class AddedToCartSuccessfully extends CartState {}
class AddedToCartFailed extends CartState {}
class RemoveFromCartSuccessfully extends CartState {}
class RemoveFromCartFailed extends CartState {}
class ShowCartSuccessfully extends CartState {}
class ShowCartFailed extends CartState {}
class UpdatedCartSuccessfully extends CartState {}
class UpdatedCartFailed extends CartState {}
class IncrementedSuccessfully extends CartState {}
class DecrementedSuccessfully extends CartState {}
class QuantityUpdated extends CartState{}
class CheckOutSuccessfully extends CartState {}
class CheckOutFailed extends CartState {}
class PlaceOrderFailed extends CartState {}
class PLaceOrderSuccessfully extends CartState {}
