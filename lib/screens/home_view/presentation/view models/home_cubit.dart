import 'package:bloc/bloc.dart';
import 'package:bookstore/core/diohelper/dio.dart';
import 'package:bookstore/screens/authentication/presenation/views/widgets/register_view.dart';
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
  SliderModel? model;
  ScrollController scrollController = ScrollController();
  getAllSliders() async {
    emit(HomeLoading());
    try {
      Response response = await DioHelper.getData(endPoint: '/sliders');
      model = SliderModel.fromJson(response.data);
      print(model?.message);
      emit(HomeSuccess());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
      print(e.toString());
      emit(HomeFailure());
    }
  }

  BestSellerModel? bestSellerModel;
  getBestSellers() async {
    emit(HomeBestSellerLoading());
    try {
      Response response =
          await DioHelper.getData(endPoint: '/products-bestseller');
      bestSellerModel = BestSellerModel.fromJson(response.data);
      print(model?.message);
      emit(HomeBestSellerSuccess());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
      print(e.toString());
      emit(HomeBestSellerFailure());
    }
  }

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.book),
      label: 'Books',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border_outlined),
      label: 'favorite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: 'Cart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
  ];
  int selectedIndex = 0;
  BookModel? booksModel;
  int page = 1;
  List<ProductData> books = [];
  int total=0;
  int lastPage=1;
  getAllBooks() async {
    emit(GetAllBooksLoading());
    try {
      Response response =
          await DioHelper.getData(endPoint: '/products?page=$page');
      response.data['data']['products'].map((item) {
        books.add(ProductData.fromJson(item));
      }).toList();
      print(response.data['data']['meta']['total']);
      total=response.data['data']['meta']['total'];
      lastPage=response.data['data']['meta']['last_page'];
      print(books.length);
      print(lastPage);
      // booksModel = BookModel.fromJson(response.data);
      // print(model?.message);

      emit(GetAllBooksSuccess());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
      print(e.toString());
      emit(GetAllBooksFailure());
    }
  }

  bool isLoadMore = false;
  getMoreData() {
    scrollController.addListener(() async {
      if (page == lastPage) {
        return;
      } else if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoadMore = true;
        if (page <= lastPage) {
          page++;
          await getAllBooks();
        }
      }
      isLoadMore = false;
    });
  }

  changeIndex(value) {
    selectedIndex = value;
    emit(HomeChangeIndexSuccess());
  }

  List<Widget> views = const [
    HomeViewBody(),
    BooksView(),
    FavoriteView(),
    CartView(),
    ProfileView()
  ];
  CategoriesModel? categoriesModel;
  getAllCategories() async {
    emit(GetAllCategoriesLoading());
    try {
      Response response = await DioHelper.getData(endPoint: '/categories');
      categoriesModel = CategoriesModel.fromJson(response.data);
      emit(GetAllCategoriesSuccess());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
      emit(GetAllCategoriesFailure());
    }
  }

  BestSellerModel? newArrivalsModel;
  getNewArrivals() async {
    emit(GetNewArrivalsLoading());
    try {
      Response response =
          await DioHelper.getData(endPoint: '/products-new-arrivals');
      newArrivalsModel = BestSellerModel.fromJson(response.data);
      emit(GetNewArrivalsSuccess());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
      emit(GetNewArrivalsFailure());
    }
  }

  BestSellerModel? searchModel;
  TextEditingController searchController = TextEditingController();
  searchForProduct(context) async {
    try {
      emit(SearchLoading());
      Response response = await DioHelper.getData(
          endPoint: '/products-search?name=${searchController.text}');
      searchModel = BestSellerModel.fromJson(response.data);
      print(searchModel?.message);
      emit(SearchSuccess());
      searchController.clear();
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
      print(e.toString());
      emit(SearchFailed());
    }
  }
  logOut(context)async
  {
    try {
      Response response=await DioHelper.postData(endPoint: '/logout');
      print(response.data['message']);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterView()));
      emit(LogOutSuccessfully());
    } on Exception catch (e)
    {
      print(e.toString());
      emit(LogOutFailed());
    }
  }
}
