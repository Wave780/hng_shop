import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hng_shop/model/product.dart';

import 'package:hng_shop/utils/product_card.dart';
import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.onAddProduct});
  final void Function(Product) onAddProduct;
  @override
  State<ProductScreen> createState() =>
      _ProductScreenState(onAddProduct: onAddProduct);
}

class _ProductScreenState extends State<ProductScreen> {
  Product product = Product();
  final void Function(Product) onAddProduct;
  bool isLoading = false;

  _ProductScreenState({required this.onAddProduct});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        'https://api.timbu.cloud/products?organization_id=cafee00fa441483a868b09a960c01597&reverse_sort=false&page=1&size=10&Appid=MGKGYF5WAL97SLL&Apikey=98b8d0d32e134feaa5fe6e49eb944d2c20240704223304884920');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      final jsonData = jsonDecode(response.body);
      log("$jsonData");
      product = Product.fromJson(jsonData);
      if (jsonData != null) {
        setState(() {
          jsonData;
        });
      } else {
        const Text('No data received from the API.');
      }
    }
  }

  static const snackBar = SnackBar(content: Text('Checkout Cart'));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading ? const CircularProgressIndicator() : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      scrollDirection: Axis.vertical,
      itemCount: product.items?.length,
      itemBuilder: (context, index) {
        final photoUrl = (product.items?[index].photos != null &&
                product.items![index].photos!.isNotEmpty)
            ? product.items![index].photos!.first.url
            : "No image";
        const img = "http://api.timbu.cloud/images/";
        final priceList =
            product.items?[index].currentPrice?.first.price?["NGN"] ?? [];
        final priceString =
            priceList.isNotEmpty ? priceList.first.toString() : "Free";
        return ProductCard(
          img: img,
          photoUrl: photoUrl,
          product: product,
          priceString: priceString,
          snackBar: snackBar,
          onAddProduct: onAddProduct,
          name: product.items?[index].name ?? 'Invalid', discription: product.items?[index].description ?? "None",
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisExtent: 230,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}
