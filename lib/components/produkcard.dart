import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.press,
    required this.bgColor,
  }) : super(key: key);
  final String image, title;
  final VoidCallback press;
  final int price;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        width: 154,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: Image.network(
                image,
                fit: BoxFit.contain,
                height: 120,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(

                    children: [
                      Text(
                        title,
                        style: const TextStyle(color: Colors.black),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Rp ${NumberFormat('###,###,###,###', "ar_DZ").format(price)}",
                        style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.left
                      ),
                    ],
                  )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
