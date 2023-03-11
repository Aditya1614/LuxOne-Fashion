import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerList extends StatelessWidget {
  const BannerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('banner').snapshots(),
      builder: ((context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListBanner(itemBanner: snapshot.data!.docs);
      }),
    );
  }
}

class ListBanner extends StatefulWidget {
  final List<DocumentSnapshot> itemBanner;
  const ListBanner({super.key, required this.itemBanner});

  @override
  State<ListBanner> createState() => _ListBannerState();
}

class _ListBannerState extends State<ListBanner> {
  final controller = PageController(viewportFraction: 0.8, keepPage: true);

  @override
  Widget build(BuildContext context) {
    var image = <String>[];
    for (int i = 0; i < widget.itemBanner.length; i++) {
      image.add(widget.itemBanner[i]['image']);
    }
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
          ),
          items: image
              .map((item) => Center(
                      child: Image.network(
                    item,
                    fit: BoxFit.cover,
                  ))
          )
              .toList(),
        ),
        SizedBox(
          height: 10,
        ),
        SmoothPageIndicator(
          controller: controller,
          count: widget.itemBanner.length,
          effect: WormEffect(
            dotHeight: 12,
            dotWidth: 12,
            type: WormType.thin,
            // strokeWidth: 5,
          ),
        )

      ],
    );
  }
}
