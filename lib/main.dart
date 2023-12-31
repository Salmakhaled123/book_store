import 'package:bookstore/core/cacheHelper/cacheHelper.dart';
import 'package:bookstore/core/diohelper/dio.dart';
import 'package:bookstore/screens/authentication/view%20model/login_register_cubit.dart';
import 'package:bookstore/screens/book_details/presentation/view%20model/book_details_cubit.dart';
import 'package:bookstore/screens/cart/view%20model/cart_cubit.dart';
import 'package:bookstore/screens/favorite/view%20model/favorite_cubit.dart';
import 'package:bookstore/screens/home_view/presentation/view%20models/home_cubit.dart';
import 'package:bookstore/screens/profile/view%20model/profile_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/appcolors/colors.dart';
import 'core/bloc_observer.dart';
import 'screens/splash_view/presentation/views/splashView.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await CacheHelper.init();
  Bloc.observer=MyObserver();
  SystemChrome.setSystemUIOverlayStyle(const
  SystemUiOverlayStyle(statusBarColor: AppColors.primaryColor));
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MultiBlocProvider(providers: [
          BlocProvider(
            create: (context) => LoginRegisterCubit(),
          ),
          BlocProvider(
            create: (context) => CartCubit()..showCart(),
          ),
          BlocProvider(
            create: (context) => FavoriteCubit()..showWishList(),
          ),
          BlocProvider(
            create: (context) => BookDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => ProfileCubit()..getGovernorates(),
          ),
          BlocProvider(
            create: (context) => HomeCubit()..getAllSliders()..
            getBestSellers()..getAllBooks()..getAllCategories()..getNewArrivals(),
          ),
        ],
          child: MaterialApp(
            theme: ThemeData(primarySwatch: Colors.deepPurple),
            debugShowCheckedModeBanner: false,
            title: 'Book Store',
            home: child,
          ),
        );
      },
      child: const SplashView(),
    );
  }
}

