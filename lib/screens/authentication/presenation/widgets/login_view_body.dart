import 'package:bookstore/core/appImages/images.dart';
import 'package:bookstore/screens/home_view/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/appcolors/colors.dart';
import '../../../../core/appfont/styles.dart';
import '../../../home_view/presentation/views/home_view.dart';
import '../../data/login_register_cubit.dart';
import 'custom_text_form_field.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
        child: BlocBuilder<LoginRegisterCubit, LoginRegisterState>(
          builder: (context, state) {
            var cubit=BlocProvider.of<LoginRegisterCubit>(context);
            return Form(key: cubit.formKey2,
              child: Column(  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppImages.register),
                  Text(
                    'Login Now',
                    style: Styles.textStyle34.copyWith(
                      fontSize: 34.sp,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),


                  CustomTextFormField(controller: cubit.emailController,
                      hintText: 'Email',
                      prefix: Icons.person,
                      obscureText: false,
                      type: TextInputType.emailAddress),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(suffixIcon: IconButton(onPressed: (){
                    cubit.changeVisibility();
                  },
                      icon: cubit.suffix ? const Icon(Icons.visibility_off):
                      const Icon(Icons.visibility)),
                      validate: (value){
                        if(value!.isEmpty)
                        {
                          return 'please enter your password';
                        }
                      },
                      controller: cubit.passwordController, hintText: 'Password', prefix: Icons.password, obscureText: cubit.suffix,
                      type: TextInputType.visiblePassword),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 312.w,
                    height: 48.h,

                    child: Container(decoration:   BoxDecoration(borderRadius: BorderRadius.circular(16.0),
                        gradient: const LinearGradient(colors: [
                          Colors.deepPurple,
                          Colors.blueAccent,

                        ])),
                      child: ElevatedButton(
                          onPressed: ()  {

                            if (cubit.formKey2.currentState!.validate())
                            {
                              cubit.userLogin(context);
                              print('salmaaa');
                            }
                          },
                          style: ElevatedButton.styleFrom(elevation: 0.0,
                              padding: EdgeInsets.zero,backgroundColor:Colors.transparent
                          ),
                          child: state is LoginLoading ? SizedBox(width: 24.w,height: 24.h,child: const Center(child: CircularProgressIndicator()),)
                              : const Text('Login')),
                    ),
                  ),


                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
