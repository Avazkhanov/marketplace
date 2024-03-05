import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketplace/data/models/products_model.dart';
import 'package:marketplace/data/repository/product_repository.dart';
import 'package:marketplace/screens/update_products/update_products_screen.dart';

import '../../../utils/colors/app_colors.dart';
import '../../../utils/styles/app_style.dart';

class ProductsItemBuilder extends StatelessWidget {
  const ProductsItemBuilder(
      {super.key, required this.model, required this.changed});

  final ProductsModel model;
  final ValueChanged<bool> changed;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      decoration: BoxDecoration(
          color: AppColors.c_F2F2F2,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 6,
              offset: const Offset(0, 8), // changes position of shadow
            ),
          ]),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  model.image,
                  height: 120.h,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Brand: ",
                          style: AppStyle.interBold.copyWith(
                              fontSize: 14.sp, color: AppColors.c_162023)),
                      TextSpan(
                          text: model.brand,
                          style: AppStyle.interRegular.copyWith(
                              fontSize: 12.sp, color: AppColors.c_162023)),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Model: ",
                          style: AppStyle.interBold.copyWith(
                              fontSize: 14.sp, color: AppColors.c_162023)),
                      TextSpan(
                          text: model.model,
                          style: AppStyle.interRegular.copyWith(
                              fontSize: 12.sp, color: AppColors.c_162023)),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: "Price: ",
                          style: AppStyle.interBold.copyWith(
                              fontSize: 14.sp, color: AppColors.c_162023)),
                      TextSpan(
                          text: "\$${model.price.toString()}",
                          style: AppStyle.interRegular.copyWith(
                              fontSize: 12.sp, color: AppColors.c_0E81B4)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.w,
            top: 0.h,
            child: PopupMenuButton(
              itemBuilder: (context) {
                return <PopupMenuEntry<Widget>>[
                  PopupMenuItem(
                    height: 10.h,
                    child: IconButton(
                      onPressed: () async {
                        ProductRepository repository = ProductRepository();
                        await repository.deleteProducts(model.uuid);
                        changed.call(true);
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                UpdateProducts(changed: (t){
                                  changed.call(t);
                                }, model: model),
                          ),
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                  ),
                ];
              },
            ),
          ),
        ],
      ),
    );
  }
}
