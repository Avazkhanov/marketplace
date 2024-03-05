import 'package:marketplace/data/api_provider/api_provider.dart';
import 'package:marketplace/data/models/products_model.dart';
import 'package:marketplace/data/response/my_response.dart';

class ProductRepository {
  Future<MyResponse> getProducts() => ApiProvider.getProducts();
  Future<MyResponse> addProducts(ProductsModel model) => ApiProvider.addProducts(model);
  Future<MyResponse> deleteProducts(String uuid) => ApiProvider.deleteProduct(uuid);
  Future<MyResponse> updateProducts(ProductsModel model) => ApiProvider.updateProduct(model);
}
