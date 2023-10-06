import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/appfont/styles.dart';
import '../../../authentication/presenation/views/widgets/custom_text_form_field.dart';
import '../../../cart/view model/cart_cubit.dart';
import '../../../profile/view model/profile_cubit.dart';
class CheckOutViewBody extends StatelessWidget {
  const CheckOutViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<ProfileCubit>(context);

          return SingleChildScrollView(
            child: Form(key:cubit.formKey3 ,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomTextFormField(validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter your name';

                      }
                    },
                        controller: cubit.nameController,
                        hintText:'Name',
                        prefix: Icons.person,
                        obscureText: false,
                        type: TextInputType.name),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomTextFormField(validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter your email';
                      }
                    },
                        controller: cubit.emailController,
                        hintText:'Email',
                        prefix: Icons.email,
                        obscureText: false,
                        type: TextInputType.emailAddress),
                  ),
                  SizedBox(height: 10.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomTextFormField(
                        controller: cubit.phoneController,
                        hintText: 'Phone',
                        prefix: Icons.phone,
                        validate: (value){
                          if(value!.isEmpty)
                          {
                            return 'please enter your phone';
                          }
                        },
                        obscureText: false,
                        type: TextInputType.phone),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: Container(decoration: BoxDecoration(border: Border.all(width: 1,),borderRadius: BorderRadius.circular(16)),
                      child: DropdownButton<String>(value: cubit.newValue,
                          isExpanded: true,borderRadius: BorderRadius.circular(16),
                          hint: const Text('Select a city'),
                          underline: const SizedBox(),
                          items: cubit.governorateModel?.data.map((e)
                          {cubit.id=e.id;
                          return DropdownMenuItem<String>(
                            value: e.governorateNameEn,

                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Row(
                                children: [
                                  Icon(Icons.location_city,color: Colors.grey[400]!),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(e.governorateNameEn),
                                ],
                              ),
                            ),
                          );
                          }).toList(), onChanged: (value)
                          {
                            cubit.changeCity(value);
                          }),
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: CustomTextFormField(validate: (value){
                      if(value!.isEmpty)
                      {
                        return 'please enter your address';
                      }
                    },
                        controller: cubit.addressController,
                        hintText: 'Address',
                        prefix: Icons.location_on,
                        obscureText: false,
                        type: TextInputType.text),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 10.w),
                    child: const Text('Orders',style: Styles.textStyle20,),
                  ),
                  SizedBox(height: 180.h,
                    child: BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return ListView.builder(physics: const BouncingScrollPhysics(),
                            itemCount:BlocProvider.of<CartCubit>(context).checkOutCart?.data.cartItems.length ?? 0 ,
                            itemBuilder: (context,index)=>
                                Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
                                  child: ListTile(tileColor: Colors.grey[300],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    iconColor: Colors.deepPurple,
                                    leading: const Icon(Icons.shopping_bag_outlined),
                                    subtitle:Row(children: [
                                      Text('Price :${BlocProvider.of<CartCubit>(context).checkOutCart?.data.cartItems[index].itemProductPrice}L.E'),
                                      SizedBox(width: 10.w,),
                                      Text('Quantity:${BlocProvider.of<CartCubit>(context).checkOutCart?.data.cartItems[index].itemQuantity}')
                                    ]),
                                    title: Text('Product Name :${BlocProvider.of<CartCubit>(context).checkOutCart?.data.cartItems[index].itemProductName}',overflow: TextOverflow.ellipsis,),),
                                ));
                      },
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 150.w,
                        height: 40.h,
                        child: Container(decoration:   BoxDecoration(borderRadius: BorderRadius.circular(16.0),
                            gradient: const LinearGradient(colors: [
                              Colors.deepPurple,
                              Colors.blueAccent,

                            ])),
                          child: ElevatedButton(
                              onPressed: ()  {
                                if(cubit.formKey3.currentState!.validate())
                                {
                                  cubit.placeOrder(context);

                                }
                              },
                              style: ElevatedButton.styleFrom(elevation: 0.0,
                                  padding: EdgeInsets.zero,backgroundColor:Colors.transparent
                              ),
                              child:  const Text('Order Now!')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
