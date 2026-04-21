import '../models/product.dart';
import '../models/alert.dart';

final List<Product> mockProducts = [
  const Product(id: '1', name: 'Wireless Earbuds Pro', sku: 'WEP-001', category: 'Electronics', stock: 4, lowThreshold: 10, criticalThreshold: 5, price: 49.99, imageEmoji: '🎧'),
  const Product(id: '2', name: 'Yoga Mat Premium', sku: 'YMP-042', category: 'Sports', stock: 23, lowThreshold: 15, criticalThreshold: 5, price: 34.99, imageEmoji: '🧘'),
  const Product(id: '3', name: 'Stainless Water Bottle', sku: 'SWB-110', category: 'Kitchen', stock: 2, lowThreshold: 10, criticalThreshold: 3, price: 24.99, imageEmoji: '🍶'),
  const Product(id: '4', name: 'LED Desk Lamp', sku: 'LDL-007', category: 'Home Office', stock: 8, lowThreshold: 10, criticalThreshold: 3, price: 39.99, imageEmoji: '💡'),
  const Product(id: '5', name: 'Resistance Band Set', sku: 'RBS-205', category: 'Sports', stock: 45, lowThreshold: 15, criticalThreshold: 5, price: 19.99, imageEmoji: '🏋️'),
  const Product(id: '6', name: 'Laptop Stand Aluminium', sku: 'LSA-301', category: 'Home Office', stock: 1, lowThreshold: 8, criticalThreshold: 2, price: 59.99, imageEmoji: '💻'),
  const Product(id: '7', name: 'Ceramic Pour-Over Set', sku: 'CPO-088', category: 'Kitchen', stock: 17, lowThreshold: 12, criticalThreshold: 4, price: 44.99, imageEmoji: '☕'),
  const Product(id: '8', name: 'Foam Roller Deep Tissue', sku: 'FRD-410', category: 'Sports', stock: 6, lowThreshold: 10, criticalThreshold: 3, price: 27.99, imageEmoji: '🪵'),
  const Product(id: '9', name: 'USB-C Hub 7-in-1', sku: 'UCH-712', category: 'Electronics', stock: 30, lowThreshold: 15, criticalThreshold: 5, price: 54.99, imageEmoji: '🔌'),
  const Product(id: '10', name: 'Bamboo Cutting Board', sku: 'BCB-099', category: 'Kitchen', stock: 11, lowThreshold: 12, criticalThreshold: 4, price: 22.99, imageEmoji: '🪵'),
];

List<StockAlert> generateAlerts(List<Product> products) {
  final alerts = <StockAlert>[];
  for (final product in products) {
    if (product.status == StockStatus.critical) {
      alerts.add(StockAlert(
        id: 'alert_${product.id}_critical',
        productId: product.id,
        productName: product.name,
        type: AlertType.critical,
        message: '${product.name} is critically low (${product.stock} units left). Reorder immediately.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
      ));
    } else if (product.status == StockStatus.low) {
      alerts.add(StockAlert(
        id: 'alert_${product.id}_low',
        productId: product.id,
        productName: product.name,
        type: AlertType.low,
        message: '${product.name} is running low (${product.stock} units left).',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ));
    }
  }
  return alerts;
}
