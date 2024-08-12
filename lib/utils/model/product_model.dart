class ProductModel {
  String name;
  String price;
  String quantity;
  String total;
  String image;

  ProductModel({
    required this.name,
    required this.price,
    required this.quantity,
    required this.total,
    required this.image,
  });

  factory ProductModel.fromMap({required Map<String, dynamic> map}) {
    return ProductModel(
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      total: map['total'],
      image: map['image'],
    );
  }
}
