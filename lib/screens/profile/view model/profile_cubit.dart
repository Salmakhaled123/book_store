import 'package:bloc/bloc.dart';
import 'package:bookstore/core/cacheHelper/cacheHelper.dart';
import 'package:bookstore/core/diohelper/dio.dart';
import 'package:bookstore/screens/profile/model/governorate_model.dart';
import 'package:bookstore/screens/profile/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../cart/data/cart_model.dart';
import '../../cart/view model/cart_cubit.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState>
{
  ProfileCubit() : super(ProfileInitial());
  ProfileModel ? model;
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController addressController=TextEditingController();
 var formKey3=GlobalKey<FormState>();
  showProfile()async
  {
    try {
      Response response=await DioHelper.getData(endPoint: '/profile');
      model=ProfileModel.fromJson(response.data);
      print(response.data);
      emit(ShowProfileSuccess());
    } on Exception catch (e)
    {
     if(e is DioException)
       {
         print(e.response?.data);
       }
     print(e.toString());
     emit(ShowProfileFailed());
    }


  }
  updateProfile(context)async
  {
    try {
      Response response=await DioHelper.postData(
          endPoint: '/update-profile',data: {
        'name':nameController.text,
        'email':emailController.text,
        'phone':phoneController.text,
        'address':addressController.text,
        'city':newValue
      });
      await CacheHelper.saveData(key: 'name', value: nameController.text);
      model=ProfileModel.fromJson(response.data);
      print(response.data);
     ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text('${response.data['message']}')));
      emit(UpdateProfileSuccess());

    } on Exception catch (e)
    {
      if(e is DioException)
      {
        print(e.response?.data);
      }
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('name is required')));

      emit(UpdateProfileFailed());
    }

  }
   String? newValue;
  GovernorateModel ?governorateModel;
  getGovernorates()async
  {

    try {
      Response response=await DioHelper.getData(endPoint: '/governorates');
      governorateModel=GovernorateModel.fromJson(response.data);
      print(governorateModel?.data.length);
      emit(GovernoratesGetSuccessfully());
    } on Exception catch (e) {

      if(e is DioException)
      {
        print(e.response?.data);
      }
      print(e.toString());
      emit(GovernoratesGetFailed());
    }

  }
  changeCity(value)
  {
    newValue=value;
    cityController.text=newValue??'';
    emit(ChangeCitySuccessfully());
  }
  CartModel ?orderModel;
  placeOrder(context) async {
    try {
      Response response =
      await DioHelper.postData(endPoint: '/place-order', data: {
        'name':nameController.text,
        'email':emailController.text,
        'phone':phoneController.text,
        'address':addressController.text,
        'city':cityController.text,
        'governorate_id':id,
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.data['message']}'),
      ));
      BlocProvider.of<CartCubit>(context).showCart();
      emit(PLaceOrderSuccessfully());
    } on Exception catch (e) {
      if (e is DioException) {
        print(e.response?.data);

      }
      emit(PlaceOrderFailed());
    }
  }
  int ?id;

}
