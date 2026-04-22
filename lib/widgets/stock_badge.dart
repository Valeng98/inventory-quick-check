import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

class StockBadge extends StatelessWidget {
  final StockStatus status;
  final String? label;
  final bool compact;

  const StockBadge({super.key, required this.status, this.label, this.compact = false});

  Color get _color {
    switch (status) {
      case StockStatus.ok: return AppTheme.accent;
      case StockStatus.low: return AppTheme.amber;
      case StockStatus.critical: return AppTheme.red;
    }
  }

  String get _label {
    switch (status) {
      case StockStatus.ok: return 'In Stock';
      case StockStatus.low: return 'Low';
      case StockStatus.critical: return 'Critical';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: compact ? 8 : 10, vertical: compact ? 3 : 5),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 6, height: 6, decoration: BoxDecoration(color: _color, shape: BoxShape.circle)),
          const SizedBox(width: 6),
          Text(label ?? _label, style: TextStyle(color: _color, fontSize: compact ? 11 : 12, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
