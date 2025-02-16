import 'dart:convert';

import 'package:crud_app_api/add_product_screen.dart';
import 'package:crud_app_api/product_model.dart';
import 'package:crud_app_api/update_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  bool _getProductListInProgress = false;
  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: RefreshIndicator(
        // onRefresh: () async{
        //   _getProductList();
        // },
        onRefresh: _getProductList,
        child: Visibility(
          visible: _getProductListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return _buildProductItem(productList[index]);
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddProductScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async {
    productList.clear();
    _getProductListInProgress = true;
    setState(() {});

    const String getProductLisUrl =
        'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(getProductLisUrl);

    Response response = await get(uri);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      //data decode
      final decodedData = jsonDecode(response.body);
      //get the list
      /* List<Map<String, dynamic>> jsonProductList = decodedData['data']; */
      final jsonProductList = decodedData['data'];
      //loop over the list
      for (Map<String, dynamic> json in jsonProductList) {
        // Product product = Product(
            // id: p['_id'] ?? '',
            // productName: p['ProductName'] ?? 'Unknown',
            // productCode: p['ProductCode'] ?? '',
            // image: p['Img'] ?? 'No Image',
            // unitPrice: p['UnitPrice'] ?? '',
            // quantity: p['Qty'] ?? '',
            // totalPrice: p['TotalPrice'] ?? '');
        ProductModel productModel = ProductModel.fromJson(json);
        productList.add(productModel);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Get product list failed! try again')));
    }

    _getProductListInProgress = false;
    setState(() {});
  }

  Widget _buildProductItem(ProductModel product) {
    return ListTile(
      //leading: Image.network(product.image, height: 60, width: 60,),
      // leading: Image.network(
      //   'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/92d0dc75-6749-4d04-955f-911a8edce5c8/NIKE+FREE+METCON+6.png',
      //   height: 60,
      // ),
      title: Text(
        product.productName ?? 'Unknown',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      subtitle: Wrap(spacing: 16, children: [
        Text('Unit Price: ${product.unitPrice}'),
        Text('Quantity: ${product.unitPrice}'),
        Text('Total Price: ${product.totalPrice}'),
      ]),
      trailing: Wrap(
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async{
              final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateProductScreen(
                            product: product,
                          )));
              if (result == true ) {
                _getProductList();
              }
            },
          ),
          IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog(product.id!);
              },
              icon: Icon(Icons.delete)),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(String productId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Delete'),
            content: Text('Are you sure that you want to delete this product'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    _deleteProduct(productId);
                    Navigator.pop(context);
                  },
                  child: Text('Yes, delete')),
            ],
          );
        });
  }


  Future<void> _deleteProduct(String productId) async {
    _getProductListInProgress = true;
    setState(() {});

   String deleteProductUrl =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/$productId';
    Uri uri = Uri.parse(deleteProductUrl);

    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _getProductList();
    } else {
      _getProductListInProgress = false;
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Delete product failed! try again')));
    }
  }
}
