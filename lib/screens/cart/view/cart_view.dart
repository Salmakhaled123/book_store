import 'package:bookstore/core/appImages/images.dart';
import 'package:bookstore/screens/cart/view%20model/cart_cubit.dart';
import 'package:bookstore/screens/checkout/view/checkout_view.dart';
import 'package:bookstore/screens/home_view/presentation/views/home_view.dart';
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
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<CartCubit>(context);

        return cubit.cartModel?.data.cartItems.length != 0
            ? Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: cubit.cartModel?.data.cartItems.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Material(
                              elevation: 10.0,
                              borderRadius: BorderRadius.circular(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 125.h,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: CachedNetworkImage(
                                        width: 100.w,
                                        imageUrl: cubit
                                                .cartModel
                                                ?.data
                                                .cartItems[index]
                                                .itemProductImage ??
                                            '',
                                        fit: BoxFit.fill,
                                        placeholder: (context, url) =>
                                            AspectRatio(
                                          aspectRatio: 2.9 / 4,
                                          child: Shimmer.fromColors(
                                              baseColor: Colors.grey[400]!,
                                              highlightColor: Colors.grey[300]!,
                                              child: Container(
                                                  color: Colors.grey[400])),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error_outline),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 20.h,
                                          ),
                                          SizedBox(
                                            width: 100,
                                            child: Text(
                                              cubit
                                                      .cartModel
                                                      ?.data
                                                      .cartItems[index]
                                                      .itemProductName ??
                                                  '',
                                              style: Styles.textStyle20,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            ),
                                          ),
                                          Text(
                                            cubit
                                                    .cartModel
                                                    ?.data
                                                    .cartItems[index]
                                                    .itemProductPrice ??
                                                '',
                                            style: Styles.textStyle16.copyWith(
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            '${cubit.cartModel?.data.cartItems[index].itemProductPriceAfterDiscount ?? ''} L.E',
                                            style: Styles.textStyle16.copyWith(
                                                color: Colors.deepPurple,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(Icons
                                                  .favorite_border_outlined)),
                                          IconButton(
                                              onPressed: () {
                                                cubit.removeFromCart(
                                                    cubit
                                                        .cartModel
                                                        ?.data
                                                        .cartItems[index]
                                                        .itemId,
                                                    context);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                          Row(
                                            children: [
                                               InkWell(
                                                child:const  Icon(
                                                  Icons.add,
                                                  size: 18,
                                                ),
                                                onTap: (){
                                                  cubit.updateQuantity(cubit.cartModel?.data.cartItems[index].itemQuantity);
                                                  cubit.increment();
                                                  cubit.updateCart(cubit.cartModel?.data.cartItems[index].itemId, context,
                                                  );
                                                },
                                              ),
                                               Text(
                                                '${cubit.cartModel?.data.cartItems[index].itemQuantity}',
                                                style: Styles.textStyle16,
                                              ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                               InkWell(
                                                child: const Text(
                                                  '-',
                                                  style: Styles.textStyle34,
                                                ),
                                                onTap: (){
                                                  cubit.updateQuantity(cubit.cartModel?.data.cartItems[index].itemQuantity);
                                          cubit.decrement();
                                                  cubit.updateCart(cubit.cartModel?.data.cartItems[index].itemId, context,
                                                      );

                                                },
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.75,
                    height: 48.h,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          gradient: const LinearGradient(colors: [
                            Colors.deepPurple,
                            Colors.blueAccent,
                          ])),
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              elevation: 0.0,
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  ' Total:${cubit.cartModel?.data.total.toString().
                                  split('.')[0]} L.E ',
                                  style: Styles.textStyle20,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(onTap: (){
                                    cubit.checkout();
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const CheckOutView()));
                                  },
                                    child: Text(
                                      'Check Out',
                                      style: Styles.textStyle16.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              )
            : Center(child: Image.asset(AppImages.emptyCart));
      },
    );
  }
}
