import 'package:flutter/material.dart';
import 'package:hng_shop/model/product.dart';
import 'package:hng_shop/screen/order.dart';

class CartScreen extends StatefulWidget {
  final List<Product> checkoutProduct;
  final void Function(Product) removeProduct;
  final VoidCallback orderSuccess;
  const CartScreen(
      {super.key,
      required this.checkoutProduct,
      required this.removeProduct,
      required this.orderSuccess});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isShowingLoadingDialog = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: buildUI(),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: const Center(child: Text('Cart')),
    );
  }

  Widget buildUI() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      widget.checkoutProduct.isEmpty
          ? Expanded(
              child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("image/image 13.png"),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    'Empty Cart',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ))
          : Expanded(
              child: ListView.builder(
                  itemCount: widget.checkoutProduct.length,
                  itemBuilder: (context, int index) {
                    final photoUrl =
                        (widget.checkoutProduct[index].items?[index].photos !=
                                    null &&
                                widget.checkoutProduct[index].items![index]
                                    .photos!.isNotEmpty)
                            ? widget.checkoutProduct[index].items![index]
                                .photos!.first.url
                            : "No image";
                    const img = "http://api.timbu.cloud/images/";
                    final item = widget.checkoutProduct[index];
                    return Dismissible(
                      key: ValueKey(item),
                      onDismissed: (direction) {
                        setState(() {
                          widget.removeProduct(item);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text(' Deleted ')));
                      },
                      child: ListTile(
                        subtitle: Text(
                            widget.checkoutProduct[index].items?[index].name ??
                                'No name '),
                        leading: Image.network(
                          img + photoUrl!,
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.payment_sharp),
                          onPressed: () async {
                            if (!isShowingLoadingDialog) {
                              setState(() {
                                isShowingLoadingDialog = true;
                              });

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  });

                              await Future.delayed(const Duration(seconds: 2));

                              widget
                                  .removeProduct(widget.checkoutProduct[index]);

                              Navigator.pop(context);
                              setState(() {
                                isShowingLoadingDialog = false;
                              });
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return const OrderScreen();
                              }));
                            }
                          },
                        ),
                      ),
                    );
                  }))
    ]);
  }
}
