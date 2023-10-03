import 'package:bookstore/core/appfont/styles.dart';
import 'package:bookstore/screens/home_view/data/best_seller_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../home_view/data/book_model.dart';
class BookDetailsView extends StatelessWidget {
  const BookDetailsView({Key? key, required this.model}) : super(key: key);
final dynamic model;
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            CachedNetworkImage(
              imageUrl:model.image ,
              height: MediaQuery.of(context).size.height*0.45,
            width:double.infinity ,
              fit: BoxFit.fill,
            ),
            SizedBox(height: 10.h,),
            Text(
              model.name,maxLines: 1,overflow: TextOverflow.ellipsis,
              style: Styles.textStyle20.copyWith(
                fontWeight: FontWeight.bold,

              ),
            ),

            Row(
              children: [
                Text(
                  model.category,
                  style: Styles.textStyle16.copyWith(
                       color: Colors.grey[500]),
                ),
                const Spacer(),
                Column(
                  children: [
                    Text(
                      '${model.price} L.E',
                      style: Styles.textStyle14.copyWith(decoration: TextDecoration.lineThrough,
                          color: Colors.grey[400]),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      '${model.priceAfterDiscount} L.E',
                      style: Styles.textStyle16.copyWith(color: Colors.deepPurple,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                  ],
                )
              ],
            ),
            SizedBox(height: 5.h,),
            Text(
              'Description',
              style: Styles.textStyle20.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                model.description,
                style: Styles.textStyle16.copyWith(
                     color: Colors.grey[500]),
              ),
            ),
            SizedBox(height: 10.h,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SizedBox(
                  width: 312.w,
                  height: 48.h,

                  child: Container(decoration:   BoxDecoration(borderRadius: BorderRadius.circular(16.0),
                      gradient: const LinearGradient(colors: [
                        Colors.deepPurple,
                        Colors.blueAccent,

                      ])),
                    child: ElevatedButton(
                        onPressed: ()  {

                        },
                        style: ElevatedButton.styleFrom(elevation: 0.0,
                            padding: EdgeInsets.zero,backgroundColor:Colors.transparent
                        ),
                        child:
                             const Text('Add to Cart')),
                  ),
                ),
              ),
            ),


          ]),
        ),
      ),
    );
  }
}
