class ProductModel {
  String? id;
  String? productName;
  String? productCode;
  String? image;
  String? unitPrice;
  String? quantity;
  String? totalPrice;

  ProductModel.fromJson(Map<String, dynamic> json){
    id = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    image = json['Img'];
    unitPrice= json['UnitPrice'];
    quantity = json['Qty'];
    totalPrice = json['TotalPrice'];
  }

  // ProductModel.fromJson(Map<String, dynamic> json){
  //   id = json['_id'] ?? '';
  //   productName = json['ProductName'] ?? '';
  //   productCode = json['ProductCode'] ?? '';
  //   image = json['Img'] ?? '';
  //   unitPrice= json['UnitPrice'] ?? '';
  //   quantity = json['Qty'] ?? '';
  //   totalPrice = json['TotalPrice'] ?? '';
  // }


  // ProductModel(
  //     {required this.id,
  //     required this.productName,
  //     required this.productCode,
  //     required this.image,
  //     required this.unitPrice,
  //     required this.quantity,
  //     required this.totalPrice});
}
