import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utility/app_colors.dart';

class ProductImageCarouselSlider extends StatefulWidget {
  const ProductImageCarouselSlider({
    super.key, required this.images,
  });
  
  final List<String> images;

  @override
  State<ProductImageCarouselSlider> createState() =>
      _ProductImageCarouselSliderState();
}

class _ProductImageCarouselSliderState
    extends State<ProductImageCarouselSlider> {
  final ValueNotifier<int> _selectedCarouselIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          _buildCarouselSlider(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 8,
            child: _buildCarouselIndicator(),
          )
        ]),
      ],
    );
  }

  CarouselSlider _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          height: 220.0,
          onPageChanged: (index, _) {
            _selectedCarouselIndex.value = index;
          }),
      items: widget.images.map((image) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                ),
                alignment: Alignment.center,
                child: Image.network(image, fit: BoxFit.cover,));
          },
        );
      }).toList(),
    );
  }

  ValueListenableBuilder<int> _buildCarouselIndicator() {
    return ValueListenableBuilder(
        valueListenable: _selectedCarouselIndex,
        builder: (context, currentPage, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.images.length; i++)
                Container(
                  width: 12,
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                      color: i == currentPage
                          ? AppColors.primaryColor
                          : Colors.white,
                      border: Border.all(
                          color: i == currentPage
                              ? AppColors.primaryColor
                              : Colors.white,
                          width: 1),
                      borderRadius: BorderRadius.circular(50)),
                )
            ],
          );
        });
  }
}
