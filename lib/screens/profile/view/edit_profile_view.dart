import 'package:bookstore/core/appfont/styles.dart';
import 'package:bookstore/screens/profile/view%20model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../authentication/presenation/views/widgets/custom_text_form_field.dart';
class EditProfileView extends StatelessWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: SafeArea(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var cubit=BlocProvider.of<ProfileCubit>(context);
          return SingleChildScrollView(
            child: Column(children: [
              Stack(alignment: Alignment.center,
                children: [
                  Container(width: double.infinity,height: MediaQuery.of(context).size.height*0.10,
                    decoration:  const BoxDecoration(
                        gradient: LinearGradient(colors: [
                          Colors.deepPurple,
                          Colors.blueAccent
                        ]),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(80),
                            bottomLeft: Radius.circular(80))),),
                  Text('Edit Profile',
                    style: Styles.textStyle34.copyWith(fontWeight:FontWeight.w500,),)
                ],
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomTextFormField(
                    controller: cubit.nameController,
                    hintText:cubit.model?.data.name!=null ? '${cubit.model?.data.name}':'Name',
                    prefix: Icons.person,
                    obscureText: false,
                    type: TextInputType.text),
              ),
              SizedBox(height: 20.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomTextFormField(
                    controller: cubit.emailController,
                    hintText:cubit.model?.data.email!=null? '${cubit.model?.data.email}':'Email',
                    prefix: Icons.email,
                    obscureText: false,
                    type: TextInputType.emailAddress),
              ),
              SizedBox(height: 10.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomTextFormField(controller: cubit.phoneController,
                    hintText: cubit.model?.data.phone!=null? '${cubit.model?.data.phone}':'Phone',
                    prefix: Icons.phone,
                    obscureText: false,
                    type: TextInputType.phone),
              ),
              SizedBox(height: 20.h,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: 10.w),
               child: Container(decoration: BoxDecoration(border: Border.all(width: 1,),borderRadius: BorderRadius.circular(16)),
                 child: DropdownButton<String>(value: cubit.newValue,
                     isExpanded: true,borderRadius: BorderRadius.circular(16),
                     hint: const Text('Select a city'),
                     underline: const SizedBox(),
                     items: cubit.governorateModel?.data.map((e)  {
                   return DropdownMenuItem<String>(
                     value: e.governorateNameEn,
                     child: Padding(
                       padding: const EdgeInsets.all(12.0),
                       child: Row(
                         children: [
                            Icon(Icons.location_city,color: Colors.grey[400]!),
                           SizedBox(
                             width: 5.w,
                           ),
                           Text(e.governorateNameEn),
                         ],
                       ),
                     ),
                   );
                 }).toList(), onChanged: (value)
                 {
           cubit.changeCity(value);
                 }),
               ),
             ),
              SizedBox(height: 20.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w),
                child: CustomTextFormField(controller: cubit.addressController,
                    hintText: cubit.model?.data.address!=null? '${cubit.model?.data.address}':'Address',
                    prefix: Icons.location_on,
                    obscureText: false,
                    type: TextInputType.text),
              ),
              SizedBox(height: 20.h,),
              SizedBox(
                width: 312.w,
                height: 48.h,

                child: Container(decoration:   BoxDecoration(borderRadius: BorderRadius.circular(16.0),
                    gradient: const LinearGradient(colors: [
                      Colors.deepPurple,
                      Colors.blueAccent,

                    ])),
                  child: ElevatedButton(
                      onPressed: ()
                      {
                         cubit.updateProfile(context);
                      },
                      style: ElevatedButton.styleFrom(elevation: 0.0,
                          padding: EdgeInsets.zero,backgroundColor:Colors.transparent
                      ),
                      child: const Text('Update Profile')),
                ),
              )

            ],),
          );
        },
      ),
    ));
  }
}
