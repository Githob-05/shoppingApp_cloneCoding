import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_j/models/product.dart';
import 'constants.dart';

class ItemCheckoutPage extends StatefulWidget {
  const ItemCheckoutPage({super.key});

  @override
  State<ItemCheckoutPage> createState() => _ItemCheckoutPageState();
}

class _ItemCheckoutPageState extends State<ItemCheckoutPage> {
  List<Product> checkoutList = [
    Product(
        productNo: 1,
        productName: "노트북(Laptop)",
        productImageUrl: "https://picsum.photos/id/1/300/300",
        price: 600000),
    Product(
        productNo: 4,
        productName: "키보드(Keyboard)",
        productImageUrl: "https://picsum.photos/id/60/300/300",
        price: 50000),
  ];

  List<Map<int, int>> quantityList = [
    {1: 2},
    {4: 3},
  ];

  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < checkoutList.length; i++) {
      totalPrice +=
          checkoutList[i].price! * quantityList[i][checkoutList[i].productNo]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("결제시작"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: checkoutList.length,
        itemBuilder: (context, index) {
          return checkoutContainer(
            productNo: checkoutList[index].productNo ?? 0,
            productName: checkoutList[index].productName ?? "",
            productImageUrl: checkoutList[index].productImageUrl ?? "",
            price: checkoutList[index].price ?? 0,
            quantity: quantityList[index][checkoutList[index].productNo] ?? 0,
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          onPressed: () {},
          child: Text("총 ${numberFormat.format(totalPrice)}원 결제하기"),
        ),
      ),
    );
  }

  Widget checkoutContainer({
    required int productNo,
    required String productName,
    required String productImageUrl,
    required double price,
    required int quantity,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: productImageUrl,
            width: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Text("error"),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text("${numberFormat.format(price)}원"),
                Text("수량: $quantity"),
                Text("합계: ${numberFormat.format(price * quantity)}원"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
