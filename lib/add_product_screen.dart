import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                      InputDecoration(hintText: 'Name', labelText: 'Name'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your product name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _productCodeTEController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                      InputDecoration(hintText: 'Product Code', labelText: 'Product Code'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your product code';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Unit Price', labelText: 'Unit Price'),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your product unit price';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your product quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: 'Total Price',
                    labelText: 'Total Price',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Write your product total price';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _imageTEController,
                  decoration: InputDecoration(
                    hintText: 'Image',
                    labelText: 'Image',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Input your image';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _addProduct();
                      }
                    },
                    child: Text('Add'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  //URI = Uniform Resource Identifier
  //Future, async, await
  Future<void> _addProduct() async {
    //Step 1: set url
    const String addNewProductUrl =
        'https://crud.teamrabbil.com/api/v1/CreateProduct';

    //step 2: prepare data
    Map<String, dynamic> inputData = {
      "Img": _imageTEController.text.trim(),
      "ProductCode": _productCodeTEController.text,
      "ProductName": _nameTEController.text,
      "Qty": _quantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
      "UnitPrice": _unitPriceTEController.text
    };

    //Step 3: Parse
    Uri uri = Uri.parse(addNewProductUrl);
    //Step 4: Send Request
    Response response = await post(uri,
        body: jsonEncode(inputData),
        headers: {'content-type': 'application/json'});
    print(response.statusCode);
    print(response.body);
    print(response.headers);

    if(response.statusCode == 200){
      _imageTEController.clear();
      _productCodeTEController.clear();
      _nameTEController.clear();
      _quantityTEController.clear();
      _totalPriceTEController.clear();
      _unitPriceTEController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('New product added!')),
      );
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Add new product failed!')),
      );
    }

    // TODO: Form Clean
    // TODO: Add Button in progress
    // TODO: Toast / snackbar message
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _unitPriceTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
    super.dispose();
  }
}
