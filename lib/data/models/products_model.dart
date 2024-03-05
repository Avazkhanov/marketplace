class ProductsModel {
  final String uuid;
  final String brand;
  final String model;
  final String description;
  final int price;
  final String image;

  ProductsModel({
    required this.uuid,
    required this.brand,
    required this.model,
    required this.description,
    required this.price,
    required this.image,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      uuid: json['_uuid'] as String? ?? "",
      brand: json['brand'] as String? ?? "",
      model: json['model'] as String? ?? "",
      description: json['description'] as String? ?? "",
      price: json['price'] as int? ?? 0,
      image: json['image'] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': brand,
      'model': model,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  Map<String, dynamic> toJsonForUpdate() {
    return {
      "_uuid": uuid,
      'name': brand,
      'model': model,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  ProductsModel copyWith(
      {String? brand,
      String? model,
      String? description,
      int? price,
      String? image}) {
    return ProductsModel(
        uuid: uuid,
        brand: brand ?? this.brand,
        model: model ?? this.model,
        description: description ?? this.description,
        price: price ?? this.price,
        image: image ?? this.image);
  }

  bool canCreateProduct() {
    if (price == 0) return false;
    if (image.isEmpty) return false;
    if (brand.isEmpty) return false;
    if (model.isEmpty) return false;
    if (description.isEmpty) return false;
    return true;
  }

  @override
  String toString() {
    return 'ProductsModel{uuid: $uuid, brand: $brand, model: $model, description: $description, price: $price, image: $image}';
  }
}
