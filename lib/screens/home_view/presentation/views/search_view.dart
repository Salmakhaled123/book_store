import 'package:bookstore/core/appImages/images.dart';
import 'package:bookstore/screens/home_view/data/best_seller_model.dart';
import 'package:bookstore/screens/home_view/presentation/view%20models/home_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/appfont/styles.dart';
import '../../../authentication/presenation/views/widgets/custom_text_form_field.dart';
import '../../../book_details/presentation/view/book_details_view.dart';
import '../../../cart/view model/cart_cubit.dart';
import '../../../favorite/view model/favorite_cubit.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit=BlocProvider.of<HomeCubit>(context);
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.w),
                child: CustomTextFormField(controller: cubit.searchController,
                    hintText: 'Search for a book',
                  onFieldSubmitted: (value){
                  cubit.searchForProduct(context);
                  },
                    prefix: Icons.search,
                    obscureText: false,
                    type: TextInputType.text),
              ),
        cubit.searchModel?.data.products==null?
        Center(child: Image.asset(AppImages.search,),):
        SizedBox(height: MediaQuery.of(context).size.height*0.85,
               child: ListView.builder(physics: const BouncingScrollPhysics(),
                 itemBuilder: (context,index){
                   return InkWell(onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>BookDetailsView(model: cubit.searchModel?.data.products[index])));
                   },
                       child: Padding(
                         padding: const EdgeInsets.all(20.0),
                         child: Material(elevation: 10.0,borderRadius: BorderRadius.circular(16),
                           child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               SizedBox(height: 125.h,
                                 child: ClipRRect(
                                   borderRadius: BorderRadius.circular(16),
                                   child: CachedNetworkImage(width: 120.w,
                                     imageUrl: cubit.searchModel?.data.products[index].image ??''  ,
                                     fit: BoxFit.fill,
                                     placeholder: (context, url) =>
                                         AspectRatio(aspectRatio: 2.9/4,child:
                                         Shimmer.fromColors(baseColor: Colors.grey[400]!,
                                             highlightColor: Colors.grey[300]!, child: Container(color: Colors.grey[400])),) ,
                                     errorWidget: (context, url, error) =>
                                     const Center(child: Icon(Icons.error_outline)),
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
                                         child: Text(cubit.searchModel?.data.products[index].name??'',
                                           style: Styles.textStyle20,overflow: TextOverflow.ellipsis,maxLines: 1,),
                                       ),

                                       Text(
                                         cubit.searchModel?.data.products[index].category ?? '',style:
                                       Styles.textStyle16.copyWith(color: Colors.grey,overflow: TextOverflow.ellipsis),),
                                       SizedBox(height: 5.h,),
                                       Text('${cubit.searchModel?.data.products[index].priceAfterDiscount ?? ''} L.E',style: Styles.textStyle16.copyWith(
                                           color: Colors.deepPurple,fontWeight: FontWeight.bold),),
                                     ],
                                   ),
                                   Column(
                                     children: [
                                       BlocBuilder<FavoriteCubit, FavoriteState>(
                                           builder: (context, state) {
                                             var cubit2=BlocProvider.of<FavoriteCubit>(context);
                                             return IconButton(onPressed: (){
                                               cubit2.addToWishList(cubit.searchModel?.data.products[index].id,context);
                                             },
                                                 icon:cubit2.favorites.contains(cubit.searchModel?.data.products[index].id)?
                                                 const Icon(Icons.favorite,color: Colors.red,) :
                                                 const Icon(Icons.favorite_border_outlined));
                                           }
                                       ),
                                       IconButton(onPressed: ()
                                       {
                                         BlocProvider.of<CartCubit>(context).addToCart(cubit.searchModel?.data.products[index].id, context);

                                       },
                                           icon: const Icon(Icons.add_shopping_cart)),
                                     ],
                                   )
                                 ],
                               )


                             ],
                           ),
                         ),
                       ));
                 },itemCount: cubit.searchModel?.data.products.length,),
             )


            ]),
          ),
        );
      },
    ),);
  }
}
