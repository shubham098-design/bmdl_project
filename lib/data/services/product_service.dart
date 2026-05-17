import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:b_m_digital_utilization/core/constants/api_constants.dart';
import 'package:b_m_digital_utilization/core/models/product_model.dart';

class ProductService {
  Future<List<ProductModel>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse('${APIConstant.baseUrl}${APIConstant.products}'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList =
            jsonDecode(response.body) as List<dynamic>;
        return jsonList
            .map((item) => ProductModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ProductModel> fetchProductDetail(int productId) async {
    try {
      final response = await http
          .get(
            Uri.parse(
              '${APIConstant.baseUrl}${APIConstant.getProductDetail(productId)}',
            ),
          )
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () => throw Exception('Request timeout'),
          );

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as Map<String, dynamic>;
        return ProductModel.fromJson(jsonData);
      } else {
        throw Exception(
          'Failed to load product detail: ${response.statusCode}',
        );
      }
    } catch (e) {
      rethrow;
    }
  }
}
