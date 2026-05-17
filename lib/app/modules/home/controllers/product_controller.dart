import 'package:get/get.dart';
import 'package:b_m_digital_utilization/core/models/product_model.dart';
import 'package:b_m_digital_utilization/data/services/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();

  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> products = <ProductModel>[].obs;
  final Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final productList = await _productService.fetchProducts();
      allProducts.assignAll(productList);
      products.assignAll(productList);
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      products.clear();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductDetail(int productId) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final product = await _productService.fetchProductDetail(productId);
      selectedProduct.value = product;
    } catch (e) {
      errorMessage.value = 'Error: ${e.toString()}';
      selectedProduct.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  void clearError() {
    errorMessage.value = '';
  }

  void searchProducts(String query) {
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      products.assignAll(allProducts);
      return;
    }

    final lowerQuery = query.toLowerCase();
    final filtered = allProducts.where((product) {
      final title = product.title?.toLowerCase() ?? '';
      final category = product.category?.toLowerCase() ?? '';
      final description = product.description?.toLowerCase() ?? '';
      return title.contains(lowerQuery) ||
          category.contains(lowerQuery) ||
          description.contains(lowerQuery);
    }).toList();

    products.assignAll(filtered);
  }
}
