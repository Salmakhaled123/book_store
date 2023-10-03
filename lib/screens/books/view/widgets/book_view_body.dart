import 'package:bookstore/screens/cart/view%20model/cart_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/appfont/styles.dart';
import '../../../home_view/presentation/view models/home_cubit.dart';
class BookViewBody extends StatelessWidget {
  const BookViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state)
      {
        var cubit=BlocProvider.of<HomeCubit>(context);
        cubit.getMoreData();
        return
        ListView.builder(controller: cubit.scrollController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: cubit.isLoadMore ?
            cubit.books.length+1
                :cubit.books.length,
            itemBuilder: (context,index)
             {
               if(index>=cubit.books.length)
                 {
                   return const Center(child: CircularProgressIndicator(),);
                 }
               return Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Material(elevation: 10.0,borderRadius: BorderRadius.circular(16),
                   child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       SizedBox(height: 125.h,
                         child: ClipRRect(
                           borderRadius: BorderRadius.circular(16),
                           child: CachedNetworkImage(width: 120.w,
                             imageUrl: cubit.books[index].image ??''  ,
                             fit: BoxFit.fill,
                             placeholder: (context, url) =>
                                 AspectRatio(aspectRatio: 2.9/4,child:
                                 Shimmer.fromColors(baseColor: Colors.grey[400]!,
                                     highlightColor: Colors.grey[300]!, child: Container(color: Colors.grey[400])),) ,
                             errorWidget: (context, url, error) =>
                             const  Icon(Icons.error_outline),
                           ),
                         ),
                       ),
                       SizedBox(width: 20.w,),
                       Row(
                         children: [
                           Column(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: 20.h,),
                               SizedBox(width: 100,
                                 child: Text(cubit.books[index].name??'',
                                   style: Styles.textStyle20,overflow: TextOverflow.ellipsis,maxLines: 1,),
                               ),

                               Text(
                                 cubit.books[index].category ?? '',style:
                               Styles.textStyle16.copyWith(color: Colors.grey,overflow: TextOverflow.ellipsis),),
                               SizedBox(height: 5.h,),
                               Text('${cubit.books[index].priceAfterDiscount ?? ''} L.E',style: Styles.textStyle16.copyWith(
                                   color: Colors.deepPurple,fontWeight: FontWeight.bold),),
                             ],
                           ),
                           Column(
                             children: [
                               IconButton(onPressed: (){},
                                   icon: const Icon(Icons.favorite_border_outlined)),
                               IconButton(onPressed: ()
                               {
                                 BlocProvider.of<CartCubit>(context).addToCart(cubit.books[index].id, context);
                                // BlocProvider.of<CartCubit>(context).showCart();

                               },
                                   icon: const Icon(Icons.add_shopping_cart)),
                             ],
                           )
                         ],
                       )


                     ],
                   ),
                 ),
               );
             }
            );
      },

    );
  }
}
