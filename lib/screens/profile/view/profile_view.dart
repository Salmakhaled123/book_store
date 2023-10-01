import 'package:bookstore/core/appfont/styles.dart';
import 'package:bookstore/screens/authentication/presenation/widgets/custom_text_form_field.dart';
import 'package:bookstore/screens/profile/view%20model/profile_cubit.dart';
import 'package:bookstore/screens/profile/view/edit_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<ProfileCubit>(context);
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.10,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.deepPurple, Colors.blueAccent]),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(80),
                              bottomLeft: Radius.circular(80))),
                    ),
                    Text(
                      'Profile',
                      style: Styles.textStyle34.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomTextFormField(
                      readonly: true,
                      controller: cubit.nameController,
                      hintText: cubit.model?.data.name != null
                          ? '${cubit.model?.data.name}'
                          : 'Name',
                      prefix: Icons.person,
                      obscureText: false,
                      type: TextInputType.text),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomTextFormField(
                      readonly: true,
                      controller: cubit.emailController,
                      hintText: cubit.model?.data.email != null
                          ? '${cubit.model?.data.email}'
                          : 'Email',
                      prefix: Icons.email,
                      obscureText: false,
                      type: TextInputType.emailAddress),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomTextFormField(
                      controller: cubit.phoneController,
                      readonly: true,
                      hintText: cubit.model?.data.phone != null
                          ? '${cubit.model?.data.phone}'
                          : 'Phone',
                      prefix: Icons.phone,
                      obscureText: false,
                      type: TextInputType.phone),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomTextFormField(readonly: true,
                      controller: cubit.cityController,
                      hintText: cubit.model?.data.city != null
                          ? '${cubit.model?.data.city}'
                          : 'City',
                      prefix: Icons.location_city_outlined,
                      obscureText: false,
                      type: TextInputType.text),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: CustomTextFormField(readonly: true,
                      controller: cubit.addressController,
                      hintText: cubit.model?.data.address != null
                          ? '${cubit.model?.data.address}'
                          : 'Address',
                      prefix: Icons.location_on,
                      obscureText: false,
                      type: TextInputType.text),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 312.w,
                  height: 48.h,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        gradient: const LinearGradient(colors: [
                          Colors.deepPurple,
                          Colors.blueAccent,
                        ])),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfileView()));
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent),
                        child: const Text('Edit Profile')),
                  ),
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}
