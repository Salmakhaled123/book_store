import 'package:bookstore/core/appImages/images.dart';
import 'package:bookstore/screens/cart/view%20model/cart_cubit.dart';
import 'package:bookstore/screens/cart/view/widgets/cart_view_body.dart';
import 'package:bookstore/screens/checkout/view/checkout_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../core/appfont/styles.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CartViewBody();
  }
}
