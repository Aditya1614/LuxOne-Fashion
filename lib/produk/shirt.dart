import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../components/section_title.dart';
import '../components/produkcard.dart';

class Shirt extends StatelessWidget {
  const Shirt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 8, bottom: 16),
          child: SectionTitle(
            title: 'Gaun',
            pressSeeAll: () {
              Navigator.of(context, rootNavigator: true)
                  .pushNamed('/lihatsemua');
            },
          ),
        ),
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('product').snapshots(),
            builder: ((context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: List.generate(
                      snapshot.data!.docs.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ProductCard(
                          title: snapshot.data!.docs[index]['title'],
                          image: snapshot.data!.docs[index]['image'],
                          price: snapshot.data!.docs[index]['price'],
                          bgColor: const Color(0xFFEFEFF2),
                          press: () {
                            Navigator.of(context, rootNavigator: true)
                                .pushNamed('/detailScreen', arguments: index);
                          },
                        ),
                      ),
                    ),
                  ));
            }),
          ),
        )
      ],
    );
  }
}
