import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/appfont/styles.dart';
import '../../../home_view/presentation/view models/home_cubit.dart';
class NewArrivalsViewBody extends StatelessWidget {
  const NewArrivalsViewBody({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit=BlocProvider.of<HomeCubit>(context);
        return ListView.builder(physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: cubit.newArrivalsModel?.data.products.length,
            itemBuilder: (context,index)=>Padding(
              padding: const EdgeInsets.all(20.0),
              child: Material(elevation: 10.0,borderRadius: BorderRadius.circular(16),
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 125.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: CachedNetworkImage(
                          imageUrl: cubit.newArrivalsModel?.data.products[index].image ??''  ,
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
                    SizedBox(width: 50.w,),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h,),
                        SizedBox(width: 100,
                          child: Text(cubit.newArrivalsModel?.data.products[index].name??'',
                            style: Styles.textStyle20,overflow: TextOverflow.ellipsis,maxLines: 1,),
                        ),

                        Text(cubit.newArrivalsModel?.data.products[index].category ?? '',style: Styles.textStyle16.copyWith(color: Colors.grey),),
                        SizedBox(height: 5.h,),
                        Text('${cubit.newArrivalsModel?.data.products[index].priceAfterDiscount ?? ''} L.E',style: Styles.textStyle16.copyWith(
                            color: Colors.deepPurple,fontWeight: FontWeight.bold),),
                      ],
                    )


                  ],
                ),
              ),
            ));
      },
    );
  }
}
