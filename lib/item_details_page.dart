import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_j/item_basket_page.dart';
import 'package:project_j/models/product.dart';
import 'constants.dart';

class ItemDetailsPage extends StatefulWidget {
  int productNo;
  String productName;
  String productImageUrl;
  double price;

  ItemDetailsPage(
      {super.key,
      required this.productNo,
      required this.productName,
      required this.productImageUrl,
      required this.price});

  @override
  State<ItemDetailsPage> createState() => _ItemDetailsPageState();
}

class _ItemDetailsPageState extends State<ItemDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("제품 상세 페이지"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(15),
              child: CachedNetworkImage(
                width: MediaQuery.of(context).size.width * 0.8,
                imageUrl: widget.productImageUrl,
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return const Center(
                    child: Text("error"),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                widget.productName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "${numberFormat.format(widget.price)}원",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
          //! 추후 장바구니 담는 로직 추가 예정

          //! 장바구니 페이지 이동
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return const ItemBasketPage();
                },
              ),
            );
          },
          child: const Text("장바구니 담기"),
        ),
      ),
    );
  }
}
