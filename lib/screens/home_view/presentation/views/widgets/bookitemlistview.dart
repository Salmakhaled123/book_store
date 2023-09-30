import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../core/appfont/styles.dart';
import '../../../data/best_seller_model.dart';
class BookItemListView extends StatelessWidget {
  const BookItemListView({Key? key, required this.model}) : super(key: key);
  final BestSellerModel? model;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 207.h,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(alignment: Alignment.topLeft,
                    children: [
                      CachedNetworkImage(
                        imageUrl: model?.data.products[index].image ?? '',
                        fit: BoxFit.fill,
                        placeholder: (context, url) => AspectRatio(
                          aspectRatio: 2.6 / 4,
                          child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[300]!,
                              child: Container(color: Colors.grey[400])),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Container(color: Colors.red,child:
                        Text('${model?.data.products[index].discount} %',style: Styles.textStyle14,),),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              SizedBox(
                width: 100.w,
                child: Text(
                  model?.data.products[index].name ?? '',
                  style: Styles.textStyle16.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,

                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                model?.data.products[index].category ?? '',
                style: Styles.textStyle16.copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${model?.data.products[index].price ?? ''} L.E',
                style: Styles.textStyle16.copyWith(decoration: TextDecoration.lineThrough,
                    color: Colors.deepPurple, ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                '${model?.data.products[index].priceAfterDiscount ?? ''} L.E',
                style: Styles.textStyle16.copyWith(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        itemCount: 3,
      ),
    );
  }
}
