import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marketplace/data/models/products_model.dart';
import 'package:marketplace/data/repository/product_repository.dart';
import 'package:marketplace/data/response/my_response.dart';
import 'package:marketplace/screens/add_products/add_products_screen.dart';
import 'package:marketplace/screens/prudcts/widgets/products_item_builder.dart';
import 'package:marketplace/utils/colors/app_colors.dart';
import 'package:marketplace/utils/styles/app_style.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductRepository productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Products',
            style: AppStyle.interBold.copyWith(fontSize: 22.sp)),
      ),
      body: FutureBuilder(
        future: productRepository.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ProductsModel> productsModel =
                (snapshot.data as MyResponse).data as List<ProductsModel>;
            return GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              itemCount: productsModel.length,
              itemBuilder: (context, index) {
                var model = productsModel[index];
                return ProductsItemBuilder(
                  model: model,
                  changed: (bool value) {
                    setState(() {});
                  },
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68.w,
                crossAxisSpacing: 15.w,
                mainAxisSpacing: 15.w,
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProducts(
                changed: (bool value) {
                  setState(() {});
                },
              ),
            ),
          );
        },
        shape: const OvalBorder(),
        backgroundColor: AppColors.c_0E81B4,
        child: Icon(
          Icons.add,
          size: 32.sp,
          color: AppColors.white,
        ),
      ),
    );
  }
}
