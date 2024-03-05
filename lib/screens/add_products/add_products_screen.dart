import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketplace/data/models/products_model.dart';
import 'package:marketplace/data/repository/product_repository.dart';
import 'package:marketplace/screens/add_products/widgets/TextFieldItem.dart';
import 'package:marketplace/utils/colors/app_colors.dart';
import 'package:marketplace/utils/styles/app_style.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key, required this.changed});

  final ValueChanged<bool> changed;

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController image = TextEditingController();

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
          'Add Products',
          style: AppStyle.interBold.copyWith(fontSize: 32.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: Column(
          children: [
            SizedBox(height: 15.h),
            TextFieldItem(
              lebelText: "Product Brand",
              controller: brandController,
            ),
            SizedBox(height: 15.h),
            TextFieldItem(
              lebelText: "Product Model",
              controller: modelController,
            ),
            SizedBox(height: 15.h),
            TextFieldItem(
              lebelText: "Description",
              controller: descriptionController,
            ),
            SizedBox(height: 15.h),
            TextFieldItem(
              lebelText: "Price",
              controller: price,
            ),
            SizedBox(height: 15.h),
            TextFieldItem(
              lebelText: "Image Url",
              controller: image,
            ),
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
                    ProductsModel product = ProductsModel(
                      uuid: "",
                      brand: brandController.text,
                      model: modelController.text,
                      description: descriptionController.text,
                      price: int.parse(price.text),
                      image:
                          "https://i.pinimg.com/736x/31/2c/25/312c258202f28dae23f3e326945e7f99.jpg",
                    );
                    if (product.canCreateProduct()) {
                      ProductRepository response = ProductRepository();
                      await response.addProducts(product);
                      widget.changed.call(true);
                      Navigator.pop(context);
                    } else {
                      print(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Maydonlarni to'ldirinh"),
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
