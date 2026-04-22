import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../data/inventory_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/stock_badge.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late TextEditingController _stockController;

  @override
  void initState() {
    super.initState();
    _stockController = TextEditingController(text: widget.product.stock.toString());
  }

  @override
  void dispose() { _stockController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryProvider>(
      builder: (context, provider, _) {
        final product = provider.products.firstWhere((p) => p.id == widget.product.id, orElse: () => widget.product);
        return Scaffold(
          backgroundColor: AppTheme.bg,
          appBar: AppBar(
            backgroundColor: AppTheme.bg,
            leading: GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppTheme.text, size: 20)),
            title: const Text('Product Detail'),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(product),
                const SizedBox(height: 24),
                _buildInfoCard(product),
                const SizedBox(height: 24),
                _buildStockUpdate(context, product, provider),
                const SizedBox(height: 24),
                _buildThresholds(product),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(Product product) {
    return Row(
      children: [
        Container(
          width: 72, height: 72,
          decoration: BoxDecoration(color: AppTheme.bg3, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppTheme.border, width: 0.5)),
          child: Center(child: Text(product.imageEmoji, style: const TextStyle(fontSize: 36))),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name, style: const TextStyle(color: AppTheme.text, fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(product.sku, style: const TextStyle(color: AppTheme.muted, fontSize: 13)),
              const SizedBox(height: 8),
              StockBadge(status: product.status),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(Product product) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.bg2, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.border, width: 0.5)),
      child: Column(
        children: [
          _infoRow('Category', product.category),
          const Divider(color: AppTheme.border, height: 20),
          _infoRow('Price', '\$${product.price.toStringAsFixed(2)}'),
          const Divider(color: AppTheme.border, height: 20),
          _infoRow('Status', product.statusLabel),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppTheme.muted, fontSize: 14)),
        Text(value, style: const TextStyle(color: AppTheme.text, fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildStockUpdate(BuildContext context, Product product, InventoryProvider provider) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Update Stock', style: TextStyle(color: AppTheme.text, fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: TextField(controller: _stockController, keyboardType: TextInputType.number, style: const TextStyle(color: AppTheme.text), decoration: const InputDecoration(hintText: 'Enter quantity'))),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                final newStock = int.tryParse(_stockController.text);
                if (newStock != null && newStock >= 0) {
                  provider.updateStock(product.id, newStock);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Stock updated'), backgroundColor: AppTheme.accentDark));
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(color: AppTheme.accent, borderRadius: BorderRadius.circular(12)),
                child: const Text('Save', style: TextStyle(color: AppTheme.bg, fontWeight: FontWeight.w600, fontSize: 14)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildThresholds(Product product) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.bg2, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.border, width: 0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ALERT THRESHOLDS', style: TextStyle(color: AppTheme.muted, fontSize: 12, letterSpacing: 0.5)),
          const SizedBox(height: 12),
          _thresholdRow('Low Stock Alert', '${product.lowThreshold} units', AppTheme.amber),
          const SizedBox(height: 10),
          _thresholdRow('Critical Alert', '${product.criticalThreshold} units', AppTheme.red),
        ],
      ),
    );
  }

  Widget _thresholdRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: AppTheme.text, fontSize: 14)),
        ]),
        Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
