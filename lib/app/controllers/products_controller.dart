import 'package:get/get.dart';
import 'package:neecoder/app/data/repositories/products_repository.dart';

class ProductsController extends GetxController {
  ProductsRepository productsRepository = ProductsRepository();
  RxBool loading = false.obs;
  RxList products = [].obs as RxList<dynamic>;
  var showGrid = false.obs;

  ProductsController() {
    loadProductsFromRepo();
    imagePath();
  }

  loadProductsFromRepo() async {
    loading(true);
    products.value = await productsRepository.loadProductsFromApi();
    loading(false);
  }

  toggleGrid() {
    showGrid(!showGrid.value);
  }

  imagePath() {
    return productsRepository.imagePath;
  }
}
