import 'package:bloc/bloc.dart';
import 'package:bookstore/core/diohelper/dio.dart';
import 'package:bookstore/screens/cart/data/cart_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  CartModel? cartModel;
  addToCart(productId, context) async {
    try {
      Response response =
          await DioHelper.postData(endPoint: '/add-to-cart', data: {
        'product_id': productId,
      });
      cartModel = CartModel.fromJson(response.data);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${cartModel?.message}'),
      ));
      emit(AddedToCartSuccessfully());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${e.message}'),
        ));
      }
      emit(AddedToCartFailed());
    }
  }
  showCart() async {
    try {
      Response response =
      await DioHelper.getData(endPoint: '/cart',);
      cartModel = CartModel.fromJson(response.data);
      emit(ShowCartSuccessfully());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);

      }
      emit(ShowCartFailed());
    }
  }
  String ?total;
  removeFromCart(cartItemId, context) async {
    try {
      Response response =
      await DioHelper.postData(endPoint: '/remove-from-cart', data: {
        'cart_item_id': cartItemId,
      });
      cartModel = CartModel.fromJson(response.data);

      emit(RemoveFromCartSuccessfully());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
      emit(RemoveFromCartFailed());
    }
  }
int quantity=1;
  updateQuantity(newQuantity)
  {
    quantity=newQuantity;
    emit(QuantityUpdated());
  }
  void increment()
  {
    quantity++;
    emit(IncrementedSuccessfully());
  }
  void decrement()
  {
        quantity--;
    emit(DecrementedSuccessfully());
  }
  updateCart(cartItemId, context,) async {
    try {
      Response response =
      await DioHelper.postData(endPoint: '/update-cart', data: {
        'cart_item_id': cartItemId,
        'quantity':quantity
      });
      cartModel = CartModel.fromJson(response.data);
      total=double.parse(cartModel?.data.total).toStringAsFixed(2);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${cartModel?.message}'),
      ));
      emit(UpdatedCartSuccessfully());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${e.response?.data['errors']['quantity'][0]}'),
        ));

      }
      emit(UpdatedCartFailed());
    }
  }
  CartModel ?checkOutCart;
  checkout()async
  {
    try {
      Response response=await DioHelper.getData(endPoint: '/checkout');
      checkOutCart =CartModel.fromJson(response.data);

      emit(CheckOutSuccessfully());
    } on Exception catch (e) {

      if(e is DioException)
      {
        print(e.response?.data);
      }
      print(e.toString());
      emit(CheckOutFailed());
    }

  }




}
