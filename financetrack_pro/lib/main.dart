import 'package:flutter/material.dart';

void main() {
  runApp(const FinanceTrackProApp());
}

/// PUBLIC_INTERFACE
class FinanceTrackProApp extends StatelessWidget {
  /// Root widget of the FinanceTrack Pro application.
  const FinanceTrackProApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Color palette as specified in requirements
    const primaryColor = Color(0xFF2E86AB);
    const secondaryColor = Color(0xFFF6F5F5);
    const accentColor = Color(0xFFF29E4C);

    final ThemeData theme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: const ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.black87,
        onSurface: Colors.black,
      ),
      scaffoldBackgroundColor: secondaryColor,
      cardColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: secondaryColor,
        surfaceTintColor: secondaryColor,
      ),
      tabBarTheme: const TabBarTheme(
        labelColor: primaryColor,
        unselectedLabelColor: Colors.black45,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: accentColor, width: 3.0),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black87),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: accentColor,
        foregroundColor: Colors.white,
      ),
    );

    return MaterialApp(
      title: 'FinanceTrack Pro',
      theme: theme,
      debugShowCheckedModeBanner: false,
      home: const MainContainer(),
    );
  }
}

/// PUBLIC_INTERFACE
class MainContainer extends StatefulWidget {
  /// Main application scaffold containing dashboard, tabs, and drawer.
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _tabs = [
    Tab(icon: Icon(Icons.money_off), text: 'Expenses'),
    Tab(icon: Icon(Icons.attach_money), text: 'Income'),
    Tab(icon: Icon(Icons.bar_chart), text: 'Reports'),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onSidebarDialog(BuildContext context, String title) {
    Navigator.of(context).pop(); // close the drawer
    showDialog(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(title),
        content: const Text('This feature is a placeholder for future development.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double cardSpacing = 15.0;
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinanceTrack Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => _onSidebarDialog(context, 'Settings'),
            tooltip: 'Settings',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Sidebar drawer header (logo and app name)
              DrawerHeader(
                margin: EdgeInsets.zero,
                decoration: const BoxDecoration(
                  color: Color(0xFF2E86AB),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(18)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.account_balance_wallet, size: 50, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'FinanceTrack Pro',
                      style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard, color: Color(0xFF2E86AB)),
                title: const Text('Dashboard'),
                onTap: () => Navigator.of(context).pop(), // close drawer
              ),
              ListTile(
                leading: const Icon(Icons.monetization_on, color: Color(0xFFF29E4C)),
                title: const Text('Budget Planning'),
                onTap: () => _onSidebarDialog(context, 'Budget Planning'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings, color: Colors.black54),
                title: const Text('Settings'),
                onTap: () => _onSidebarDialog(context, 'Settings'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 16.0),
                child: Text(
                  'v1.0.0',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Dashboard summary cards row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _SummaryCard(
                    label: 'Total Income',
                    value: '\$0.00',
                    icon: Icons.arrow_downward,
                    color: Color(0xFF2E86AB),
                  ),
                  SizedBox(width: cardSpacing),
                  _SummaryCard(
                    label: 'Total Expenses',
                    value: '\$0.00',
                    icon: Icons.arrow_upward,
                    color: Color(0xFFF29E4C),
                  ),
                  SizedBox(width: cardSpacing),
                  _SummaryCard(
                    label: 'Savings',
                    value: '\$0.00',
                    icon: Icons.savings,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            // Main tabs content area
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  _ExpenseTabPlaceholder(),
                  _IncomeTabPlaceholder(),
                  _ReportsTabPlaceholder(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// PUBLIC_INTERFACE
class _SummaryCard extends StatelessWidget {
  /// Summary card for main dashboard metrics.
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.7,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: Theme.of(context).cardColor,
      shadowColor: color.withAlpha((0.15 * 255).round()),
      child: Container(
        width: 110,
        height: 90,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 7),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 17,
              ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder for Expenses tab
class _ExpenseTabPlaceholder extends StatelessWidget {
  const _ExpenseTabPlaceholder();
  @override
  Widget build(BuildContext context) {
    return const _FeaturePlaceholder(
      icon: Icons.money_off,
      title: 'Expenses',
      description: 'Log and categorize your daily expenses here.',
    );
  }
}

// Placeholder for Income tab
class _IncomeTabPlaceholder extends StatelessWidget {
  const _IncomeTabPlaceholder();
  @override
  Widget build(BuildContext context) {
    return const _FeaturePlaceholder(
      icon: Icons.attach_money,
      title: 'Income',
      description: 'Record your income sources here.',
    );
  }
}

// Placeholder for Reports tab
class _ReportsTabPlaceholder extends StatelessWidget {
  const _ReportsTabPlaceholder();
  @override
  Widget build(BuildContext context) {
    return const _FeaturePlaceholder(
      icon: Icons.bar_chart,
      title: 'Reports',
      description: 'Visual financial reports and charts go here.',
    );
  }
}

class _FeaturePlaceholder extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _FeaturePlaceholder({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 64, color: color),
          const SizedBox(height: 18),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
