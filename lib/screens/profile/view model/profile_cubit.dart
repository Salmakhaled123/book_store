import 'package:bloc/bloc.dart';
import 'package:bookstore/core/diohelper/dio.dart';
import 'package:bookstore/screens/profile/model/governorate_model.dart';
import 'package:bookstore/screens/profile/model/profile_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  ProfileModel ? model;
  TextEditingController nameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController phoneController=TextEditingController();
  TextEditingController cityController=TextEditingController();
  TextEditingController addressController=TextEditingController();

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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

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

}
