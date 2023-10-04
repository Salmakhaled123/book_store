import 'package:bookstore/core/cacheHelper/cacheHelper.dart';
import 'package:bookstore/screens/home_view/presentation/view%20models/home_cubit.dart';
import 'package:bookstore/screens/home_view/presentation/views/search_view.dart';
import 'package:bookstore/screens/home_view/presentation/views/widgets/home_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit=BlocProvider.of<HomeCubit>(context);
        return Scaffold(
            body: cubit.views.elementAt(cubit.selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.deepPurple,
              items: cubit.items,
              currentIndex: cubit.selectedIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (value) {
                cubit.changeIndex(value);
              },));
      },
    );
  }
}
