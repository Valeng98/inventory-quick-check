import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/inventory_provider.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';
import '../widgets/stat_card.dart';
import '../widgets/product_tile.dart';
import 'product_detail_screen.dart';
import 'alerts_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: AppTheme.bg,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                _buildHeader(context, provider),
                _buildSearchBar(context, provider),
                _buildStats(provider),
                _buildCategoryFilter(context, provider),
                _buildProductList(context, provider),
                const SliverToBoxAdapter(child: SizedBox(height: 32)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, InventoryProvider provider) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Inventory', style: Theme.of(context).textTheme.headlineLarge),
                  const SizedBox(height: 2),
                  Text('${provider.totalProducts} products tracked', style: const TextStyle(color: AppTheme.muted, fontSize: 13)),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AlertsScreen())),
              child: Container(
                width: 44, height: 44,
                decoration: BoxDecoration(color: AppTheme.bg2, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppTheme.border, width: 0.5)),
                child: Stack(
                  children: [
                    const Center(child: Icon(Icons.notifications_outlined, color: AppTheme.text, size: 20)),
                    if (provider.unreadAlertCount > 0)
                      Positioned(top: 8, right: 8,
                        child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppTheme.red, shape: BoxShape.circle)),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context, InventoryProvider provider) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: TextField(
          onChanged: provider.setSearch,
          style: const TextStyle(color: AppTheme.text, fontSize: 14),
          decoration: const InputDecoration(
            hintText: 'Search by name or SKU...',
            prefixIcon: Icon(Icons.search, color: AppTheme.muted, size: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildStats(InventoryProvider provider) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          children: [
            Expanded(child: StatCard(label: 'In Stock', value: '${provider.okCount}', color: AppTheme.accent, onTap: () => provider.setFilterStatus(provider.filterStatus == StockStatus.ok ? null : StockStatus.ok))),
            const SizedBox(width: 10),
            Expanded(child: StatCard(label: 'Low Stock', value: '${provider.lowCount}', color: AppTheme.amber, onTap: () => provider.setFilterStatus(provider.filterStatus == StockStatus.low ? null : StockStatus.low))),
            const SizedBox(width: 10),
            Expanded(child: StatCard(label: 'Critical', value: '${provider.criticalCount}', color: AppTheme.red, onTap: () => provider.setFilterStatus(provider.filterStatus == StockStatus.critical ? null : StockStatus.critical))),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context, InventoryProvider provider) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 60,
        child: ListView.separated(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
          scrollDirection: Axis.horizontal,
          itemCount: provider.categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final cat = provider.categories[index];
            final selected = provider.selectedCategory == cat;
            return GestureDetector(
              onTap: () => provider.setCategory(cat),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: selected ? AppTheme.accent : AppTheme.bg2,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: selected ? AppTheme.accent : AppTheme.border, width: 0.5),
                ),
                child: Text(cat, style: TextStyle(color: selected ? AppTheme.bg : AppTheme.muted, fontSize: 13, fontWeight: FontWeight.w500)),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildProductList(BuildContext context, InventoryProvider provider) {
    if (provider.products.isEmpty) {
      return const SliverFillRemaining(
        child: Center(child: Text('No products found', style: TextStyle(color: AppTheme.muted))),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ProductTile(
              product: provider.products[index],
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: provider.products[index]))),
            ),
          ),
          childCount: provider.products.length,
        ),
      ),
    );
  }
}
