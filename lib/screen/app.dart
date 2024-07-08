import 'package:flutter/material.dart';
import 'package:hng_shop/model/product.dart';
import 'package:hng_shop/screen/cart.dart';
import 'package:hng_shop/screen/order.dart';
import 'package:hng_shop/screen/product.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Product> checkoutProduct = [];
  int selectedIndex = 0;

   void onTapItem(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  void addProduct(Product product) {
    setState(() {
      checkoutProduct.add(product);
    });
  }

  void removeProduct(Product product) {
    setState(() {
      checkoutProduct.remove(product);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('HNG SHOP')),
        body: buildUI(),bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket_rounded),
              label: 'Cart',
            ),
          ],
          currentIndex: selectedIndex,
          onTap: onTapItem,
        ));
  }
  Widget buildUI(){
      
    return IndexedStack(
          index: selectedIndex,
          children: [
             ProductScreen(onAddProduct: addProduct),
            CartScreen(checkoutProduct: checkoutProduct, removeProduct: removeProduct, orderSuccess: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return const OrderScreen();
                  }));
                })
          ],
        );
        
  }
}
