enum StockStatus { ok, low, critical }

class Product {
  final String id;
  final String name;
  final String sku;
  final String category;
  final int stock;
  final int lowThreshold;
  final int criticalThreshold;
  final double price;
  final String imageEmoji;

  const Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.stock,
    required this.lowThreshold,
    required this.criticalThreshold,
    required this.price,
    required this.imageEmoji,
  });

  StockStatus get status {
    if (stock <= criticalThreshold) return StockStatus.critical;
    if (stock <= lowThreshold) return StockStatus.low;
    return StockStatus.ok;
  }

  String get statusLabel {
    switch (status) {
      case StockStatus.ok: return 'In Stock';
      case StockStatus.low: return 'Low Stock';
      case StockStatus.critical: return 'Critical';
    }
  }

  Product copyWith({int? stock}) {
    return Product(
      id: id, name: name, sku: sku, category: category,
      stock: stock ?? this.stock,
      lowThreshold: lowThreshold, criticalThreshold: criticalThreshold,
      price: price, imageEmoji: imageEmoji,
    );
  }
}
