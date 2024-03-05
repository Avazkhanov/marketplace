import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketplace/data/models/products_model.dart';
import 'package:marketplace/data/repository/product_repository.dart';
import 'package:marketplace/screens/add_products/widgets/TextFieldItem.dart';
import 'package:marketplace/utils/colors/app_colors.dart';
import 'package:marketplace/utils/styles/app_style.dart';

class UpdateProducts extends StatefulWidget {
  UpdateProducts({super.key, required this.changed, required this.model});

  final ValueChanged<bool> changed;
  ProductsModel model;

  @override
  State<UpdateProducts> createState() => _UpdateProductsState();
}

class _UpdateProductsState extends State<UpdateProducts> {
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController image = TextEditingController();

  @override
  void initState() {
    brandController.text = widget.model.brand;
    modelController.text = widget.model.model;
    descriptionController.text = widget.model.description;
    price.text = widget.model.price.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text(
          'Update Products',
          style: AppStyle.interBold.copyWith(fontSize: 32.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            SizedBox(height: 15.h),
            TextFieldItem(
                lebelText: "Product Brand", controller: brandController),
            SizedBox(height: 15.h),
            TextFieldItem(
                lebelText: "Product Model", controller: modelController),
            SizedBox(height: 15.h),
            TextFieldItem(
                lebelText: "Description", controller: descriptionController),
            SizedBox(height: 15.h),
            TextFieldItem(lebelText: "Price", controller: price),
            SizedBox(height: 15.h),
            TextFieldItem(lebelText: "Image Url", controller: image),
            SizedBox(height: 40.h),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Ink(
                height: 40.h,
                width: 100.w,
                decoration: BoxDecoration(
                  color: AppColors.c_27AE60,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Center(
                    child: Text("Save",
                        style: AppStyle.interBold.copyWith(fontSize: 12.sp)),
                  ),
                  onTap: () async {
                    widget.model = widget.model.copyWith(
                      brand: brandController.text,
                      model: modelController.text,
                      description: descriptionController.text,
                      price: int.parse(price.text),
                    );
                    if (widget.model.canCreateProduct()) {
                      ProductRepository response = ProductRepository();
                      await response.updateProducts(widget.model);
                      widget.changed.call(true);
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Maydonlarni to'ldiring"),
                        ),
                      );
                    }
                  },
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
