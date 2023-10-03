import 'package:bloc/bloc.dart';
import 'package:bookstore/core/diohelper/dio.dart';
import 'package:bookstore/screens/favorite/model/favorite_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  FavoriteModel ?favoriteModel;
  Set<dynamic>favorites={};
  showWishList()async
  {
    try {
      Response response=await DioHelper.getData(endPoint: '/wishlist');
      favoriteModel=FavoriteModel.fromJson(response.data);
      print('show wishlist successfully');
      if(favoriteModel!.data.data.isNotEmpty)
        {
          for(int i=0;i<favoriteModel!.data.data.length;i++)
          {
            favorites.add(favoriteModel?.data.data[i].id);
          }
        }
       print(favorites.length);
       print(favorites);
      emit(ShowWishListSuccessFully());
    } on Exception catch (e) {
      if(e is DioException)
        {
          print(e.response?.data);
        }
      print(e.toString());
      emit(ShowWishListFailed());
    }

  }
  addToWishList(productId,context)async
  {
    try {
      Response response=await DioHelper.postData(endPoint: '/add-to-wishlist',
          data: {
        'product_id':productId,
      });
      favorites.add(productId);
      // if(!favorites.contains(productId))
      //   {
      //
      //   }
      print(favorites);
      print(response.data['message']);
      showWishList();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response.data['message']}')));
      emit(AddToWishListSuccessFully());
    } on Exception catch (e) 
    {
      print(e.toString());
      emit(AddToWishListFailed());
    }
  }
  removeFromWishList(productId,context)async
  {
    try {
      Response response=await DioHelper.postData(endPoint: '/remove-from-wishlist',
          data: {
            'product_id':productId,
          });
      favorites.remove(productId);
      print(response.data['message']);
      showWishList();
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${response.data['message']}')));
      emit(RemoveFromWishListSuccessFully());
    } on Exception catch (e)
    {
      print(e.toString());
      emit(RemoveFromWishListFailed());
    }
  }
}
