import 'package:flutter/material.dart';

void main() {
  runApp(const CyberUdayOperationsApp());
}

// ============================================================
// CYBER UDAY - OPERATIONS PORTAL
// Single-file Flutter prototype.
// No external packages are required.
// Designed to match the existing Cyber Uday citizen website:
// light background, white cards, teal brand color, red emergency.
// ============================================================

class CyberUdayOperationsApp extends StatelessWidget {
  const CyberUdayOperationsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cyber Uday Operations',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.teal,
          brightness: Brightness.light,
          surface: Colors.white,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.teal, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 12,
          ),
        ),
      ),
      home: const OperationsPortal(),
    );
  }
}

class AppColors {
  static const background = Color(0xFFF6F8F9);
  static const card = Colors.white;
  static const teal = Color(0xFF118B86);
  static const tealDark = Color(0xFF08716D);
  static const tealLight = Color(0xFFD9F1EF);
  static const text = Color(0xFF172033);
  static const secondary = Color(0xFF6B7280);
  static const border = Color(0xFFD4DBDE);
  static const red = Color(0xFFD92D20);
  static const redLight = Color(0xFFFEE4E2);
  static const orange = Color(0xFFE58A00);
  static const orangeLight = Color(0xFFFFF1D6);
  static const green = Color(0xFF168A55);
  static const greenLight = Color(0xFFE2F5EA);
  static const purple = Color(0xFF7357B8);
  static const purpleLight = Color(0xFFF0EAFF);
}

class NavItem {
  final String title;
  final IconData icon;
  final String section;

  const NavItem(this.title, this.icon, this.section);
}

const navItems = <NavItem>[
  NavItem('Dashboard', Icons.grid_view_rounded, 'OVERVIEW'),
  NavItem('Incidents', Icons.warning_amber_rounded, 'OVERVIEW'),
  NavItem('AI Triage', Icons.auto_awesome_outlined, 'RESPONSE'),
  NavItem('Evidence', Icons.folder_copy_outlined, 'RESPONSE'),
  NavItem('Financial Protection', Icons.account_balance_outlined, 'RESPONSE'),
  NavItem('Cyber Cell', Icons.local_police_outlined, 'RESPONSE'),
  NavItem('Case Tracking', Icons.timeline_outlined, 'RESPONSE'),
  NavItem('Citizen Support', Icons.support_agent_outlined, 'SUPPORT'),
  NavItem('Scam Alerts', Icons.campaign_outlined, 'SUPPORT'),
  NavItem('Analytics', Icons.bar_chart_outlined, 'INSIGHTS'),
  NavItem('Audit Logs', Icons.security_outlined, 'INSIGHTS'),
];

class Incident {
  final String id;
  final String type;
  final String source;
  final String risk;
  final String status;
  final String amount;
  final String time;

  const Incident({
    required this.id,
    required this.type,
    required this.source,
    required this.risk,
    required this.status,
    required this.amount,
    required this.time,
  });
}

const incidents = <Incident>[
  Incident(
    id: 'CY-10294',
    type: 'UPI Fraud',
    source: 'Emergency',
    risk: 'CRITICAL',
    status: 'AI Review',
    amount: '₹2,50,000',
    time: '17:42',
  ),
  Incident(
    id: 'CY-10293',
    type: 'Phishing',
    source: 'Threat Scanner',
    risk: 'HIGH',
    status: 'Assigned',
    amount: '₹18,500',
    time: '17:31',
  ),
  Incident(
    id: 'CY-10292',
    type: 'Deepfake Extortion',
    source: 'Report Crime',
    risk: 'CRITICAL',
    status: 'Escalated',
    amount: '₹0',
    time: '17:16',
  ),
  Incident(
    id: 'CY-10291',
    type: 'QR Fraud',
    source: 'Threat Scanner',
    risk: 'MEDIUM',
    status: 'Under Review',
    amount: '₹8,000',
    time: '16:58',
  ),
  Incident(
    id: 'CY-10290',
    type: 'Account Takeover',
    source: 'Emergency',
    risk: 'HIGH',
    status: 'Assigned',
    amount: '₹45,000',
    time: '16:42',
  ),
];

class OperationsPortal extends StatefulWidget {
  const OperationsPortal({super.key});

  @override
  State<OperationsPortal> createState() => _OperationsPortalState();
}

class _OperationsPortalState extends State<OperationsPortal> {
  int selectedIndex = 0;
  String searchText = '';
  bool notificationsOpen = false;

  String get pageTitle => navItems[selectedIndex].title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isCompact = constraints.maxWidth < 950;

          if (isCompact) {
            return _buildCompactLayout();
          }

          return Row(
            children: [
              _buildSidebar(),
              Expanded(
                child: Column(
                  children: [
                    _buildTopBar(),
                    Expanded(child: _buildCurrentPage()),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCompactLayout() {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        titleSpacing: 18,
        title: Row(
          children: [
            _brandMark(size: 34),
            const SizedBox(width: 10),
            const Text(
              'CYBER UDAY',
              style: TextStyle(
                color: AppColors.text,
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showNotifications,
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          _operatorAvatar(),
          const SizedBox(width: 12),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(child: _buildSidebarContent()),
      ),
      body: _buildCurrentPage(),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 235,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(right: BorderSide(color: AppColors.border)),
      ),
      child: SafeArea(child: _buildSidebarContent()),
    );
  }

  Widget _buildSidebarContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
          child: Row(
            children: [
              _brandMark(),
              const SizedBox(width: 11),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CYBER UDAY',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        letterSpacing: .2,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Operations Portal',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.border),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(10, 16, 10, 10),
            children: [
              for (final section in [
                'OVERVIEW',
                'RESPONSE',
                'SUPPORT',
                'INSIGHTS',
              ])
                _buildSection(section),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.all(12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.tealLight.withOpacity(.55),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColors.teal.withOpacity(.14)),
          ),
          child: const Row(
            children: [
              Icon(Icons.circle, color: AppColors.green, size: 9),
              SizedBox(width: 9),
              Expanded(
                child: Text(
                  'All systems operational',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.border),
        Padding(
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
          child: Row(
            children: [
              _operatorAvatar(size: 31),
              const SizedBox(width: 9),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Operator',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'OP-102 • Online',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: _showOperatorMenu,
                icon: const Icon(
                  Icons.more_horiz_rounded,
                  size: 19,
                  color: AppColors.secondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String section) {
    final items = navItems.where((e) => e.section == section).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 7),
          child: Text(
            section,
            style: const TextStyle(
              color: AppColors.secondary,
              fontSize: 9,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
        ),
        for (final item in items)
          Builder(
            builder: (context) {
              final index = navItems.indexOf(item);
              final selected = selectedIndex == index;

              return Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: InkWell(
                  borderRadius: BorderRadius.circular(9),
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.tealLight
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(
                        color: selected
                            ? AppColors.teal.withOpacity(.12)
                            : Colors.transparent,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          item.icon,
                          size: 18,
                          color: selected
                              ? AppColors.tealDark
                              : AppColors.text.withOpacity(.72),
                        ),
                        const SizedBox(width: 11),
                        Expanded(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: selected
                                  ? AppColors.tealDark
                                  : AppColors.text.withOpacity(.82),
                              fontSize: 12,
                              fontWeight: selected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        if (item.title == 'Incidents')
                          _miniCount('12', AppColors.red),
                        if (item.title == 'AI Triage')
                          _miniCount('08', AppColors.purple),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        const SizedBox(height: 9),
      ],
    );
  }

  Widget _miniCount(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(.09),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 67,
      padding: const EdgeInsets.symmetric(horizontal: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              pageTitle,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 285,
            height: 38,
            child: TextField(
              onChanged: (value) {
                setState(() => searchText = value);
              },
              decoration: const InputDecoration(
                hintText: 'Search incidents...',
                prefixIcon: Icon(Icons.search, size: 18),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const SizedBox(width: 12),
          IconButton(
            onPressed: _showNotifications,
            icon: Badge(
              smallSize: 7,
              backgroundColor: AppColors.red,
              child: const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.text,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _operatorAvatar(),
          const SizedBox(width: 9),
          const Text(
            'Operator',
            style: TextStyle(
              color: AppColors.text,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
            color: AppColors.secondary,
          ),
        ],
      ),
    );
  }

  Widget _operatorAvatar({double size = 34}) {
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: AppColors.tealLight,
      child: Text(
        'A',
        style: TextStyle(
          color: AppColors.tealDark,
          fontWeight: FontWeight.w800,
          fontSize: size * .38,
        ),
      ),
    );
  }

  Widget _brandMark({double size = 42}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.tealLight,
        borderRadius: BorderRadius.circular(size * .28),
      ),
      child: Icon(
        Icons.security_rounded,
        color: AppColors.tealDark,
        size: size * .52,
      ),
    );
  }

  Widget _buildCurrentPage() {
    switch (selectedIndex) {
      case 0:
        return _dashboard();
      case 1:
        return _incidentsPage();
      case 2:
        return _aiTriagePage();
      case 3:
        return _evidencePage();
      case 4:
        return _financialPage();
      case 5:
        return _cyberCellPage();
      case 6:
        return _caseTrackingPage();
      case 7:
        return _supportPage();
      case 8:
        return _alertsPage();
      case 9:
        return _analyticsPage();
      case 10:
        return _auditPage();
      default:
        return _dashboard();
    }
  }

  // ============================================================
  // DASHBOARD
  // ============================================================

  Widget _dashboard() {
    return _pageScroll(
      children: [
        _pageHeader(
          'Good evening, Operator',
          'Monitor incidents, AI triage and emergency response across Cyber Uday.',
          action: FilledButton.icon(
            onPressed: () => setState(() => selectedIndex = 1),
            icon: const Icon(Icons.list_alt_rounded, size: 17),
            label: const Text('View incidents'),
          ),
        ),
        const SizedBox(height: 22),
        _responsiveGrid(
          minWidth: 190,
          children: [
            _statCard(
              '1,248',
              'TOTAL INCIDENTS',
              Icons.receipt_long_outlined,
              AppColors.teal,
              'Today +18',
            ),
            _statCard(
              '37',
              'HIGH RISK',
              Icons.warning_amber_rounded,
              AppColors.orange,
              'Needs attention',
            ),
            _statCard(
              '12',
              'CRITICAL',
              Icons.crisis_alert_rounded,
              AppColors.red,
              '4 new today',
            ),
            _statCard(
              '08',
              'AI REVIEW PENDING',
              Icons.auto_awesome_outlined,
              AppColors.purple,
              'Human review',
            ),
          ],
        ),
        const SizedBox(height: 22),
        _responsiveColumns(left: _attentionCard(), right: _systemStatusCard()),
        const SizedBox(height: 22),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                'Recent incidents',
                'Latest reports received from the Cyber Uday citizen platform.',
                trailing: TextButton(
                  onPressed: () => setState(() => selectedIndex = 1),
                  child: const Text('View all'),
                ),
              ),
              const SizedBox(height: 12),
              _incidentTable(showHeader: true),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statCard(
    String value,
    String title,
    IconData icon,
    Color color,
    String footer,
  ) {
    return _card(
      padding: const EdgeInsets.all(17),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: color.withOpacity(.10),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 21),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                    letterSpacing: .4,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  footer,
                  style: TextStyle(
                    color: color,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _attentionCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            'Needs immediate attention',
            'Priority incidents requiring operator review.',
            leading: const Icon(
              Icons.error_outline_rounded,
              color: AppColors.red,
              size: 20,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: AppColors.redLight,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.red.withOpacity(.18)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    _riskBadge('CRITICAL'),
                    const Spacer(),
                    const Text(
                      '17:42',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Text(
                  'CY-10294 • UPI Fraud',
                  style: TextStyle(
                    color: AppColors.text,
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  '₹2,50,000 reported loss • Emergency',
                  style: TextStyle(color: AppColors.secondary, fontSize: 11.5),
                ),
                const SizedBox(height: 9),
                const Row(
                  children: [
                    Icon(
                      Icons.auto_awesome,
                      size: 15,
                      color: AppColors.tealDark,
                    ),
                    SizedBox(width: 7),
                    Expanded(
                      child: Text(
                        'AI action: TRIGGER_BANK_FREEZE',
                        style: TextStyle(
                          color: AppColors.tealDark,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                FilledButton(
                  onPressed: () => _openIncident(incidents.first),
                  child: const Text('Review incident'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _systemStatusCard() {
    final services = [
      ['AI Core', 'Operational'],
      ['Incident API', 'Operational'],
      ['Evidence Store', 'Operational'],
      ['Notification Service', 'Operational'],
      ['Cyber Cell Gateway', 'Operational'],
    ];

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle(
            'System status',
            'Core services supporting Operations Portal.',
          ),
          const SizedBox(height: 11),
          for (final service in services)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.circle, size: 8, color: AppColors.green),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      service[0],
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 11.5,
                      ),
                    ),
                  ),
                  const Text(
                    'Operational',
                    style: TextStyle(
                      color: AppColors.green,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  // ============================================================
  // INCIDENTS
  // ============================================================

  Widget _incidentsPage() {
    final filtered = incidents.where((incident) {
      if (searchText.trim().isEmpty) return true;
      final q = searchText.toLowerCase();
      return incident.id.toLowerCase().contains(q) ||
          incident.type.toLowerCase().contains(q) ||
          incident.status.toLowerCase().contains(q) ||
          incident.source.toLowerCase().contains(q);
    }).toList();

    return _pageScroll(
      children: [
        _pageHeader(
          'Incident Management',
          'Review, prioritize and manage incoming cyber incidents.',
          action: FilledButton.icon(
            onPressed: () => _showNewIncidentDialog(),
            icon: const Icon(Icons.add, size: 17),
            label: const Text('New demo incident'),
          ),
        ),
        const SizedBox(height: 20),
        _card(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 15, 18, 10),
                child: Row(
                  children: [
                    const Text(
                      'All incidents',
                      style: TextStyle(
                        color: AppColors.text,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 9),
                    _miniCount('${filtered.length}', AppColors.teal),
                    const Spacer(),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.filter_list, size: 16),
                      label: const Text('Filter'),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              _incidentTable(
                incidentsToShow: filtered,
                showHeader: true,
                clickable: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _incidentTable({
    List<Incident>? incidentsToShow,
    bool showHeader = false,
    bool clickable = false,
  }) {
    final data = incidentsToShow ?? incidents;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 760,
        child: Column(
          children: [
            if (showHeader)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 11,
                ),
                color: AppColors.background,
                child: const Row(
                  children: [
                    Expanded(flex: 2, child: _TableHead('INCIDENT')),
                    Expanded(flex: 2, child: _TableHead('TYPE')),
                    Expanded(child: _TableHead('SOURCE')),
                    Expanded(child: _TableHead('RISK')),
                    Expanded(child: _TableHead('STATUS')),
                    Expanded(child: _TableHead('TIME')),
                  ],
                ),
              ),
            for (final incident in data)
              InkWell(
                onTap: clickable ? () => _openIncident(incident) : null,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 13,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          incident.id,
                          style: const TextStyle(
                            color: AppColors.text,
                            fontWeight: FontWeight.w800,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          incident.type,
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 11,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          incident.source,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Expanded(child: _riskBadge(incident.risk)),
                      Expanded(
                        child: Text(
                          incident.status,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          incident.time,
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 10,
                          ),
                        ),
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

  // ============================================================
  // AI TRIAGE
  // ============================================================

  Widget _aiTriagePage() {
    return _pageScroll(
      children: [
        _pageHeader(
          'AI Triage',
          'Review Golden Hour Triage Parser and Zero-Day Threat Analyzer results.',
        ),
        const SizedBox(height: 20),
        _infoBanner(
          icon: Icons.info_outline,
          title: 'Human-in-the-loop review',
          text:
              'AI assessments are recommendations. Operators should verify the incident and evidence before approving an action.',
          color: AppColors.teal,
          background: AppColors.tealLight,
        ),
        const SizedBox(height: 18),
        _aiResultCard(
          title: 'Golden Hour Triage Parser',
          subtitle:
              'Converts multilingual victim statements into structured incident data.',
          icon: Icons.record_voice_over_outlined,
          rows: const [
            ['Incident Type', 'UPI Fraud'],
            ['Amount Lost', '₹1,50,000'],
            ['Compromised Platform', 'WhatsApp'],
            ['Risk Level', 'CRITICAL'],
            ['Recommended Action', 'TRIGGER_BANK_FREEZE'],
          ],
          accent: AppColors.teal,
          actions: [
            OutlinedButton(
              onPressed: () => _showSnack('AI assessment opened for editing.'),
              child: const Text('Edit assessment'),
            ),
            FilledButton(
              onPressed: () => _showSnack('Assessment approved for this demo.'),
              child: const Text('Approve assessment'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        _aiResultCard(
          title: 'Zero-Day Threat Analyzer',
          subtitle:
              'Analyzes suspicious messages for social engineering indicators.',
          icon: Icons.link_off_outlined,
          rows: const [
            ['Threat Score', '97 / 100'],
            ['Threat Category', 'Smishing'],
            ['Artificial Urgency', 'Detected'],
            ['Authority Impersonation', 'Detected'],
            ['Suspicious URL', 'Detected'],
          ],
          accent: AppColors.purple,
          actions: [
            OutlinedButton(
              onPressed: () => _showSnack('Threat details opened.'),
              child: const Text('View details'),
            ),
            FilledButton(
              onPressed: () => _showSnack('Threat assessment approved.'),
              child: const Text('Approve'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _aiResultCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<List<String>> rows,
    required Color accent,
    required List<Widget> actions,
  }) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: accent.withOpacity(.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: accent, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.text,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: AppColors.secondary,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ),
              _statusChip('AI RESULT', accent),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                for (int i = 0; i < rows.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      border: i == rows.length - 1
                          ? null
                          : const Border(
                              bottom: BorderSide(color: AppColors.border),
                            ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            rows[i][0],
                            style: const TextStyle(
                              color: AppColors.secondary,
                              fontSize: 10.5,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            rows[i][1],
                            style: TextStyle(
                              color: rows[i][1] == 'CRITICAL'
                                  ? AppColors.red
                                  : AppColors.text,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Wrap(spacing: 9, runSpacing: 8, children: actions),
        ],
      ),
    );
  }

  // ============================================================
  // EVIDENCE
  // ============================================================

  Widget _evidencePage() {
    return _pageScroll(
      children: [
        _pageHeader(
          'Evidence Management',
          'Review evidence associated with incidents and maintain a clear audit trail.',
        ),
        const SizedBox(height: 20),
        _responsiveGrid(
          minWidth: 250,
          children: [
            _evidenceCard(
              Icons.mic_none_rounded,
              'Victim Voice Note',
              'victim_statement.wav',
              'Audio',
            ),
            _evidenceCard(
              Icons.image_outlined,
              'Transaction Screenshot',
              'transaction_01.jpg',
              'Image',
            ),
            _evidenceCard(
              Icons.chat_bubble_outline_rounded,
              'WhatsApp Conversation',
              'conversation_export',
              'Conversation',
            ),
            _evidenceCard(
              Icons.link_rounded,
              'Suspicious URL',
              'https://example-scam.test',
              'Threat Artifact',
            ),
          ],
        ),
        const SizedBox(height: 20),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                'Evidence review guidance',
                'Demo workflow for operator verification.',
              ),
              const SizedBox(height: 13),
              _checkRow('Evidence received', true),
              _checkRow('Evidence metadata reviewed', true),
              _checkRow('Evidence linked to incident', true),
              _checkRow('Additional evidence requested', false),
            ],
          ),
        ),
      ],
    );
  }

  Widget _evidenceCard(IconData icon, String title, String file, String type) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.tealLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: AppColors.tealDark, size: 20),
              ),
              const Spacer(),
              _statusChip('VERIFIED', AppColors.green),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            file,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.secondary, fontSize: 10.5),
          ),
          const SizedBox(height: 8),
          Text(
            type,
            style: const TextStyle(
              color: AppColors.tealDark,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 13),
          OutlinedButton(
            onPressed: () => _showSnack('Opening $file in demo mode.'),
            child: const Text('View evidence'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FINANCIAL PROTECTION
  // ============================================================

  Widget _financialPage() {
    final steps = [
      ['Incident Received', true],
      ['Transaction Details Collected', true],
      ['Protection Request Prepared', true],
      ['Submitted to Bank / Nodal Channel', true],
      ['Acknowledgement Pending', false],
      ['Action Confirmed', false],
    ];

    return _pageScroll(
      children: [
        _pageHeader(
          'Financial Protection',
          'Monitor financial fraud protection workflows without overstating external actions.',
        ),
        const SizedBox(height: 20),
        _infoBanner(
          icon: Icons.account_balance_outlined,
          title: 'Workflow status',
          text:
              'Only mark an external financial action as confirmed when the relevant integration or operator evidence confirms it.',
          color: AppColors.orange,
          background: AppColors.orangeLight,
        ),
        const SizedBox(height: 18),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                'CY-10294 • UPI Fraud',
                'Financial protection workflow',
              ),
              const SizedBox(height: 16),
              for (int i = 0; i < steps.length; i++)
                _workflowStep(
                  steps[i][0] as String,
                  steps[i][1] as bool,
                  isLast: i == steps.length - 1,
                ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 9,
                runSpacing: 8,
                children: [
                  OutlinedButton(
                    onPressed: () => _showSnack('Request details opened.'),
                    child: const Text('View request'),
                  ),
                  FilledButton(
                    onPressed: () => _showSnack(
                      'Demo action: protection request marked prepared.',
                    ),
                    child: const Text('Update workflow'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _workflowStep(String title, bool completed, {bool isLast = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 28,
          child: Column(
            children: [
              Icon(
                completed
                    ? Icons.check_circle_rounded
                    : Icons.radio_button_unchecked_rounded,
                color: completed ? AppColors.green : AppColors.secondary,
                size: 20,
              ),
              if (!isLast)
                Container(
                  width: 1,
                  height: 30,
                  color: completed
                      ? AppColors.green.withOpacity(.35)
                      : AppColors.border,
                ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1, bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: completed ? AppColors.text : AppColors.secondary,
                      fontSize: 11.5,
                      fontWeight: completed ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  completed ? 'Completed' : 'Pending',
                  style: TextStyle(
                    color: completed ? AppColors.green : AppColors.secondary,
                    fontSize: 9.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CYBER CELL
  // ============================================================

  Widget _cyberCellPage() {
    return _pageScroll(
      children: [
        _pageHeader(
          'Cyber Cell Routing',
          'Prepare structured incidents for authorized cyber authorities.',
        ),
        const SizedBox(height: 20),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.local_police_outlined,
                    color: AppColors.tealDark,
                    size: 21,
                  ),
                  const SizedBox(width: 9),
                  const Text(
                    'INCIDENT CY-10294',
                    style: TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  _riskBadge('CRITICAL'),
                ],
              ),
              const SizedBox(height: 20),
              _formLabel('Destination'),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: 'Nashik Cyber Cell',
                decoration: const InputDecoration(),
                items: const [
                  DropdownMenuItem(
                    value: 'Nashik Cyber Cell',
                    child: Text('Nashik Cyber Cell'),
                  ),
                  DropdownMenuItem(
                    value: 'District Cyber Cell',
                    child: Text('District Cyber Cell'),
                  ),
                ],
                onChanged: (_) {},
              ),
              const SizedBox(height: 15),
              _formLabel('Priority'),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                value: 'CRITICAL',
                decoration: const InputDecoration(),
                items: const [
                  DropdownMenuItem(value: 'CRITICAL', child: Text('CRITICAL')),
                  DropdownMenuItem(value: 'HIGH', child: Text('HIGH')),
                  DropdownMenuItem(value: 'MEDIUM', child: Text('MEDIUM')),
                ],
                onChanged: (_) {},
              ),
              const SizedBox(height: 15),
              _formLabel('Structured incident summary'),
              const SizedBox(height: 6),
              TextField(
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Operator-reviewed summary...',
                ),
                controller: TextEditingController(
                  text:
                      'UPI fraud incident. Reported loss ₹2,50,000. Victim statement and transaction evidence are attached. AI triage classified the incident as CRITICAL.',
                ),
              ),
              const SizedBox(height: 18),
              Wrap(
                spacing: 9,
                runSpacing: 8,
                children: [
                  OutlinedButton.icon(
                    onPressed: () =>
                        _showSnack('Evidence references attached.'),
                    icon: const Icon(Icons.attach_file, size: 16),
                    label: const Text('Attach evidence'),
                  ),
                  FilledButton.icon(
                    onPressed: () =>
                        _showSnack('Demo: Cyber Cell referral prepared.'),
                    icon: const Icon(Icons.send_outlined, size: 16),
                    label: const Text('Submit case'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // CASE TRACKING
  // ============================================================

  Widget _caseTrackingPage() {
    final steps = [
      ['Incident Reported', true],
      ['AI Triage Completed', true],
      ['Operator Assigned', true],
      ['Evidence Reviewed', true],
      ['Financial Workflow Initiated', true],
      ['Cyber Cell Referral Submitted', true],
      ['Awaiting Cyber Cell Response', false],
    ];

    return _pageScroll(
      children: [
        _pageHeader(
          'Case Tracking',
          'Track the incident lifecycle from citizen report to resolution.',
        ),
        const SizedBox(height: 20),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                'Case CY-10294',
                'UPI Fraud • Critical priority',
                trailing: _statusChip('IN PROGRESS', AppColors.orange),
              ),

              const SizedBox(height: 22),

              for (int i = 0; i < steps.length; i++)
                _workflowStep(
                  steps[i][0] as String,
                  steps[i][1] as bool,
                  isLast: i == steps.length - 1,
                ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                'Case timeline',
                'Operator activity for this incident.',
              ),
              const SizedBox(height: 12),
              _timelineRow(
                '17:42',
                'Incident reported',
                'Citizen platform • Emergency',
              ),
              _timelineRow(
                '17:43',
                'AI triage completed',
                'Golden Hour Triage Parser',
              ),
              _timelineRow('17:47', 'Operator assigned', 'OP-102'),
              _timelineRow(
                '17:52',
                'Evidence reviewed',
                'Voice note + transaction screenshot',
              ),
              _timelineRow(
                '18:01',
                'Cyber Cell referral prepared',
                'Nashik Cyber Cell',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _timelineRow(String time, String title, String detail) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 46,
            child: Text(
              time,
              style: const TextStyle(
                color: AppColors.secondary,
                fontSize: 10,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.teal,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // CITIZEN SUPPORT
  // ============================================================

  Widget _supportPage() {
    return _pageScroll(
      children: [
        _pageHeader(
          'Citizen Support',
          'Manage requests that require human assistance.',
        ),
        const SizedBox(height: 20),
        _responsiveGrid(
          minWidth: 290,
          children: [
            _supportRequestCard(
              'CRITICAL',
              'Deepfake Extortion',
              'Human assistance requested',
              'AI Digital First Aid delivered',
              AppColors.red,
            ),
            _supportRequestCard(
              'HIGH',
              'Account Takeover',
              'Citizen requested operator help',
              'Waiting for assignment',
              AppColors.orange,
            ),
            _supportRequestCard(
              'MEDIUM',
              'Phishing Concern',
              'Citizen needs clarification',
              'AI First Aid delivered',
              AppColors.teal,
            ),
          ],
        ),
      ],
    );
  }

  Widget _supportRequestCard(
    String risk,
    String type,
    String request,
    String status,
    Color color,
  ) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _riskBadge(risk),
              const Spacer(),
              const Text(
                '2 min ago',
                style: TextStyle(color: AppColors.secondary, fontSize: 9.5),
              ),
            ],
          ),
          const SizedBox(height: 13),
          Text(
            type,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            request,
            style: const TextStyle(color: AppColors.secondary, fontSize: 10.5),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              Icon(Icons.check_circle_outline, size: 15, color: color),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  status,
                  style: TextStyle(
                    color: color,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          OutlinedButton(
            onPressed: () => _showSnack('Support request opened.'),
            child: const Text('Open request'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SCAM ALERTS
  // ============================================================

  Widget _alertsPage() {
    return _pageScroll(
      children: [
        _pageHeader(
          'Scam Intelligence & Alerts',
          'Create and publish verified cyber threat alerts to the citizen platform.',
          action: FilledButton.icon(
            onPressed: () => _showAlertDialog(),
            icon: const Icon(Icons.add, size: 17),
            label: const Text('Create alert'),
          ),
        ),
        const SizedBox(height: 20),
        _responsiveGrid(
          minWidth: 310,
          children: [
            _alertCard(
              'Fake KYC Update Scam',
              'HIGH',
              'Maharashtra',
              'Published',
            ),
            _alertCard('QR Payment Scam', 'MEDIUM', 'India', 'Published'),
            _alertCard('Fake Customer Care Numbers', 'HIGH', 'India', 'Draft'),
          ],
        ),
      ],
    );
  }

  Widget _alertCard(
    String title,
    String severity,
    String region,
    String status,
  ) {
    final color = severity == 'HIGH' ? AppColors.orange : AppColors.teal;

    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 39,
                height: 39,
                decoration: BoxDecoration(
                  color: color.withOpacity(.10),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.campaign_outlined, color: color, size: 20),
              ),
              const Spacer(),
              _statusChip(
                status.toUpperCase(),
                status == 'Published' ? AppColors.green : AppColors.secondary,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            title,
            style: const TextStyle(
              color: AppColors.text,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '$severity • $region',
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 13),
          OutlinedButton(
            onPressed: () => _showSnack('Alert management opened.'),
            child: const Text('Manage alert'),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ANALYTICS
  // ============================================================

  Widget _analyticsPage() {
    return _pageScroll(
      children: [
        _pageHeader(
          'Operations Analytics',
          'Monitor operational trends and response performance.',
        ),
        const SizedBox(height: 20),
        _responsiveGrid(
          minWidth: 190,
          children: [
            _metricCard('Average triage time', '03:42', '↓ 12% this week'),
            _metricCard('Incidents resolved', '184', '+18 this week'),
            _metricCard('AI assessments reviewed', '412', '96% reviewed'),
            _metricCard('Cyber Cell referrals', '68', '+9 this week'),
          ],
        ),
        const SizedBox(height: 20),
        _responsiveColumns(
          left: _chartCard('Incidents by type', const [
            ['UPI Fraud', .82],
            ['Phishing', .68],
            ['QR Fraud', .49],
            ['Deepfake', .36],
            ['Account Takeover', .28],
          ]),
          right: _chartCard('Risk distribution', const [
            ['Critical', .21],
            ['High', .39],
            ['Medium', .27],
            ['Low', .13],
          ]),
        ),
        const SizedBox(height: 20),
        _card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle(
                'Response pipeline',
                'Demo operational distribution.',
              ),
              const SizedBox(height: 17),
              _pipelineBar('Received', 0.95, AppColors.teal),
              _pipelineBar('AI triage', 0.82, AppColors.purple),
              _pipelineBar('Operator review', 0.69, AppColors.orange),
              _pipelineBar('Cyber Cell referral', 0.43, AppColors.red),
              _pipelineBar('Resolution', 0.27, AppColors.green),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Demo values shown for UI prototyping; connect to measured backend metrics before production use.',
          style: TextStyle(color: AppColors.secondary, fontSize: 9.5),
        ),
      ],
    );
  }

  Widget _metricCard(String title, String value, String footer) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: AppColors.secondary, fontSize: 10.5),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            footer,
            style: const TextStyle(
              color: AppColors.tealDark,
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartCard(String title, List<List<dynamic>> data) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 17),
          for (final row in data) ...[
            Row(
              children: [
                Expanded(
                  child: Text(
                    row[0] as String,
                    style: const TextStyle(
                      color: AppColors.secondary,
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  '${((row[1] as double) * 100).round()}%',
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: row[1] as double,
                minHeight: 7,
                backgroundColor: AppColors.tealLight,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.teal),
              ),
            ),
            const SizedBox(height: 13),
          ],
        ],
      ),
    );
  }

  Widget _pipelineBar(String title, double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: const TextStyle(color: AppColors.secondary, fontSize: 10),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: value,
                minHeight: 8,
                backgroundColor: AppColors.background,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 35,
            child: Text(
              '${(value * 100).round()}%',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: AppColors.text,
                fontSize: 9.5,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // AUDIT LOGS
  // ============================================================

  Widget _auditPage() {
    final logs = [
      ['OP-102', 'Viewed Incident', 'CY-10294', '17:44'],
      ['OP-102', 'Approved AI Triage', 'CY-10294', '17:47'],
      ['OP-108', 'Routed Cyber Cell', 'CY-10290', '17:39'],
      ['OP-108', 'Viewed Evidence', 'CY-10292', '17:28'],
      ['OP-102', 'Updated Financial Workflow', 'CY-10294', '17:52'],
    ];

    return _pageScroll(
      children: [
        _pageHeader(
          'Audit & Security Logs',
          'Track sensitive operational activity and operator actions.',
          action: OutlinedButton.icon(
            onPressed: () => _showSnack('Export prepared in demo mode.'),
            icon: const Icon(Icons.download_outlined, size: 16),
            label: const Text('Export'),
          ),
        ),
        const SizedBox(height: 20),
        _card(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                color: AppColors.background,
                child: const Row(
                  children: [
                    Expanded(child: _TableHead('OPERATOR')),
                    Expanded(flex: 2, child: _TableHead('ACTION')),
                    Expanded(child: _TableHead('CASE')),
                    Expanded(child: _TableHead('TIME')),
                  ],
                ),
              ),
              for (final log in logs)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColors.border)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          log[0],
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          log[1],
                          style: const TextStyle(
                            color: AppColors.text,
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          log[2],
                          style: const TextStyle(
                            color: AppColors.tealDark,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          log[3],
                          style: const TextStyle(
                            color: AppColors.secondary,
                            fontSize: 10.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  // ============================================================
  // COMMON UI
  // ============================================================

  Widget _pageScroll({required List<Widget> children}) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(27, 25, 27, 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _pageHeader(String title, String subtitle, {Widget? action}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 11.5,
                ),
              ),
            ],
          ),
        ),
        if (action != null) ...[const SizedBox(width: 12), action],
      ],
    );
  }

  Widget _sectionTitle(
    String title,
    String subtitle, {
    Widget? leading,
    Widget? trailing,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (leading != null) ...[leading, const SizedBox(width: 8)],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColors.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  Widget _card({
    required Widget child,
    EdgeInsetsGeometry padding = const EdgeInsets.all(18),
  }) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: child,
    );
  }

  Widget _responsiveGrid({
    required double minWidth,
    required List<Widget> children,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final count = (width / minWidth).floor().clamp(1, 4);
        final itemWidth = (width - ((count - 1) * 14)) / count.toDouble();

        return Wrap(
          spacing: 14,
          runSpacing: 14,
          children: children
              .map((child) => SizedBox(width: itemWidth, child: child))
              .toList(),
        );
      },
    );
  }

  Widget _responsiveColumns({required Widget left, required Widget right}) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 750) {
          return Column(children: [left, const SizedBox(height: 14), right]);
        }

        final leftWidth = constraints.maxWidth * .60 - 7;
        final rightWidth = constraints.maxWidth * .40 - 7;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: leftWidth, child: left),
            const SizedBox(width: 14),
            SizedBox(width: rightWidth, child: right),
          ],
        );
      },
    );
  }

  Widget _riskBadge(String risk) {
    Color color;
    Color background;

    switch (risk) {
      case 'CRITICAL':
        color = AppColors.red;
        background = AppColors.redLight;
        break;
      case 'HIGH':
        color = AppColors.orange;
        background = AppColors.orangeLight;
        break;
      case 'MEDIUM':
        color = const Color(0xFF9A7200);
        background = const Color(0xFFFFF7D6);
        break;
      default:
        color = AppColors.green;
        background = AppColors.greenLight;
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          risk,
          style: TextStyle(
            color: color,
            fontSize: 8.5,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }

  Widget _statusChip(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(.09),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.w800,
          letterSpacing: .4,
        ),
      ),
    );
  }

  Widget _infoBanner({
    required IconData icon,
    required String title,
    required String text,
    required Color color,
    required Color background,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 19),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  text,
                  style: const TextStyle(color: AppColors.text, fontSize: 10.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkRow(String title, bool completed) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            completed
                ? Icons.check_circle_outline
                : Icons.radio_button_unchecked,
            color: completed ? AppColors.green : AppColors.secondary,
            size: 18,
          ),
          const SizedBox(width: 9),
          Text(
            title,
            style: TextStyle(
              color: completed ? AppColors.text : AppColors.secondary,
              fontSize: 11,
              fontWeight: completed ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _formLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.text,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  // ============================================================
  // DIALOGS / ACTIONS
  // ============================================================

  void _openIncident(Incident incident) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              incident.id,
                              style: const TextStyle(
                                color: AppColors.text,
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${incident.type} • ${incident.source}',
                              style: const TextStyle(
                                color: AppColors.secondary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      _riskBadge(incident.risk),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _responsiveGrid(
                    minWidth: 160,
                    children: [
                      _detailTile('Incident type', incident.type),
                      _detailTile('Amount lost', incident.amount),
                      _detailTile('Source', incident.source),
                      _detailTile('Status', incident.status),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _detailBlock(
                    'AI triage recommendation',
                    'TRIGGER_BANK_FREEZE',
                  ),
                  const SizedBox(height: 12),
                  _detailBlock(
                    'Operator summary',
                    'Citizen reported a suspected financial cyber incident. '
                        'Evidence references are available for review. '
                        'AI classified the incident as ${incident.risk}.',
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      OutlinedButton(
                        onPressed: () => _showSnack('Incident assigned.'),
                        child: const Text('Assign operator'),
                      ),
                      const SizedBox(width: 9),
                      FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() => selectedIndex = 2);
                        },
                        child: const Text('Open AI triage'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _detailTile(String label, String value) {
    return _card(
      padding: const EdgeInsets.all(13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(color: AppColors.secondary, fontSize: 9.5),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailBlock(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.secondary,
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            content,
            style: const TextStyle(
              color: AppColors.text,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  void _showNewIncidentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('New demo incident'),
          content: const SizedBox(
            width: 430,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Incident type'),
                ),
                SizedBox(height: 12),
                TextField(decoration: InputDecoration(labelText: 'Source')),
                SizedBox(height: 12),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount lost'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _showSnack('Demo incident created locally.');
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Create scam alert'),
          content: const SizedBox(
            width: 450,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Alert title'),
                ),
                SizedBox(height: 12),
                TextField(decoration: InputDecoration(labelText: 'Region')),
                SizedBox(height: 12),
                TextField(
                  maxLines: 3,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
                _showSnack('Alert saved as a demo draft.');
              },
              child: const Text('Save draft'),
            ),
          ],
        );
      },
    );
  }

  void _showNotifications() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    color: AppColors.text,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                _notificationRow(
                  'Critical UPI Fraud',
                  'CY-10294 requires review.',
                  AppColors.red,
                ),
                _notificationRow(
                  'AI review pending',
                  '8 assessments are waiting.',
                  AppColors.purple,
                ),
                _notificationRow(
                  'Cyber Cell update',
                  'A case status was updated.',
                  AppColors.teal,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _notificationRow(String title, String subtitle, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Row(
        children: [
          Icon(Icons.circle, color: color, size: 9),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.secondary,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showOperatorMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.person_outline),
                title: const Text('Operator profile'),
                onTap: () {
                  Navigator.pop(context);
                  _showSnack('Operator profile opened in demo mode.');
                },
              ),
              ListTile(
                leading: const Icon(Icons.lock_outline),
                title: const Text('Session security'),
                onTap: () {
                  Navigator.pop(context);
                  _showSnack('Session security opened.');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Sign out'),
                onTap: () {
                  Navigator.pop(context);
                  _showSnack('Demo sign-out action.');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showSnack(String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.text,
      ),
    );
  }
}

class _TableHead extends StatelessWidget {
  final String text;

  const _TableHead(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.secondary,
        fontSize: 8.5,
        fontWeight: FontWeight.w800,
        letterSpacing: .5,
      ),
    );
  }
}
