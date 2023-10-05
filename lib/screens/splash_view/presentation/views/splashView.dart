import 'package:bookstore/core/appfont/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../authentication/view model/login_register_cubit.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blueAccent,
              Colors.deepPurple
            ])),
        child: BlocBuilder<LoginRegisterCubit, LoginRegisterState>(
          builder: (context, state) {
            var cubit=BlocProvider.of<LoginRegisterCubit>(context);
            cubit.navigateToOnBoarding(context);
            return Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/books.json'),
                  Text(
                    'Welcome to Booky',
                    style: Styles.textStyle20.copyWith(
                        fontWeight: FontWeight.bold),
                  )
                ]);
          },
        ),
      ),
    );
  }
}
