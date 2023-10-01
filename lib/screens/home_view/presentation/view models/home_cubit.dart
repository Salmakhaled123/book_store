import 'package:bloc/bloc.dart';
import 'package:bookstore/core/diohelper/dio.dart';
import 'package:bookstore/screens/books/view/books_view.dart';
import 'package:bookstore/screens/cart/view/cart_view.dart';
import 'package:bookstore/screens/favorite/view/favorite%20view.dart';
import 'package:bookstore/screens/home_view/data/best_seller_model.dart';
import 'package:bookstore/screens/home_view/data/book_model.dart';
import 'package:bookstore/screens/home_view/data/categoriesmodel.dart';
import 'package:bookstore/screens/home_view/data/slider_model.dart';
import 'package:bookstore/screens/home_view/presentation/views/widgets/home_view_body.dart';
import 'package:bookstore/screens/profile/view/profile_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  SliderModel ?model;
  getAllSliders()async
  {
    emit(HomeLoading());
    try {
      Response response=await DioHelper.getData(endPoint: '/sliders');
      model=SliderModel.fromJson(response.data);
      print(model?.message);
      emit(HomeSuccess());
    } on Exception catch (e) {
      if(e is DioException)
        {
          print(e.response?.data);
        }
      print(e.toString());
      emit(HomeFailure());
    }

  }
  BestSellerModel ?bestSellerModel;
  getBestSellers()async
  {
    emit(HomeBestSellerLoading());
    try {
      Response response=await DioHelper.getData(endPoint: '/products-bestseller');
      bestSellerModel=BestSellerModel.fromJson(response.data);
      print(model?.message);
      emit(HomeBestSellerSuccess());
    } on Exception catch (e) {
      if(e is DioException)
      {
        print(e.response?.data);
      }
      print(e.toString());
      emit(HomeBestSellerFailure());
    }

  }
  List<BottomNavigationBarItem>items=[
    const BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
    const BottomNavigationBarItem(icon: Icon(Icons.book),label: 'Books',),
    const BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined),label: 'favorite',),
    const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart',),
    const BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile',),


  ];
  int selectedIndex=0;
  BookModel ?booksModel;

  getAllBooks()async
  {

    emit(GetAllBooksLoading());
    try {
      Response response=await DioHelper.getData(endPoint: '/products');
      booksModel=BookModel.fromJson(response.data);
      print(model?.message);

      emit(GetAllBooksSuccess());
    } on Exception catch (e) {
      if(e is DioException)
      {
        print(e.response?.data);
      }
      print(e.toString());
      emit(GetAllBooksFailure());
    }

  }
  changeIndex(value)
  {
    selectedIndex=value;
    emit(HomeChangeIndexSuccess());
  }
  List<Widget>views=const [
    HomeViewBody(),
    BooksView(),
    FavoriteView(),
    CartView(),
    ProfileView()
  ];
  CategoriesModel ?categoriesModel;
  getAllCategories()async
  {
    emit(GetAllCategoriesLoading());
    try {
      Response response=await DioHelper.getData(endPoint: '/categories');
      categoriesModel=CategoriesModel.fromJson(response.data);
      emit(GetAllCategoriesSuccess());
    } on Exception catch (e) {
      if(e is DioException)
        {
          print(e.response?.data);
        }
      emit(GetAllCategoriesFailure());

    }
  }
  BestSellerModel ?newArrivalsModel;
  getNewArrivals()async
  {
    emit(GetNewArrivalsLoading());
    try {
      Response response=await DioHelper.getData(endPoint: '/products-new-arrivals');
      newArrivalsModel=BestSellerModel.fromJson(response.data);
      emit(GetNewArrivalsSuccess());
    } on Exception catch (e) {
      if(e is DioException)
      {
        print(e.response?.data);
      }
      emit(GetNewArrivalsFailure());

    }
  }
  

}
