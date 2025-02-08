import 'package:crud_app_api/add_product_screen.dart';
import 'package:crud_app_api/update_product_screen.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
      ),
      body: ListView.separated(
        itemCount: 5,
        itemBuilder: (context, index) {
          return _buildProductItem();
        },
        separatorBuilder: (context, index) => const Divider(),
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

  Widget _buildProductItem() {
    return ListTile(
      leading: Image.network(
        'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/92d0dc75-6749-4d04-955f-911a8edce5c8/NIKE+FREE+METCON+6.png',
        height: 60,
      ),
      title: const Text("Product Name"),
      subtitle: Wrap(spacing: 16, children: [
        Text('Unit Price: 100'),
        Text('Quantity: 100'),
        Text('Total Price: 100'),
      ]),
      trailing: Wrap(
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdateProductScreen()));
              },
              icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog();
              },
              icon: Icon(Icons.delete)),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog() {
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
                    Navigator.pop(context);
                  },
                  child: Text('Yes, delete')),
            ],
          );
        });
  }
}
