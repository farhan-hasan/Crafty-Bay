import 'package:crafty_bay/presentation/screens/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/screens/email_verification_screen.dart';
import 'package:crafty_bay/presentation/state_holders/category_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/home_slider_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/user_auth_controller.dart';
import 'package:crafty_bay/presentation/utility/assets_path.dart';
import 'package:crafty_bay/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../data/models/category.dart';
import '../../data/models/product.dart';
import '../widgets/app_bar_button_builder.dart';
import '../widgets/category_item.dart';
import '../widgets/home_carousel_slider.dart';
import '../widgets/product_card.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTEC = TextEditingController();
  final HomeSliderController _homeSliderController =
      Get.find<HomeSliderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildSearchTextField(),
              const SizedBox(height: 1),
              GetBuilder<HomeSliderController>(builder: (sliderController) {
                if (sliderController.inProgress) {
                  return const SizedBox(
                      height: 200, child: CenteredCircularProgressIndicator());
                }
                return HomeCarouselSlider(
                    sliderList: sliderController.sliderList);
              }),
              const SizedBox(height: 16),
              SectionHeader(
                title: "All Categories",
                onTapSeeAll: () {
                  Get.find<MainBottomNavBarController>().selectCategory();
                },
              ),
              const SizedBox(height: 10),
              GetBuilder<CategoryListController>(
                  builder: (categoryListController) {
                if (categoryListController.inProgress) {
                  return const SizedBox(
                      height: 100, child: CenteredCircularProgressIndicator());
                }
                return _buildCategoryListView(
                    categoryListController.categoryList);
              }),
              const SizedBox(height: 8),
              SectionHeader(
                title: "Popular",
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 10),
              GetBuilder<PopularProductListController>(
                  builder: (popularProductListController) {
                if (popularProductListController.popularProductInProgress) {
                  return const SizedBox(
                      height: 210, child: CenteredCircularProgressIndicator());
                }
                return _buildProductListView(
                    popularProductListController.popularProductList);
              }),
              const SizedBox(height: 8),
              SectionHeader(
                title: "Special",
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 10),
              GetBuilder<SpecialProductListController>(
                  builder: (specialProductListController) {
                    if (specialProductListController.specialProductInProgress) {
                      return const SizedBox(
                          height: 210, child: CenteredCircularProgressIndicator());
                    }
                return _buildProductListView(
                    specialProductListController.specialProductList);
              }),
              const SizedBox(height: 8),
              SectionHeader(
                title: "New",
                onTapSeeAll: () {},
              ),
              const SizedBox(height: 10),
              GetBuilder<NewProductListController>(
                  builder: (newProductListController) {
                    if (newProductListController.newProductInProgress) {
                      return const SizedBox(
                          height: 210, child: CenteredCircularProgressIndicator());
                    }
                return _buildProductListView(
                    newProductListController.newProductList);
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryListView(List<Category> categoryList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryList.map((e) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CategoryItem(category: e),
            const SizedBox(width: 16,)
          ],
        )).toList(),
      ),
    );
  }

  Widget _buildProductListView(List<Product> productList) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: productList.map((e) => ProductCard(product: e)).toList()
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return TextField(
      controller: _searchTEC,
      decoration: InputDecoration(
          hintText: "Search",
          fillColor: Colors.grey.shade200,
          filled: true,
          prefixIcon: const Icon(Icons.search),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(8))),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.appNavLogoSvg),
      actions: [
        AppBarButtonBuilder(
          icon: Icons.person,
          onTap: () {},
        ),
        const SizedBox(
          width: 8,
        ),
        AppBarButtonBuilder(
          icon: Icons.call,
          onTap: () {},
        ),
        const SizedBox(
          width: 8,
        ),
        AppBarButtonBuilder(
          icon: Icons.notification_add_outlined,
          onTap: () {},
        )
      ],
    );
  }

  @override
  void dispose() {
    _searchTEC.dispose();
    super.dispose();
  }
}
