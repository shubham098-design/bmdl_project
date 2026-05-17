class APIConstant {
  static const String baseUrl = 'https://fakestoreapi.com';
  static const String products = '/products';
  static const String productDetail = '/products';

  static String getProductDetail(int productId) => '$productDetail/$productId';
}
