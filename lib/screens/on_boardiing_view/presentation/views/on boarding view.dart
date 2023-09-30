import 'package:bookstore/core/appImages/images.dart';
import 'package:bookstore/screens/authentication/data/login_register_cubit.dart';
import 'package:bookstore/screens/authentication/presenation/register_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/appfont/styles.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LoginRegisterCubit, LoginRegisterState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<LoginRegisterCubit>(context);
          return Column(
            children: [
              Expanded(
                child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: cubit.pageController,
                    itemCount: cubit.onBoarding.length,
                    onPageChanged: (value) {
                      cubit.changeIndex(value);
                      print(value);
                    },
                    itemBuilder: (context, index) => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              cubit.onBoarding[index].image,
                              width: 300.w,
                              height: MediaQuery.of(context).size.height * 0.52,
                            ),
                            Text(
                              cubit.onBoarding[index].text,
                              style: Styles.textStyle20.copyWith(fontSize: 24),
                            )
                          ],
                        )),
              ),
              AnimatedSmoothIndicator(
                  activeIndex: cubit.currentIndex,
                  count: cubit.onBoarding.length,
                  duration: const Duration(milliseconds: 3),
                  curve: Curves.easeInOut),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: SizedBox(
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterView()),
                              (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            padding: EdgeInsets.zero,
                            backgroundColor: Colors.transparent),
                        child: const Text('Skip')),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
