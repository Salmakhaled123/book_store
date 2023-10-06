import 'package:bookstore/core/appfont/styles.dart';
import 'package:bookstore/screens/cart/view%20model/cart_cubit.dart';
import 'package:bookstore/screens/checkout/view/widgets/check%20out%20view%20body.dart';
import 'package:bookstore/screens/profile/view%20model/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../authentication/presenation/views/widgets/custom_text_form_field.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body:CheckOutViewBody() );
  }
}
