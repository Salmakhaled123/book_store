import 'package:bookstore/core/appImages/images.dart';
import 'package:bookstore/core/navigation/navigation.dart';
import 'package:bookstore/screens/authentication/presenation/views/widgets/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/appfont/styles.dart';
import '../../../view model/login_register_cubit.dart';
import 'custom_text_form_field.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 48.h, horizontal: 24.w),
        child: BlocBuilder<LoginRegisterCubit, LoginRegisterState>(
          builder: (context, state) {
            var cubit = BlocProvider.of<LoginRegisterCubit>(context);
            return Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.register,
                    width: 200.w,
                    height: 200.h,
                  ),
                  Text(
                    'Welcome To Our App',
                    style: Styles.textStyle16.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  CustomTextFormField(
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                      },
                      controller: cubit.nameController,
                      hintText: 'Name',
                      prefix: Icons.person,
                      obscureText: false,
                      type: TextInputType.text),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                      controller: cubit.emailController,
                      hintText: 'Email',
                      prefix: Icons.email,
                      obscureText: false,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your email';
                        }
                      }),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                      suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changeVisibility();
                          },
                          icon: cubit.suffix
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        }
                      },
                      controller: cubit.passwordController,
                      hintText: 'Password',
                      prefix: Icons.password,
                      obscureText: cubit.suffix,
                      type: TextInputType.visiblePassword),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomTextFormField(
                      suffixIcon: IconButton(
                          onPressed: () {
                            cubit.changeVisibilityConfirmPassword();
                          },
                          icon: cubit.suffixConfirmPass
                              ? const Icon(Icons.visibility_off)
                              : const Icon(Icons.visibility)),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'please enter your password';
                        }
                      },
                      controller: cubit.confirmController,
                      hintText: 'confirm password',
                      prefix: Icons.password,
                      obscureText: cubit.suffixConfirmPass,
                      type: TextInputType.visiblePassword),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: Styles.textStyle14,
                      ),
                      InkWell(
                          onTap: () {
                            AppNavigator.customNavigator(
                                context: context,
                                screen: const LoginView(),
                                finish: false);
                          },
                          child: Text(
                            'Login here.',
                            style: Styles.textStyle14.copyWith(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.w500),
                          )),
                    ],
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
                            if (cubit.formKey.currentState!.validate()) {
                              cubit.userRegister(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent),
                          child: state is LoginRegisterLoading
                              ? SizedBox(
                                  width: 24.w,
                                  height: 24.h,
                                  child: const Center(
                                      child: CircularProgressIndicator()),
                                )
                              : const Text('REGISTER')),
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
