import 'package:flutter/material.dart';
import 'package:hng_shop/model/product.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.img,
    required this.photoUrl,
    required this.product,
    required this.priceString,
    required this.snackBar,
    required this.onAddProduct,
    required this.name,
    required this.discription,
  });
  final String name;
  final String discription;
  final String img;
  final String? photoUrl;
  final Product product;
  final String priceString;
  final SnackBar snackBar;

  final void Function(Product) onAddProduct;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add some padding inside the card
        child: Column(
          children: [
            ClipRRect(
              // Add rounded corners to the image
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                img + photoUrl!,
                height: 70,
                width: 70,
                fit: BoxFit.cover, // Ensure image fills the container
              ),
            ),

            Text(
              name,
              style:
                  const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
                height: 2.0), // Add spacing between name and description
            Text(
              discription,
              softWrap: true,
              style: const TextStyle(fontSize: 14.0),
            ),
            const SizedBox(
                height: 2.0), // Add spacing between description and price
            Row(
              children: [
                Text(
                  formatBalance(priceString),
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      onAddProduct(product);
                    },
                    icon: const Icon(
                      Icons.shopping_cart,
                      color: Colors.green,
                    )),
              ],
            )
          ],
        ),
      ),
    ));
  }
}

String formatBalance(String balance, {bool noShowNaira = false}) {
  // Convert the balance string to a double
  final balanceValue = double.tryParse(balance);

  if (balanceValue != null) {
    // Create a NumberFormat instance with the desired formatting
    final formatter = NumberFormat.currency(
      symbol: !noShowNaira
          ? '₦'
          : '', // Set the currency symbol if needed (e.g., '$')
      decimalDigits: 2, // Set the number of decimal places
    );

    // Format the balance value
    final formattedBalance = formatter.format(balanceValue);

    return formattedBalance;
  }

  // Return the original balance string if it couldn't be parsed as a double
  return balance;
}
