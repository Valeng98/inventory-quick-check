import 'package:flutter/foundation.dart';
import '../models/product.dart';
import '../models/alert.dart';
import '../data/mock_data.dart';

class InventoryProvider extends ChangeNotifier {
  List<Product> _products = List.from(mockProducts);
  String _searchQuery = '';
  String _selectedCategory = 'All';
  StockStatus? _filterStatus;

  List<Product> get products => _filteredProducts;
  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;
  StockStatus? get filterStatus => _filterStatus;

  List<String> get categories {
    final cats = _products.map((p) => p.category).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  List<StockAlert> get alerts => generateAlerts(_products);
  int get unreadAlertCount => alerts.where((a) => !a.isRead).length;

  int get totalProducts => _products.length;
  int get okCount => _products.where((p) => p.status == StockStatus.ok).length;
  int get lowCount => _products.where((p) => p.status == StockStatus.low).length;
  int get criticalCount => _products.where((p) => p.status == StockStatus.critical).length;

  List<Product> get _filteredProducts {
    return _products.where((p) {
      final matchSearch = _searchQuery.isEmpty ||
          p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.sku.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchCategory = _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchStatus = _filterStatus == null || p.status == _filterStatus;
      return matchSearch && matchCategory && matchStatus;
    }).toList();
  }

  void setSearch(String query) { _searchQuery = query; notifyListeners(); }
  void setCategory(String category) { _selectedCategory = category; notifyListeners(); }
  void setFilterStatus(StockStatus? status) { _filterStatus = status; notifyListeners(); }

  void updateStock(String productId, int newStock) {
    final index = _products.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _products[index] = _products[index].copyWith(stock: newStock);
      notifyListeners();
    }
  }
}
