import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/languages_controller.dart';
import '../../controllers/products_controller.dart';
import '../../routes/app_routes.dart';

class ProductsView extends StatefulWidget {
  @override
  _ProductsViewState createState() => _ProductsViewState();
}

HomeController homeController = HomeController();

class _ProductsViewState extends State<ProductsView> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProductsController());
    ProductsController productsController = ProductsController();
    return Scaffold(
        appBar: _buildAppBar(),
        backgroundColor: Colors.grey[100],
        body: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Expanded(
                child: Obx(
                  () {
                    if (productsController.loading.value) {
                      return Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: Color(0xFFAD1917),
                          size: 80,
                        ),
                      );
                    }
                    if (Get.find<ProductsController>().products.isEmpty) {
                      return Center(
                          child: Container(
                        width: Get.width * 0.44,
                        height: Get.height * 0.44,
                        child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text("No_Products_found".tr,
                                style: TextStyle(fontWeight: FontWeight.w600))),
                      ));
                    }

                    return GridView.builder(
                      padding: EdgeInsets.only(top: 11),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: productsController.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(8), // if you need this
                            side: BorderSide(
                              color: Colors.grey.withOpacity(.2),
                              width: 2,
                            ),
                          ),
                          elevation: 0.0,
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.detailsPage, arguments: {
                                'title': productsController.products[index].name
                                    .toString(),
                                'image':
                                    productsController.imagePath().toString() +
                                        productsController.products[index].image
                                            .toString(),
                                'text': productsController.products[index].body
                                    .toString()
                              });
                            },
                            child: Container(
                              height: Get.height * 0.21,
                              child: Column(
                                children: [
                                  Container(
                                    height: Get.height * 0.21,
                                    width: Get.width,
                                    child: Image.network(
                                      productsController
                                              .imagePath()
                                              .toString() +
                                          productsController
                                              .products[index].image
                                              .toString(), // Replace with your HTTPS URL
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        productsController.products[index].image
                                            .toString();
                                        return Text('Failed to load image');
                                      },
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    width: Get.width,
                                    child: Text(
                                      productsController.products[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: Get.size.height * 0.1,
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 199, 207, 189),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.15
                : Get.width * 0.15,
            child: Obx(
              () => Image.network(
                homeController.logoSite.value.toString(),
                fit: BoxFit.contain,
              ),
              // ),
            ),
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.2
                : Get.width * 0.2,
          ),
          Container(
            width: Get.find<LanguageController>().savedLang.value == 'AR'
                ? Get.width * 0.25
                : Get.width * 0.28,
            child: FittedBox(
                fit: BoxFit.contain,
                child: Text("Products".tr,
                    style: TextStyle(
                        color: Color(0xFFAD1917),
                        fontWeight: FontWeight.w900))),
          ),
        ],
      ),
    );
  }
}
