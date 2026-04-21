import 'package:flutter/material.dart';

enum AlertType { low, critical, restock }

class StockAlert {
  final String id;
  final String productId;
  final String productName;
  final AlertType type;
  final String message;
  final DateTime timestamp;
  bool isRead;

  StockAlert({
    required this.id,
    required this.productId,
    required this.productName,
    required this.type,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  Color get color {
    switch (type) {
      case AlertType.low: return const Color(0xFFEF9F27);
      case AlertType.critical: return const Color(0xFFE24B4A);
      case AlertType.restock: return const Color(0xFF1D9E75);
    }
  }

  IconData get icon {
    switch (type) {
      case AlertType.low: return Icons.warning_amber_rounded;
      case AlertType.critical: return Icons.error_rounded;
      case AlertType.restock: return Icons.check_circle_rounded;
    }
  }
}
