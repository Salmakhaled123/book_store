import 'package:bloc/bloc.dart';
import 'package:bookstore/core/appImages/images.dart';
import 'package:bookstore/core/navigation/navigation.dart';
import 'package:bookstore/screens/authentication/model/register_model.dart';
import 'package:bookstore/screens/home_view/presentation/view%20models/home_cubit.dart';
import 'package:bookstore/screens/on_boardiing_view/data/onboardingModel.dart';
import 'package:bookstore/screens/on_boardiing_view/presentation/views/on%20boarding%20view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/cacheHelper/cacheHelper.dart';
import '../../../core/diohelper/dio.dart';
import '../../home_view/presentation/views/home_view.dart';
import '../../profile/view model/profile_cubit.dart';

part 'login_register_state.dart';

class LoginRegisterCubit extends Cubit<LoginRegisterState> {
  LoginRegisterCubit() : super(LoginRegisterInitial());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  var formKey2 = GlobalKey<FormState>();
  UserDataModel? model;
  Future userRegister(context) async {
    emit(LoginRegisterLoading());
    try {
      Response response =
          await DioHelper.postData(endPoint: '/register', data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
        'password_confirmation': confirmController.text
      });
      print(response.data);
      model = UserDataModel.fromJson(response.data);
      print(model?.data.user.emailVerified);
      await CacheHelper.saveData(key: 'name', value: model?.data.user.name);
      await CacheHelper.saveData(
          key: 'token', value: response.data['data']['token']);
      print(CacheHelper.getData(key: 'token'));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data['message']}')));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeView()));
      BlocProvider.of<ProfileCubit>(context).showProfile();
      emit(LoginRegisterSuccess());
      nameController.clear();
      emailController.clear();
      passwordController.clear();
      confirmController.clear();

    } on Exception catch (e) {
      if (e is DioException) {
        //  registerFailureModel = RegisterFailureModel.fromJson(e.response!.data);
        final data = e.response?.data;
        print(data);
        print(data['message']);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${e.response?.data}')));
      }
      print(e.toString());

      emit(LoginRegisterFailure());
    }
  }
  Future userLogin(context) async {
    emit(LoginLoading());
    try {
      Response response = await DioHelper.postData(endPoint: '/login', data: {
        'email': emailController.text,
        'password': passwordController.text
      });
      model = UserDataModel.fromJson(response.data);
      print(model?.data.user.emailVerified);
     await CacheHelper.saveData(key: 'token', value: model?.data.token);
      print(response.data['message']);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data['message']}')));
      Navigator.push(context, MaterialPageRoute(builder: (context)=>const HomeView()));
      BlocProvider.of<ProfileCubit>(context).showProfile();

      emit(LoginSuccess());
    } on Exception catch (e) {
      print(e.toString());
      emit(LoginFailure());
    }
  }
  bool suffix = false;
  bool suffixConfirmPass=false;
  changeVisibilityConfirmPassword()
  {
    suffixConfirmPass=!suffixConfirmPass;
    emit(CheckVisibility());
  }
  changeVisibility() {
    suffix = !suffix;
    emit(CheckVisibility());
  }

  String? otpCode;
  verifyEmail(context) async {
    try {
      Response response =
          await DioHelper.postData(endPoint: '/verify-email', data: {
        'verify_code': otpCode,
      });
      print(response.data['message']);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${response.data['message']}')));
      emit(VerifiedSuccessfully());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));

      emit(VerifiedFailed());
    }
  }

  navigateToOnBoarding(context)
  {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
            const OnBoardingView()));
      },
    );
  }

  List<OnBoardingModel> onBoarding = [
    OnBoardingModel(
        text: 'Let\'s Discover New Books', image: AppImages.onBoarding1),
    OnBoardingModel(
        text: 'You can buy many books', image: AppImages.onBoarding2),
    OnBoardingModel(
        text: 'There are books in many fields', image: AppImages.onBoarding3),
  ];
  int currentIndex = 0;
  PageController pageController = PageController();
  changeIndex(int value) {
    currentIndex = value;
    emit(ChangeIndexSuccess());
  }
}
