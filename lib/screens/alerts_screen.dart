import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/inventory_provider.dart';
import '../theme/app_theme.dart';

class AlertsScreen extends StatelessWidget {
  const AlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InventoryProvider>(
      builder: (context, provider, _) {
        final alerts = provider.alerts;
        return Scaffold(
          backgroundColor: AppTheme.bg,
          appBar: AppBar(
            backgroundColor: AppTheme.bg,
            leading: GestureDetector(onTap: () => Navigator.pop(context), child: const Icon(Icons.arrow_back_ios, color: AppTheme.text, size: 20)),
            title: const Text('Alerts'),
            actions: [
              if (alerts.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppTheme.red.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                      child: Text('${alerts.length} active', style: const TextStyle(color: AppTheme.red, fontSize: 12, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
            ],
          ),
          body: alerts.isEmpty
              ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(Icons.check_circle_outline, color: AppTheme.accent, size: 48),
                  SizedBox(height: 12),
                  Text('All products are well stocked!', style: TextStyle(color: AppTheme.muted)),
                ]))
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: alerts.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final alert = alerts[index];
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(color: AppTheme.bg2, borderRadius: BorderRadius.circular(16), border: Border.all(color: alert.color.withOpacity(0.2), width: 0.5)),
                      child: Row(
                        children: [
                          Container(
                            width: 40, height: 40,
                            decoration: BoxDecoration(color: alert.color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                            child: Icon(alert.icon, color: alert.color, size: 20),
                          ),
                          const SizedBox(width: 14),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(alert.productName, style: const TextStyle(color: AppTheme.text, fontSize: 14, fontWeight: FontWeight.w500)),
                              const SizedBox(height: 3),
                              Text(alert.message, style: const TextStyle(color: AppTheme.muted, fontSize: 12, height: 1.4)),
                            ],
                          )),
                        ],
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
