import 'package:bookstore/screens/cart/view%20model/cart_cubit.dart';
import 'package:bookstore/screens/favorite/view%20model/favorite_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/appfont/styles.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        var cubit = BlocProvider.of<FavoriteCubit>(context);
        return cubit.favorites.isEmpty
            ?Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const   Icon(Icons.shopping_bag_outlined,
                  color: Colors.deepPurple, size: 100),
              SizedBox(height: 20.h,),
              const  Text('Empty WishList',style: Styles.textStyle20,)
            ],
          ),
        )
            :  ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: cubit.favoriteModel?.data.data.length ,
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
                            width: 120.w,
                            imageUrl: cubit.favoriteModel?.data.data[index]
                                .image ??
                                '',
                            fit: BoxFit.fill,
                            placeholder: (context, url) => AspectRatio(
                              aspectRatio: 2.9 / 4,
                              child: Shimmer.fromColors(
                                  baseColor: Colors.grey[400]!,
                                  highlightColor: Colors.grey[300]!,
                                  child:
                                  Container(color: Colors.grey[400])),
                            ),
                            errorWidget: (context, url, error) =>
                            const Center(
                                child: Icon(Icons.error_outline)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  cubit.favoriteModel?.data.data[index]
                                      .name ??
                                      '',
                                  style: Styles.textStyle20,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                              Text(
                                cubit.favoriteModel?.data.data[index]
                                    .category ??
                                    '',
                                style: Styles.textStyle16.copyWith(
                                    color: Colors.grey,
                                    overflow: TextOverflow.ellipsis),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                '${cubit.favoriteModel?.data.data[index].price}'
                                    'L.E ',
                                style: Styles.textStyle16.copyWith(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'discount :${cubit.favoriteModel?.data.data[index].discount}'
                                    '% ',
                                style: Styles.textStyle16.copyWith(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    cubit.removeFromWishList(
                                        cubit.favoriteModel?.data
                                            .data[index].id,
                                        context);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
