import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:crafty_bay/presentation/widgets/network_image_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../data/models/slider_data.dart';
import '../utility/app_colors.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
    required this.sliderList,
  });

  final List<SliderData> sliderList;

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedCarouselIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        const SizedBox(
          height: 8,
        ),
        _buildCarouselIndicator()
      ],
    );
  }

  CarouselSlider _buildCarouselSlider() {
    return CarouselSlider(
      options: CarouselOptions(
          viewportFraction: 1,
          height: 180.0,
          onPageChanged: (index, _) {
            _selectedCarouselIndex.value = index;
          }),
      items: widget.sliderList.map((slider) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: NetWorkImageWidget(
                          url: slider.image ?? '',
                          width: double.maxFinite,
                          height: double.maxFinite,
                          boxFit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: _buildSliderProdectDescription(slider),
                    )
                  ],
                ));
          },
        );
      }).toList(),
    );
  }

  Widget _buildSliderProdectDescription(SliderData slider) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            slider.title ?? '',
            style: const TextStyle(
                fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Text(
            slider.shortDes ?? '',
            maxLines: 3,
            style: const TextStyle(
                color: Colors.black, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
              width: 100,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      textStyle:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  onPressed: () {},
                  child: const Text("Buy now")))
        ],
      ),
    );
  }

  ValueListenableBuilder<int> _buildCarouselIndicator() {
    return ValueListenableBuilder(
        valueListenable: _selectedCarouselIndex,
        builder: (context, currentPage, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < widget.sliderList.length; i++)
                Container(
                  width: 15,
                  height: 15,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                      color: i == currentPage ? AppColors.primaryColor : null,
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(50)),
                )
            ],
          );
        });
  }
}
