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
    // Define color palette
    const primaryColor = Color(0xFF2E86AB);
    const secondaryColor = Color(0xFFF6F5F5);
    const accentColor = Color(0xFFF29E4C);

    final ThemeData theme = ThemeData(
      brightness: Brightness.light,
      primaryColor: primaryColor,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: accentColor,
        surface: Colors.white,
        onPrimary: Colors.white,
        onSecondary: Colors.black87,
      ),
      scaffoldBackgroundColor: secondaryColor,
      appBarTheme: const AppBarTheme(
        surfaceTintColor: primaryColor,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      cardColor: Colors.white,
      tabBarTheme: const TabBarTheme(
        labelColor: primaryColor,
        unselectedLabelColor: Colors.black54,
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(color: accentColor, width: 3.0),
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: secondaryColor,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        titleMedium: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black87),
      ),
      useMaterial3: true,
    );

    return MaterialApp(
      title: 'FinanceTrack Pro',
      theme: theme,
      home: const MainContainer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// PUBLIC_INTERFACE
class MainContainer extends StatefulWidget {
  /// Main application scaffold with navigation, dashboard, and tabs.
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Tab> _tabs = const [
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

  void _onSidebarNavigation(BuildContext context, String route) {
    Navigator.pop(context); // close the drawer
    // Handle actual navigation or show placeholder
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(route),
        content: const Text('This feature is a placeholder for future development.'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FinanceTrack Pro'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => _onSidebarNavigation(context, 'Settings'),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.account_balance_wallet, size: 48, color: Color(0xFF2E86AB)),
                    SizedBox(height: 8),
                    Text(
                      'FinanceTrack Pro',
                      style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E86AB),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.dashboard),
                title: const Text('Dashboard'),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(Icons.monetization_on),
                title: const Text('Budget Planning'),
                onTap: () => _onSidebarNavigation(context, 'Budget Planning'),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () => _onSidebarNavigation(context, 'Settings'),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
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
            // Dashboard summary cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  _SummaryCard(
                    label: 'Total Income',
                    value: '\$0.00',
                    icon: Icons.arrow_downward,
                    color: Color(0xFF2E86AB),
                  ),
                  _SummaryCard(
                    label: 'Total Expenses',
                    value: '\$0.00',
                    icon: Icons.arrow_upward,
                    color: Color(0xFFF29E4C),
                  ),
                  _SummaryCard(
                    label: 'Savings',
                    value: '\$0.00',
                    icon: Icons.savings,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
            // Tabs content
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
  /// Dashboard summary card showing main value.
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
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Theme.of(context).cardColor,
      child: Container(
        width: 110,
        height: 90,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
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
    return _FeaturePlaceholder(
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
    return _FeaturePlaceholder(
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
    return _FeaturePlaceholder(
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
          const SizedBox(height: 16),
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
