import 'package:bookstore/core/appfont/styles.dart';
import 'package:bookstore/core/cacheHelper/cacheHelper.dart';
import 'package:bookstore/screens/books/view/books_view.dart';
import 'package:bookstore/screens/home_view/presentation/view%20models/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import 'bookitemlistview.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<HomeCubit>(context);
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h,),
                   Text(
                    'Welcome ${CacheHelper.getData(key: 'name')}',
                    style: Styles.textStyle20,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      cubit.model != null
                          ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: CarouselSlider.builder(
                            itemCount: cubit.model?.data.sliders.length,
                            itemBuilder: (context, index, realIndex) {
                              return CachedNetworkImage(
                                imageUrl: cubit.model?.data.sliders[index].image,
                                errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                                placeholder: (context, url) => Shimmer.fromColors(
                                  baseColor: Colors.grey[200]!,
                                  highlightColor: Colors.grey[300]!,
                                  child: SizedBox(
                                      width: 100,
                                      height: MediaQuery.of(context).size.height *
                                          0.25),
                                ),
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                              );
                            },
                            options: CarouselOptions(
                                autoPlay: true,
                                autoPlayAnimationDuration:
                                const Duration(milliseconds: 1000),
                                autoPlayCurve: Curves.easeIn),
                          ),
                        ),
                      )
                          : const Center(child: CircularProgressIndicator(color: Colors.deepPurple,)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Row(
                          children: [
                            Text(
                              'Best Seller',
                              style: Styles.textStyle20.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const BooksView()));
                                },
                                icon: const Icon(Icons.arrow_forward)),
                          ],
                        ),
                      ),
                      cubit.bestSellerModel != null
                          ? BookItemListView(
                        model: cubit.bestSellerModel!,
                      )
                          : const Center(
                        child: CircularProgressIndicator(color: Colors.deepPurple),
                      ),


                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Text(
                          'Category',
                          style: Styles.textStyle20.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {

                            },
                            icon: const Icon(Icons.arrow_forward)),
                      ],
                    ),
                  ),
                  cubit.categoriesModel!=null ?
                  SizedBox(height: 100.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(decoration: BoxDecoration(color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(16)),
                                width: 130.w,height: 120.h),
                            Image.network(height: 100.h,width: 100.w,
                                'https://th.bing.com/th/id/R.1dc6fabd97bf37ca4f4205435b2ddd2c?rik=x0wO3MEiFLC5dw&riu=http%3a%2f%2fclipart-library.com%2fimages_k%2fbook-transparent-png%2fbook-transparent-png-22.png&ehk=1Up0crZ35gdC4AmIR6jIp9coG2VdoOTVzhQA84BpkSQ%3d&risl=&pid=ImgRaw&r=0'),
                            Text(
                              cubit.categoriesModel!.data.categories[index].name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.textStyle16
                                  .copyWith(

                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                      itemCount: cubit.categoriesModel?.data.categories.length,
                    ),
                  ):const Center(child: CircularProgressIndicator(color: Colors.deepPurple,)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Text(
                          'New Arrivals',
                          style: Styles.textStyle20.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {

                            },
                            icon: const Icon(Icons.arrow_forward)),
                      ],
                    ),
                  ),
                  cubit.newArrivalsModel!=null ?
                  SizedBox(height: 200.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl:'${cubit.newArrivalsModel?.data.products[index].image}' ,placeholder:(context, url) =>  Shimmer.fromColors(
                                        baseColor: Colors.grey[400]!,
                                        highlightColor: Colors.grey[300]!,
                                        child: Container(width: 100.w,height: 100.h,decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)))) ,errorWidget:(context, url, error) => const Icon(Icons.error) ,
                                       ),

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(color: Colors.red,child:
                                    Text('${cubit.newArrivalsModel?.data.products[index].discount} %',style: Styles.textStyle14,),),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 100.w,
                              child: Text(
                                cubit.newArrivalsModel!.data.products[index].name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Styles.textStyle14
                                    .copyWith(fontWeight: FontWeight.bold

                                ),
                              ),
                            ),
                            Text(
                              cubit.newArrivalsModel!.data.products[index].category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.textStyle14

                                  .copyWith(
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              '${cubit.newArrivalsModel!.data.products[index].price} L.E',

                              style: Styles.textStyle16
                                  .copyWith(decoration: TextDecoration.lineThrough,
                                color: Colors.deepPurple,
                              ),
                            ),
                           const SizedBox(height: 10,),
                            Text(
                              '${cubit.newArrivalsModel!.data.products[index].priceAfterDiscount} L.E',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.textStyle16
                                  .copyWith(
                                color: Colors.deepPurple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                          ],
                        ),
                      ),
                      itemCount: cubit.newArrivalsModel?.data.products.length,
                    ),
                  ):const Center(child: CircularProgressIndicator(color: Colors.deepPurple,)),


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

