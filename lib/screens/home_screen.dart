import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../data/datacenters_data.dart';

class AshburnImpactApp extends StatelessWidget {
  const AshburnImpactApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ashburn Data Valley',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF145DA0),
          brightness: Brightness.light,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static final List<({IconData icon, String text, Widget Function() page})>
  _didYouKnowFacts = [
    (
      icon: Icons.lightbulb_outline,
      text:
          'Ashburn is one of the world\u2019s major internet infrastructure hubs, with data centers, fiber networks, and cloud connectivity.',
      page: () => const LearningDetailScreen(
        pageType: 'numbers',
        title: 'Exploring Ashburn',
        intro:
            'Ashburn is a major digital infrastructure hub shaped by data-center growth, fiber connectivity, and economic development.',
        statLabel: 'Quick facts',
        facts: [
          'Thousands of facilities and supporting businesses define the region\u2019s digital footprint.',
          'Power demand and cooling needs grow with concentrated infrastructure.',
          'Ashburn is central to cloud computing, internet traffic, and regional growth.',
        ],
        highlight:
            'Ashburn is one of the world\u2019s biggest internet infrastructure centers.',
        themeColor: Color(0xFF145DA0),
      ),
    ),
    (
      icon: Icons.bolt_outlined,
      text:
          'Data centers require electricity not only for computing, but also for cooling systems that keep servers from overheating.',
      page: () => const LearningDetailScreen(
        pageType: 'power',
        title: 'Power & Resources',
        intro:
            'Data centers depend on reliable power, cooling, and network infrastructure to keep services running around the clock.',
        statLabel: 'Why it matters',
        facts: [
          'Servers, cooling systems, and backups all draw significant electricity demand.',
          'Local grids and utility planning must account for dense infrastructure loads.',
          'Energy use is a major part of the story behind digital growth in Ashburn.',
        ],
        highlight:
            'Digital infrastructure needs power as much as it needs connectivity.',
        themeColor: Color(0xFFB7791F),
      ),
    ),
    (
      icon: Icons.groups_outlined,
      text:
          'Data center growth in Ashburn creates thousands of jobs in engineering, construction, and operations.',
      page: () => const LearningDetailScreen(
        pageType: 'community',
        title: 'Community Impact',
        intro:
            'Ashburn\u2019s digital growth brings opportunities for jobs, innovation, and infrastructure investment \u2014 but it also raises questions about local resources and planning.',
        statLabel: 'Big ideas',
        facts: [
          'High-tech industry growth can create jobs in engineering, operations, and construction.',
          'Infrastructure expansion can shape local land use, energy demand, and public planning.',
          'Understanding community impact helps communities balance digital growth with local needs.',
        ],
        highlight:
            'The future of Ashburn depends on how technology and community planning work together.',
        themeColor: Color(0xFF7C3AED),
      ),
    ),
  ];

  late final int _factIndex = Random().nextInt(_didYouKnowFacts.length);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'ASHBURN DATA VALLEY',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        actions: [
          IconButton(
            iconSize: 20,
            icon: Icon(Icons.info_outline, color: Colors.grey.shade500),
            onPressed: () => _showAboutDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeroCard(),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.bar_chart_rounded,
                      title: 'DATA CENTERS',
                      value: 'Explore',
                      subtitle: 'Locations & key facts',
                      accentColor: const Color(0xFF145DA0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LearningDetailScreen(
                              pageType: 'numbers',
                              title: 'Exploring Ashburn',
                              intro:
                                  'Ashburn is a major digital infrastructure hub shaped by data-center growth, fiber connectivity, and economic development.',
                              statLabel: 'Quick facts',
                              facts: [
                                'Thousands of facilities and supporting businesses define the region’s digital footprint.',
                                'Power demand and cooling needs grow with concentrated infrastructure.',
                                'Ashburn is central to cloud computing, internet traffic, and regional growth.',
                              ],
                              highlight:
                                  'Ashburn is one of the world’s biggest internet infrastructure centers.',
                              themeColor: Color(0xFF145DA0),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.language_outlined,
                      title: 'HOW IT WORKS',
                      value: 'Learn',
                      subtitle: 'How the network connects',
                      accentColor: const Color(0xFF145DA0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HowInternetWorksScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.bolt_outlined,
                      title: 'ENERGY',
                      value: 'Power',
                      subtitle: 'Electricity & cooling',
                      accentColor: const Color(0xFF145DA0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LearningDetailScreen(
                              pageType: 'power',
                              title: 'Power & Resources',
                              intro:
                                  'Data centers depend on reliable power, cooling, and network infrastructure to keep services running around the clock.',
                              statLabel: 'Why it matters',
                              facts: [
                                'Servers, cooling systems, and backups all draw significant electricity demand.',
                                'Local grids and utility planning must account for dense infrastructure loads.',
                                'Energy use is a major part of the story behind digital growth in Ashburn.',
                              ],
                              highlight:
                                  'Digital infrastructure needs power as much as it needs connectivity.',
                              themeColor: Color(0xFFB7791F),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildMetricCard(
                      icon: Icons.eco_outlined,
                      title: 'COMMUNITY',
                      value: 'Impact',
                      subtitle: 'Growth, jobs & resources',
                      accentColor: const Color(0xFF145DA0),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LearningDetailScreen(
                              pageType: 'community',
                              title: 'Community Impact',
                              intro:
                                  'Ashburn’s digital growth brings opportunities for jobs, innovation, and infrastructure investment — but it also raises questions about local resources and planning.',
                              statLabel: 'Big ideas',
                              facts: [
                                'High-tech industry growth can create jobs in engineering, operations, and construction.',
                                'Infrastructure expansion can shape local land use, energy demand, and public planning.',
                                'Understanding community impact helps communities balance digital growth with local needs.',
                              ],
                              highlight:
                                  'The future of Ashburn depends on how technology and community planning work together.',
                              themeColor: Color(0xFF7C3AED),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2F8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF145DA0).withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          _didYouKnowFacts[_factIndex].icon,
                          size: 14,
                          color: const Color(0xFF145DA0),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'DID YOU KNOW?',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                            color: Color(0xFF145DA0),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _didYouKnowFacts[_factIndex].text,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),
                    InkWell(
                      onTap: () => _openDataCenterJobs(context),
                      child: const Text(
                        'Search for jobs →',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF145DA0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              _buildBottomActions(context),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openDataCenterJobs(BuildContext context) async {
    final uri = Uri.https('www.indeed.com', '/jobs', {
      'q': 'data center',
      'l': 'Ashburn, VA',
    });
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the jobs page.')),
      );
    }
  }

  void _showAboutDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        scrollable: true,
        title: const Text('About Ashburn Data Valley'),
        content: const Text(
          'My name is Rohan, and I live right here in Ashburn, Virginia, a place '
          'I’m proud to call home. Ashburn is a beautiful suburb. It’s where I '
          'go to school, where my friends live, and where my family has built '
          'our life. I’ve always loved the sense of community here.\n\n'
          'But over the past few years, something big has been happening around '
          'us. Data centers, more and more of them, have been rising across '
          'Ashburn. At first, I didn’t think much about it. They were just large '
          'buildings with loud fans and bright lights. But last summer, '
          'everything changed.\n\n'
          'A new data center was proposed, and the plan included running power '
          'lines right across my school. When my parents took me to the community '
          'meeting about it, I expected a small gathering. Instead, the room was '
          'packed. Residents, parents, teachers, all speaking up, all worried, '
          'all asking for alternatives like underground transmission lines to '
          'protect our neighborhoods.\n\n'
          'That night was the first time I truly understood how fast data '
          'centers were growing in Ashburn and how complicated the situation '
          'really was. I felt the weight of it when I saw our Congressman, Mr. '
          'Suhas Subramanian, standing there, listening to the community and '
          'speaking on our behalf. It made me realize that this wasn’t just '
          'about buildings, it was about people, schools, safety, and the future '
          'of our town.\n\n'
          'After that meeting, I started researching. There is so much '
          'information online about Ashburn’s data centers, their benefits, '
          'their challenges, their impact, but it’s scattered everywhere. No '
          'single place explains the whole picture.\n\n'
          'So I decided to build one.\n\n'
          'I created an app designed specifically for Ashburn residents. It '
          'brings together everything you might want to know about the data '
          'centers in our region, the good and the bad, all in one place. My app '
          'shows every data center in Ashburn, the jobs they create, and how '
          'they affect our community. It also includes something I’m really '
          'excited about: a virtual data center builder. Residents can design '
          'a data center and instantly see its impact in simple, easy to '
          'understand terms.\n\n'
          'My goal is not to take sides. My goal is to help people understand. '
          'Because when a community is informed, it can make better decisions, '
          'ask better questions, and work together toward better solutions.\n\n'
          'Ashburn is my home. I care about it deeply. And I believe that when '
          'we combine technology with community voices, we can protect what '
          'makes this place special while still embracing the future.',
          style: TextStyle(height: 1.4),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF145DA0), Color(0xFF0C2D48)],
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.location_on, color: Colors.white70, size: 16),
              SizedBox(width: 5),
              Text(
                'ASHBURN, VIRGINIA',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            'A GLOBAL\nDIGITAL HUB',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              height: 1.05,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Explore the infrastructure connecting our world — and our community.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildBottomAction(
          icon: Icons.map_outlined,
          label: 'VIEW ALL DATA CENTERS ON MAP',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DataCenterMapScreen()),
          ),
        ),
        const SizedBox(height: 10),
        _buildBottomAction(
          icon: Icons.construction_outlined,
          label: 'FUTURE DATA CENTERS',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FutureDataCentersMapScreen(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildBottomAction(
          icon: Icons.volume_up_outlined,
          label: 'SIMULATION',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const DataCenterNoiseSimulationScreen(),
            ),
          ),
        ),
        const SizedBox(height: 10),
        _buildBottomAction(
          icon: Icons.tune_outlined,
          label: 'MAKE YOUR OWN DATA CENTER',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const DataCenterBuilderScreen()),
          ),
        ),
        const SizedBox(height: 10),
        _buildBottomAction(
          icon: Icons.menu_book_outlined,
          label: 'SOURCES',
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SourcesScreen()),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomAction({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF145DA0),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
      child: Row(
        children: [
          Icon(icon, size: 19),
          const SizedBox(width: 10),
          Expanded(child: Text(label)),
          const Icon(Icons.arrow_forward, size: 19),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return _MetricCard(
      icon: icon,
      title: title,
      value: value,
      subtitle: subtitle,
      accentColor: accentColor,
      onTap: onTap,
    );
  }
}

class _MetricCard extends StatefulWidget {
  const _MetricCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.subtitle,
    required this.accentColor,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final String subtitle;
  final Color accentColor;
  final VoidCallback onTap;

  @override
  State<_MetricCard> createState() => _MetricCardState();
}

class _MetricCardState extends State<_MetricCard> {
  double _scale = 1;

  void _setPressed(bool pressed) => setState(() => _scale = pressed ? 0.97 : 1);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            onTap: widget.onTap,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 132,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      color: widget.accentColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 19,
                      color: widget.accentColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      letterSpacing: 0.7,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    widget.value,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Flexible(
                    child: Text(
                      widget.subtitle,
                      style: const TextStyle(fontSize: 9, color: Colors.grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DataCenterDirectoryScreen extends StatefulWidget {
  const DataCenterDirectoryScreen({super.key});

  @override
  State<DataCenterDirectoryScreen> createState() =>
      _DataCenterDirectoryScreenState();
}

class _DataCenterDirectoryScreenState extends State<DataCenterDirectoryScreen> {
  late Future<List<_CsvDataCenter>> _dataCentersFuture;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _dataCentersFuture = _loadDataCenters();
  }

  Future<List<_CsvDataCenter>> _loadDataCenters() async {
    final csv = await rootBundle.loadString('assets/ashburn_data_centers.csv');
    final rows = _parseCsv(csv);
    if (rows.length <= 1) return [];
    return rows
        .skip(1)
        .where((row) => row.length >= 4)
        .map(_CsvDataCenter.fromRow)
        .toList();
  }

  List<List<String>> _parseCsv(String input) {
    final rows = <List<String>>[];
    final row = <String>[];
    final field = StringBuffer();
    var inQuotes = false;

    for (var index = 0; index < input.length; index++) {
      final character = input[index];
      if (character == '"') {
        if (inQuotes && index + 1 < input.length && input[index + 1] == '"') {
          field.write('"');
          index++;
        } else {
          inQuotes = !inQuotes;
        }
      } else if (character == ',' && !inQuotes) {
        row.add(field.toString().trim());
        field.clear();
      } else if ((character == '\n' || character == '\r') && !inQuotes) {
        if (character == '\r' &&
            index + 1 < input.length &&
            input[index + 1] == '\n') {
          index++;
        }
        row.add(field.toString().trim());
        field.clear();
        if (row.any((value) => value.isNotEmpty))
          rows.add(List<String>.from(row));
        row.clear();
      } else {
        field.write(character);
      }
    }
    if (field.isNotEmpty || row.isNotEmpty) {
      row.add(field.toString().trim());
      if (row.any((value) => value.isNotEmpty)) rows.add(row);
    }
    return rows;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(title: const Text('ALL DATA CENTERS')),
      body: FutureBuilder<List<_CsvDataCenter>>(
        future: _dataCentersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Could not load data centers: ${snapshot.error}'),
            );
          }
          final query = searchQuery.trim().toLowerCase();
          final dataCenters = (snapshot.data ?? []).where((center) {
            return query.isEmpty ||
                center.name.toLowerCase().contains(query) ||
                center.address.toLowerCase().contains(query) ||
                center.operator.toLowerCase().contains(query) ||
                center.details.toLowerCase().contains(query);
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search by name, operator, or address',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _openPublicDirectory,
                    icon: const Icon(Icons.open_in_new, size: 17),
                    label: const Text('VIEW ALL 176 PUBLIC LISTINGS'),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
                  itemCount: dataCenters.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final center = dataCenters[index];
                    return Card(
                      margin: EdgeInsets.zero,
                      color: Colors.white,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFEAF2F8),
                          child: Icon(Icons.dns, color: Color(0xFF145DA0)),
                        ),
                        title: Text(
                          center.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${center.operator}\n${center.address}\n${center.details}',
                        ),
                        isThreeLine: true,
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () => _showCenterDetails(context, center),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCenterDetails(BuildContext context, _CsvDataCenter center) {
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                center.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              _directoryDetail(Icons.business, 'Operator', center.operator),
              _directoryDetail(Icons.location_on, 'Address', center.address),
              _directoryDetail(Icons.info_outline, 'Details', center.details),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _openPublicDirectory() async {
    final uri = Uri.parse(
      'https://www.datacentermap.com/usa/virginia/ashburn/',
    );
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the public directory.')),
      );
    }
  }

  Widget _directoryDetail(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF145DA0)),
          const SizedBox(width: 10),
          Expanded(child: Text('$label: $value')),
        ],
      ),
    );
  }
}

class _CsvDataCenter {
  const _CsvDataCenter({
    required this.name,
    required this.address,
    required this.operator,
    required this.details,
  });

  final String name;
  final String address;
  final String operator;
  final String details;

  factory _CsvDataCenter.fromRow(List<String> row) {
    return _CsvDataCenter(
      name: row[0],
      address: row[1],
      operator: row[2],
      details: row[3],
    );
  }
}

class LearningDetailScreen extends StatelessWidget {
  const LearningDetailScreen({
    super.key,
    required this.pageType,
    required this.title,
    required this.intro,
    required this.statLabel,
    required this.facts,
    required this.highlight,
    required this.themeColor,
  });

  final String pageType;
  final String title;
  final String intro;
  final String statLabel;
  final List<String> facts;
  final String highlight;
  final Color themeColor;

  void _openDataCentersDirectory(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const DataCenterDirectoryScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surfaceColor = themeColor.withValues(alpha: 0.08);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                intro,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: themeColor.withValues(alpha: 0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      statLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: themeColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      highlight,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        height: 1.5,
                        color: Color(0xFF0C2D48),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              if (pageType == 'numbers') ...[
                const Text(
                  'Data centers built today',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '200+',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: themeColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Text(
                          'data centers built',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _openDataCentersDirectory(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF145DA0),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    icon: const Icon(Icons.open_in_new, size: 18),
                    label: const Text(
                      'DISPLAY ALL DATA CENTERS',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'What that number means',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Ashburn and the surrounding Loudoun County area — known as “Data Center Alley” — host more built data centers than anywhere else in the world. '
                        'Facilities here range from small colocation buildings to massive hyperscale campuses operated by major cloud providers, and new sites continue to be built as demand grows.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'An estimated 70%+ of the world’s internet traffic passes through this region each day.',
                        style: TextStyle(
                          fontSize: 13,
                          fontStyle: FontStyle.italic,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Planned & upcoming projects',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                ...const [
                  _PlannedProject(
                    name: 'Digital Realty Loudoun Expansion',
                    status: 'Under construction',
                    details:
                        'Additional data halls being added to the existing Loudoun County campus to meet rising cloud-provider demand.',
                  ),
                  _PlannedProject(
                    name: 'Amazon Web Services Campus Additions',
                    status: 'Approved',
                    details:
                        'New buildings approved to expand AWS’s existing footprint across several Loudoun County sites.',
                  ),
                  _PlannedProject(
                    name: 'Compass Datacenters Ashburn Site',
                    status: 'Permitted',
                    details:
                        'A new hyperscale campus permitted near existing infrastructure corridors, adding substantial power capacity.',
                  ),
                  _PlannedProject(
                    name: 'Loudoun County Rezoning Pipeline',
                    status: 'Proposed',
                    details:
                        'Several parcels are under review for rezoning to data-center use, signaling continued growth over the next decade.',
                  ),
                ],
              ] else if (pageType == 'power') ...[
                const Text(
                  'How the energy flows',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    children: [
                      _FlowStepRow(
                        label: 'Power',
                        value: 'Grid',
                        color: themeColor,
                      ),
                      const Divider(height: 24),
                      _FlowStepRow(
                        label: 'Cooling',
                        value: 'Chillers',
                        color: themeColor,
                      ),
                      const Divider(height: 24),
                      _FlowStepRow(
                        label: 'Compute',
                        value: 'Servers',
                        color: themeColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const _ResourceInfoCard(
                  icon: Icons.bolt_outlined,
                  iconColor: Color(0xFFB7791F),
                  backgroundColor: Color(0xFFFFF6E5),
                  title: 'Electricity',
                  description:
                      'Electricity powers the servers, network equipment, cooling systems, lighting, and backup systems. A large facility can draw tens of megawatts continuously, so local grid planning and reliable transmission are essential.',
                  estimate: 'Typical estimate: 20–50 MW per data center',
                  footer: _ElectricityUseChart(),
                ),
                const SizedBox(height: 12),
                _ResourceInfoCard(
                  icon: Icons.water_drop_outlined,
                  iconColor: Color(0xFF145DA0),
                  backgroundColor: Color(0xFFEAF2F8),
                  title: 'Water',
                  description:
                      'Water may be used by cooling towers and other cooling equipment to remove heat from servers. The amount depends on the facility design, weather, and whether it uses air cooling or a water-based system.',
                  estimate: 'Typical estimate: 300,000+ gallons per day',
                  footer: const _WaterTrendChart(),
                ),
              ] else ...[
                const Text(
                  'What this means locally',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Text(
                    'Digital infrastructure changes the local story — through jobs, infrastructure planning, and how communities build for growth.',
                    style: TextStyle(fontSize: 15, height: 1.6),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Jobs, benefits & tradeoffs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jobs and workforce',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF145DA0),
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        'Data-center construction and operations support jobs in engineering, electrical and mechanical trades, security, facilities maintenance, and network operations. Training and local-hiring commitments can determine how much of that opportunity reaches nearby residents.',
                        style: TextStyle(fontSize: 14, height: 1.6),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Benefits\n• Data-center tax revenue has helped fund schools, roads, and parks while supporting lower residential property tax rates than neighboring counties.\n• Construction and long-term operations bring local employment and business activity.\n• Community-facing dashboards and earmarked investments can make benefits easier to track.',
                        style: TextStyle(fontSize: 14, height: 1.7),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Tradeoffs and risks\n• LSARS estimates data centers contribute roughly 38–40% of Loudoun County revenue, creating budget risk if tax preferences or demand change.\n• Residents may experience noise, construction traffic, visual impacts, water competition, and electricity-rate concerns.\n• New projects can add infrastructure costs before the community knows who will pay.',
                        style: TextStyle(fontSize: 14, height: 1.7),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Source: LSARS, Data Centers in Loudoun County, Virginia.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF145DA0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Water and electricity: the community connection',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF7FAFC),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'What the charts show',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF145DA0),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Water: the Loudoun Water chart rises from 4 MGD in 2025 to a projected 22 MGD in 2050 — an increase of 18 MGD, or about 5.5 times the 2025 snapshot.\n\nElectricity: the Dominion Energy chart shows more than 4 GW of data-center capacity connected since 2019, including 933 MW connected during 2023.\n\nThese are different units and cannot be added together: water measures daily volume, while electricity measures continuous power capacity.',
                        style: TextStyle(fontSize: 14, height: 1.6),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'How the trends affect communities',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF145DA0),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Water growth can require new treatment, storage, reuse, and transmission capacity, while increasing competition for a shared utility resource.\n• Electricity growth requires generation and transmission investment; depending on rate design, those costs may affect data-center customers, other businesses, or residential ratepayers.\n• The same growth can support jobs and help fund schools, parks, and roads through tax revenue, but LSARS estimates data centers already represent roughly 38–40% of Loudoun County revenue, creating a dependency risk.\n• Community decisions therefore need both sides of the charts: economic gains and public-service funding alongside water, grid, traffic, noise, and affordability pressures.',
                        style: TextStyle(fontSize: 14, height: 1.7),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sources: Loudoun Water; Dominion Energy; LSARS, Data Centers in Loudoun County, Virginia.',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF145DA0),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Average resource use per data center',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Column(
                    children: [
                      _ResourceUseRow(
                        icon: Icons.bolt_outlined,
                        label: 'Power draw',
                        value: '20–50 MW',
                      ),
                      Divider(height: 24),
                      _ResourceUseRow(
                        icon: Icons.water_drop_outlined,
                        label: 'Water use',
                        value: '300,000+ gallons/day',
                      ),
                      Divider(height: 24),
                      _ResourceUseRow(
                        icon: Icons.landscape_outlined,
                        label: 'Land footprint',
                        value: '15–30 acres',
                      ),
                      Divider(height: 24),
                      _ResourceUseRow(
                        icon: Icons.volume_up_outlined,
                        label: 'Noise level',
                        value: '65–85 dB nearby',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Noise & air pollution',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const _PollutionInfoCard(
                  icon: Icons.volume_up_rounded,
                  iconColor: Color(0xFFB7791F),
                  backgroundColor: Color(0xFFFFF6E5),
                  title: 'Noise',
                  description:
                      'Cooling fans, chillers, and backup generators run continuously and can raise ambient sound near a facility, roughly comparable to a busy street or running dishwasher.',
                ),
                const SizedBox(height: 12),
                const _PollutionInfoCard(
                  icon: Icons.air_rounded,
                  iconColor: Color(0xFF0C7C59),
                  backgroundColor: Color(0xFFE8F8F1),
                  title: 'Air',
                  description:
                      'Diesel backup generators are tested regularly and used during outages, briefly producing emissions similar to truck traffic. Most day-to-day operations produce little direct air pollution.',
                ),
              ],
              const SizedBox(height: 20),
              const Text(
                'Key takeaways',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              ...facts.map(
                (fact) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, color: themeColor, size: 18),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            fact,
                            style: const TextStyle(fontSize: 14, height: 1.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FlowStepRow extends StatelessWidget {
  const _FlowStepRow({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          ),
        ),
      ],
    );
  }
}

class _PlannedProject extends StatelessWidget {
  const _PlannedProject({
    required this.name,
    required this.status,
    required this.details,
  });

  final String name;
  final String status;
  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAF2F8),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    status,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF145DA0),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              details,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResourceUseRow extends StatelessWidget {
  const _ResourceUseRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFF7C3AED)),
        const SizedBox(width: 12),
        Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class _ResourceInfoCard extends StatelessWidget {
  const _ResourceInfoCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.description,
    required this.estimate,
    this.footer,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String description;
  final String estimate;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: iconColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  estimate,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
                if (footer != null) ...[const SizedBox(height: 14), footer!],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ElectricityUseChart extends StatelessWidget {
  const _ElectricityUseChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'DOMINION ENERGY DATA CENTER CAPACITY',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
              color: Color(0xFFB7791F),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Northern Virginia cumulative connected capacity, gigawatts (GW)',
            style: TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 132,
            child: CustomPaint(
              size: const Size(double.infinity, 132),
              painter: _ElectricityUseChartPainter(),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Dominion reported more than 4 GW connected since 2019; 933 MW was connected during 2023. The line shows the published five-year increase, not annual measurements.',
            style: TextStyle(fontSize: 10, height: 1.35, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          const Text(
            'Source: Dominion Energy GS-5 Large Load Rate Class Report and Virginia Data Center Requests.',
            style: TextStyle(fontSize: 10, height: 1.35, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _ElectricityUseChartPainter extends CustomPainter {
  const _ElectricityUseChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const left = 34.0;
    const right = 12.0;
    const top = 12.0;
    const bottom = 28.0;
    const maximum = 4.5;
    final chartWidth = size.width - left - right;
    final chartHeight = size.height - top - bottom;
    final axisPaint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1;
    final gridPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = const Color(0xFFB7791F)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final dotPaint = Paint()..color = const Color(0xFFB7791F);
    final labelStyle = const TextStyle(fontSize: 10, color: Colors.black54);

    canvas.drawLine(
      const Offset(left, top),
      Offset(left, size.height - bottom),
      axisPaint,
    );
    canvas.drawLine(
      Offset(left, size.height - bottom),
      Offset(size.width - right, size.height - bottom),
      axisPaint,
    );

    for (final value in [0, 1, 2, 3, 4]) {
      final y = top + chartHeight * (1 - value / maximum);
      canvas.drawLine(
        Offset(left, y),
        Offset(size.width - right, y),
        gridPaint,
      );
      _drawText(canvas, '$value', Offset(10, y - 6), labelStyle);
    }

    final firstPoint = Offset(left, size.height - bottom);
    final secondPoint = Offset(
      left + chartWidth,
      top + chartHeight * (1 - 4 / maximum),
    );
    final path = ui.Path()
      ..moveTo(firstPoint.dx, firstPoint.dy)
      ..lineTo(secondPoint.dx, secondPoint.dy);
    canvas.drawPath(path, linePaint);
    canvas.drawCircle(firstPoint, 5, dotPaint);
    canvas.drawCircle(secondPoint, 5, dotPaint);
    _drawText(
      canvas,
      '2019',
      Offset(firstPoint.dx - 14, size.height - 20),
      labelStyle,
    );
    _drawText(
      canvas,
      'Baseline',
      Offset(firstPoint.dx - 18, firstPoint.dy - 18),
      labelStyle,
    );
    _drawText(
      canvas,
      '2023',
      Offset(secondPoint.dx - 14, size.height - 20),
      labelStyle,
    );
    _drawText(
      canvas,
      '4+ GW',
      Offset(secondPoint.dx - 18, secondPoint.dy - 18),
      labelStyle,
    );
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WaterTrendChart extends StatelessWidget {
  const _WaterTrendChart();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LOUDOUN WATER DATA-CENTER DEMAND',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
              color: Color(0xFF145DA0),
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Average consumptive use, million gallons per day (MGD)',
            style: TextStyle(fontSize: 11, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 150,
            child: CustomPaint(
              size: const Size(double.infinity, 150),
              painter: _WaterTrendChartPainter(),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Source: Loudoun Water published 2025 snapshot and 2050 projection. 2012-2020 values are historical estimates for context, not published year-by-year measurements.',
            style: TextStyle(fontSize: 10, height: 1.35, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

class _WaterTrendChartPainter extends CustomPainter {
  const _WaterTrendChartPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const left = 34.0;
    const right = 12.0;
    const top = 12.0;
    const bottom = 28.0;
    const maximum = 24.0;
    final chartHeight = size.height - top - bottom;
    final axisPaint = Paint()
      ..color = Colors.black26
      ..strokeWidth = 1;
    final gridPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 1;
    final linePaint = Paint()
      ..color = const Color(0xFF145DA0)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final dotPaint = Paint()..color = const Color(0xFF145DA0);
    final labelStyle = const TextStyle(fontSize: 10, color: Colors.black54);

    canvas.drawLine(
      const Offset(left, top),
      Offset(left, size.height - bottom),
      axisPaint,
    );
    canvas.drawLine(
      Offset(left, size.height - bottom),
      Offset(size.width - right, size.height - bottom),
      axisPaint,
    );

    for (final value in [0, 6, 12, 18, 24]) {
      final y = top + chartHeight * (1 - value / maximum);
      canvas.drawLine(
        Offset(left, y),
        Offset(size.width - right, y),
        gridPaint,
      );
      _drawText(canvas, '$value', Offset(4, y - 6), labelStyle);
    }

    const years = [
      '2012',
      '2013',
      '2014',
      '2015',
      '2016',
      '2017',
      '2018',
      '2019',
      '2020',
      '2025',
      '2050',
    ];
    const values = [2.0, 2.1, 2.2, 2.35, 2.5, 2.65, 2.8, 3.0, 3.2, 4.0, 22.0];
    final chartWidth = size.width - left - right;
    final points = List.generate(
      values.length,
      (index) => Offset(
        left + chartWidth * index / (values.length - 1),
        top + chartHeight * (1 - values[index] / maximum),
      ),
    );
    final path = ui.Path()..moveTo(points.first.dx, points.first.dy);
    for (final point in points.skip(1)) {
      path.lineTo(point.dx, point.dy);
    }
    canvas.drawPath(path, linePaint);
    for (final point in points) {
      canvas.drawCircle(point, 3.5, dotPaint);
    }
    for (final index in [0, 4, 8, 9, 10]) {
      final point = points[index];
      final yearOffset = index == 10 ? point.dx - 14 : point.dx - 12;
      _drawText(
        canvas,
        years[index],
        Offset(yearOffset, size.height - 20),
        labelStyle,
      );
    }
    _drawText(
      canvas,
      '2.0 MGD',
      Offset(points[0].dx - 14, points[0].dy - 18),
      labelStyle,
    );
    _drawText(
      canvas,
      '3.2 MGD',
      Offset(points[8].dx - 14, points[8].dy - 18),
      labelStyle,
    );
    _drawText(
      canvas,
      '4 MGD',
      Offset(points[9].dx - 14, points[9].dy - 18),
      labelStyle,
    );
    _drawText(
      canvas,
      '22 MGD',
      Offset(points[10].dx - 20, points[10].dy - 18),
      labelStyle,
    );
  }

  void _drawText(Canvas canvas, String text, Offset offset, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PollutionInfoCard extends StatelessWidget {
  const _PollutionInfoCard({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: iconColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: iconColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13.5,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HowInternetWorksScreen extends StatefulWidget {
  const HowInternetWorksScreen({super.key});

  @override
  State<HowInternetWorksScreen> createState() => _HowInternetWorksScreenState();
}

class _HowInternetWorksScreenState extends State<HowInternetWorksScreen> {
  int selectedIndex = 0;

  final List<_InternetJourneyStep> steps = const [
    _InternetJourneyStep(
      title: 'Your device sends data',
      subtitle: 'Your phone, laptop, or tablet is the starting point.',
      fact:
          'A single message can travel as millions of tiny data packets across a network.',
      detail:
          'Your app packages information into digital signals before it ever leaves your device.',
      accent: Color(0xFF145DA0),
    ),
    _InternetJourneyStep(
      title: 'Local networks carry it',
      subtitle: 'Wi‑Fi and fiber routes connect you to a wider network.',
      fact:
          'Fiber optic lines move data using light, which lets information travel very quickly.',
      detail:
          'Connections near homes and businesses act like local highways for internet traffic.',
      accent: Color(0xFF0C7C59),
    ),
    _InternetJourneyStep(
      title: 'Data centers process and route it',
      subtitle: 'Cloud services and servers help organize the flow.',
      fact:
          'Data centers help store, process, and deliver content for websites, apps, and services.',
      detail:
          'They act as major switching points that help move information to where it is needed.',
      accent: Color(0xFFB7791F),
    ),
    _InternetJourneyStep(
      title: 'It reaches its destination',
      subtitle: 'The request arrives at a server, app, or person.',
      fact:
          'The internet is really a huge network of connected systems working together in milliseconds.',
      detail:
          'Once it arrives, the destination sends information back through the same path in reverse.',
      accent: Color(0xFF7C3AED),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final step = steps[selectedIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(title: const Text('HOW THE INTERNET WORKS')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Follow the journey of your data',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'From your phone to the wider network and back again.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 64,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: steps.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 10),
                  itemBuilder: (context, index) {
                    final isSelected = index == selectedIndex;
                    return ChoiceChip(
                      label: Text('STEP ${index + 1}'),
                      selected: isSelected,
                      onSelected: (_) => setState(() => selectedIndex = index),
                      selectedColor: const Color(
                        0xFF145DA0,
                      ).withValues(alpha: 0.12),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? const Color(0xFF145DA0)
                            : Colors.black87,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: step.accent.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'PATHWAY ${selectedIndex + 1}',
                        style: TextStyle(
                          color: step.accent,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      step.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      step.subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAF2F8),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'Fact: ${step.fact}',
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Color(0xFF0C2D48),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      step.detail,
                      style: const TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Journey map',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: const Text(
                  'Your phone → Fiber → Data Center → Internet → Destination',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF145DA0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildActionChip(
                    label: 'Wi‑Fi',
                    onTap: () => setState(() => selectedIndex = 0),
                  ),
                  _buildActionChip(
                    label: 'Fiber',
                    onTap: () => setState(() => selectedIndex = 1),
                  ),
                  _buildActionChip(
                    label: 'Data center',
                    onTap: () => setState(() => selectedIndex = 2),
                  ),
                  _buildActionChip(
                    label: 'Destination',
                    onTap: () => setState(() => selectedIndex = 3),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionChip({
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFEAF2F8),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF145DA0),
          ),
        ),
      ),
    );
  }
}

class _InternetJourneyStep {
  const _InternetJourneyStep({
    required this.title,
    required this.subtitle,
    required this.fact,
    required this.detail,
    required this.accent,
  });

  final String title;
  final String subtitle;
  final String fact;
  final String detail;
  final Color accent;
}

class SourcesScreen extends StatelessWidget {
  const SourcesScreen({super.key});

  static const _sources = [
    (
      title: 'OpenStreetMap',
      description:
          'Live data center locations and facility tags shown on the Data on Map screen.',
    ),
    (
      title: 'Open-Meteo',
      description:
          'Live temperature and air quality (AQI, PM2.5, PM10) readings shown for facilities.',
    ),
    (
      title: 'Loudoun County Government & Economic Development',
      description:
          'Public information on data-center growth, zoning, and "Data Center Alley" figures.',
    ),
    (
      title: 'Industry & news reporting',
      description:
          'General estimates for typical data center power draw, water use, land footprint, and noise levels used throughout this app.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(title: const Text('SOURCES')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Where this information comes from',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This app combines live public data with commonly cited estimates. Figures are approximate and meant for educational purposes.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            for (final source in _sources)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      source.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      source.description,
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class DataCenterBuilderScreen extends StatefulWidget {
  const DataCenterBuilderScreen({super.key});

  @override
  State<DataCenterBuilderScreen> createState() =>
      _DataCenterBuilderScreenState();
}

class FutureDataCentersMapScreen extends StatefulWidget {
  const FutureDataCentersMapScreen({super.key});

  static const ashburn = LatLng(39.0438, -77.4874);
  static const plannedSites = [
    _FutureDataCenter(
      name: 'Dulles North Campus',
      location: LatLng(39.0650, -77.4850),
    ),
    _FutureDataCenter(
      name: 'Loudoun Gateway Campus',
      location: LatLng(39.0320, -77.5050),
    ),
    _FutureDataCenter(
      name: 'Broad Run Expansion',
      location: LatLng(39.0520, -77.4550),
    ),
    _FutureDataCenter(
      name: 'Sterling Fiber Corridor',
      location: LatLng(39.0200, -77.4180),
    ),
    _FutureDataCenter(
      name: 'Ashburn Technology Park',
      location: LatLng(39.0100, -77.5250),
    ),
    _FutureDataCenter(
      name: 'Loudoun Valley Compute Park',
      location: LatLng(39.0850, -77.5350),
    ),
  ];

  static const trafficPredictions = [
    _FutureTrafficPrediction(
      vehicleTrips: '350-500',
      peakWindows: '7:00-9:00 AM and 3:00-5:00 PM',
      roadEffect:
          'Expect more turning traffic near the main construction entrance.',
    ),
    _FutureTrafficPrediction(
      vehicleTrips: '280-420',
      peakWindows: '6:30-8:30 AM and 4:00-6:00 PM',
      roadEffect:
          'Expect short delivery queues where trucks join the gateway road.',
    ),
    _FutureTrafficPrediction(
      vehicleTrips: '220-360',
      peakWindows: '7:00-9:00 AM and 2:30-4:30 PM',
      roadEffect:
          'Expect temporary slowdowns on the approach to the expansion area.',
    ),
    _FutureTrafficPrediction(
      vehicleTrips: '180-300',
      peakWindows: '6:30-8:30 AM and 3:00-5:30 PM',
      roadEffect:
          'Expect added service traffic along the Sterling industrial corridor.',
    ),
    _FutureTrafficPrediction(
      vehicleTrips: '260-390',
      peakWindows: '7:00-9:00 AM and 4:00-6:00 PM',
      roadEffect:
          'Expect construction traffic near the technology park access roads.',
    ),
    _FutureTrafficPrediction(
      vehicleTrips: '300-460',
      peakWindows: '6:30-8:30 AM and 3:30-5:30 PM',
      roadEffect:
          'Expect longer truck routes during site preparation and build-out.',
    ),
  ];

  @override
  State<FutureDataCentersMapScreen> createState() =>
      _FutureDataCentersMapScreenState();
}

class _FutureDataCentersMapScreenState
    extends State<FutureDataCentersMapScreen> {
  int selectedSiteIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FUTURE DATA CENTERS')),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: FutureDataCentersMapScreen.ashburn,
              initialZoom: 12.2,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.datacenterapp',
              ),
              MarkerLayer(
                markers: [
                  for (
                    var index = 0;
                    index < FutureDataCentersMapScreen.plannedSites.length;
                    index++
                  )
                    Marker(
                      point: FutureDataCentersMapScreen
                          .plannedSites[index]
                          .location,
                      width: 46,
                      height: 46,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => selectedSiteIndex = index);
                          _showFutureSiteDetails(index);
                        },
                        child: Tooltip(
                          message: FutureDataCentersMapScreen
                              .plannedSites[index]
                              .name,
                          child: Icon(
                            Icons.construction,
                            color: index == selectedSiteIndex
                                ? const Color(0xFF145DA0)
                                : const Color(0xFFD97706),
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'POTENTIAL SITES: NEXT 10 YEARS',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Markers show illustrative future development areas, not approved projects.',
                      style: TextStyle(fontSize: 12, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    _buildProposedSitePreview(),
                    const SizedBox(height: 10),
                    _buildTrafficPrediction(),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 42,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            FutureDataCentersMapScreen.plannedSites.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final site =
                              FutureDataCentersMapScreen.plannedSites[index];
                          return ChoiceChip(
                            label: Text(site.name),
                            selected: index == selectedSiteIndex,
                            onSelected: (_) {
                              setState(() => selectedSiteIndex = index);
                              _showFutureSiteDetails(index);
                            },
                            selectedColor: const Color(0xFFEAF2F8),
                            labelStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: index == selectedSiteIndex
                                  ? const Color(0xFF145DA0)
                                  : Colors.black87,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProposedSitePreview() {
    final siteName =
        FutureDataCentersMapScreen.plannedSites[selectedSiteIndex].name;

    return Container(
      height: 156,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1E8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFB7CDB7)),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _ProposedSitePainter())),
          Positioned(
            left: 12,
            top: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '$siteName: illustrative view',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0C2D48),
                ),
              ),
            ),
          ),
          const Positioned(
            right: 12,
            top: 10,
            child: Text(
              'NOT TO SCALE',
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.bold,
                color: Color(0xFF42604A),
              ),
            ),
          ),
          const Positioned(
            left: 12,
            right: 12,
            bottom: 9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PreviewLegend(icon: Icons.apartment, label: 'building'),
                _PreviewLegend(icon: Icons.ac_unit, label: 'cooling'),
                _PreviewLegend(icon: Icons.bolt, label: 'power'),
                _PreviewLegend(icon: Icons.park, label: 'buffer'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrafficPrediction() {
    final prediction =
        FutureDataCentersMapScreen.trafficPredictions[selectedSiteIndex];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF6E5),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8C98A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.traffic, size: 17, color: Color(0xFF9A5B00)),
              SizedBox(width: 6),
              Text(
                'PEAK CONSTRUCTION TRAFFIC',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Color(0xFF9A5B00),
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            '${prediction.vehicleTrips} construction vehicle trips/day',
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5E3B00),
            ),
          ),
          const SizedBox(height: 3),
          Text(
            'Busiest windows: ${prediction.peakWindows}. ${prediction.roadEffect}',
            style: const TextStyle(
              fontSize: 11.5,
              height: 1.35,
              color: Color(0xFF5E3B00),
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Illustrative planning estimate during the busiest construction phase, not a traffic study.',
            style: TextStyle(
              fontSize: 10,
              fontStyle: FontStyle.italic,
              color: Color(0xFF7A5A2A),
            ),
          ),
        ],
      ),
    );
  }

  void _showFutureSiteDetails(int index) {
    final site = FutureDataCentersMapScreen.plannedSites[index];
    final place = InfrastructurePlace(
      name: site.name,
      location: site.location,
      tags: const {
        'status': 'Illustrative future site',
        'development_status': 'Potential development area',
        'cooling': 'Not yet specified',
      },
    );
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _PlaceDetailsSheet(place: place),
    );
  }
}

class _FutureDataCenter {
  const _FutureDataCenter({required this.name, required this.location});

  final String name;
  final LatLng location;
}

class _FutureTrafficPrediction {
  const _FutureTrafficPrediction({
    required this.vehicleTrips,
    required this.peakWindows,
    required this.roadEffect,
  });

  final String vehicleTrips;
  final String peakWindows;
  final String roadEffect;
}

class _PreviewLegend extends StatelessWidget {
  const _PreviewLegend({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: const Color(0xFF42604A)),
        const SizedBox(width: 3),
        Text(
          label,
          style: const TextStyle(fontSize: 10, color: Color(0xFF42604A)),
        ),
      ],
    );
  }
}

class _ProposedSitePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final roadPaint = Paint()..color = const Color(0xFFB7B7AC);
    final buildingPaint = Paint()..color = const Color(0xFF687887);
    final roofPaint = Paint()..color = const Color(0xFF425362);
    final coolingPaint = Paint()..color = const Color(0xFFB6D7E4);
    final powerPaint = Paint()
      ..color = const Color(0xFFD97706)
      ..strokeWidth = 2;
    final treePaint = Paint()..color = const Color(0xFF5F8F5E);

    canvas.drawRect(
      Rect.fromLTWH(0, size.height - 38, size.width, 38),
      roadPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.28,
        size.height * 0.33,
        size.width * 0.45,
        58,
      ),
      buildingPaint,
    );
    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.28,
        size.height * 0.33,
        size.width * 0.45,
        10,
      ),
      roofPaint,
    );

    for (var index = 0; index < 4; index++) {
      final x = size.width * 0.34 + index * 25;
      canvas.drawRect(
        Rect.fromLTWH(x, size.height * 0.48, 12, 20),
        coolingPaint,
      );
    }

    canvas.drawLine(
      Offset(size.width * 0.86, size.height * 0.18),
      Offset(size.width * 0.69, size.height * 0.4),
      powerPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.91, size.height * 0.23),
      Offset(size.width * 0.69, size.height * 0.43),
      powerPaint,
    );

    for (var index = 0; index < 7; index++) {
      final x = 18.0 + index * (size.width - 36) / 6;
      canvas.drawCircle(Offset(x, size.height - 53), 9, treePaint);
      canvas.drawRect(Rect.fromLTWH(x - 2, size.height - 49, 4, 12), treePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _DataCenterBuilderScreenState extends State<DataCenterBuilderScreen> {
  double capacityMegawatts = 50;
  double waterUseMultiplier = 1;
  double pollutionMultiplier = 1;
  double coolingOverhead = 1;

  @override
  Widget build(BuildContext context) {
    final electricityMegawattHours = (capacityMegawatts * coolingOverhead * 24)
        .round();
    final homesPowered = (capacityMegawatts * 750).round();
    final dailyWaterGallons = (capacityMegawatts * 12000 * waterUseMultiplier)
        .round();
    final dailyEmissionsPounds =
        (electricityMegawattHours * 850 * pollutionMultiplier).round();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(title: const Text('MAKE YOUR OWN DATA CENTER')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose a facility size',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Move the slider to see estimated community resource needs.',
                style: TextStyle(color: Colors.black87, height: 1.4),
              ),
              const SizedBox(height: 24),
              Text(
                '${capacityMegawatts.round()} MW capacity',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Slider(
                value: capacityMegawatts,
                min: 10,
                max: 200,
                divisions: 19,
                label: '${capacityMegawatts.round()} MW',
                onChanged: (value) => setState(() => capacityMegawatts = value),
              ),
              const SizedBox(height: 16),
              _buildSlider(
                title: 'Water consumption',
                value: waterUseMultiplier,
                min: 0.5,
                max: 2,
                divisions: 6,
                label: '${waterUseMultiplier.toStringAsFixed(1)}x',
                onChanged: (value) =>
                    setState(() => waterUseMultiplier = value),
              ),
              const SizedBox(height: 16),
              _buildSlider(
                title: 'Pollution level',
                value: pollutionMultiplier,
                min: 0.5,
                max: 2,
                divisions: 6,
                label: '${pollutionMultiplier.toStringAsFixed(1)}x',
                onChanged: (value) =>
                    setState(() => pollutionMultiplier = value),
              ),
              const SizedBox(height: 16),
              _buildSlider(
                title: 'Cooling efficiency',
                value: coolingOverhead,
                min: 0.7,
                max: 1.5,
                divisions: 8,
                label: '${coolingOverhead.toStringAsFixed(1)}x',
                onChanged: (value) => setState(() => coolingOverhead = value),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 12),
              _estimateCard(
                icon: Icons.bolt,
                title: 'Estimated electricity capacity',
                value: '$electricityMegawattHours MWh/day',
              ),
              const SizedBox(height: 12),
              _estimateCard(
                icon: Icons.home_outlined,
                title: 'Equivalent homes powered',
                value: '$homesPowered homes',
              ),
              const SizedBox(height: 12),
              _estimateCard(
                icon: Icons.water_drop_outlined,
                title: 'Estimated daily water use',
                value: '$dailyWaterGallons gallons',
              ),
              const SizedBox(height: 12),
              _estimateCard(
                icon: Icons.cloud_outlined,
                title: 'Estimated daily emissions',
                value: '$dailyEmissionsPounds lbs CO2',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required String title,
    required double value,
    required double min,
    required double max,
    required int divisions,
    required String label,
    required ValueChanged<double> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: divisions,
          label: label,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _estimateCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF145DA0)),
          const SizedBox(width: 12),
          Expanded(child: Text(title)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class DataCenterMapScreen extends StatefulWidget {
  const DataCenterMapScreen({super.key});

  @override
  State<DataCenterMapScreen> createState() => _DataCenterMapScreenState();
}

class _DataCenterMapScreenState extends State<DataCenterMapScreen> {
  static const ashburn = LatLng(39.0438, -77.4874);
  static const dataCenterSearchRadiusMeters = 25000;
  static const cacheDuration = Duration(minutes: 10);
  static List<InfrastructurePlace>? cachedPlaces;
  static DateTime? cacheTime;
  static final List<InfrastructurePlace> fallbackAshburnCenters = [
    for (final dc in kAshburnDataCenters)
      InfrastructurePlace(
        name: dc.name,
        location: dc.location,
        tags: {
          'name': dc.name,
          'operator': dc.operator,
          'address': dc.address,
          'capacity': dc.capacityMw,
          'cooling': dc.cooling,
        },
      ),
  ];

  List<InfrastructurePlace> places = [];
  bool isLoading = true;
  bool isShowingFallback = false;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    places = fallbackAshburnCenters.toList();
    isShowingFallback = true;
    final cacheIsFresh =
        cacheTime != null &&
        DateTime.now().difference(cacheTime!) < cacheDuration;
    if (cacheIsFresh && cachedPlaces != null) {
      places = cachedPlaces!;
      isLoading = false;
    } else {
      _loadOpenStreetMapPlaces(forceRefresh: true);
    }
  }

  Future<void> _loadOpenStreetMapPlaces({bool forceRefresh = false}) async {
    if (isLoading && places.isNotEmpty && !forceRefresh) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final query =
        '''
  [out:json][timeout:25];
  (nwr["building"="data_center"](around:$dataCenterSearchRadiusMeters,39.0438,-77.4874);
   nwr["telecom"="data_center"](around:$dataCenterSearchRadiusMeters,39.0438,-77.4874);
   nwr["industrial"="data_center"](around:$dataCenterSearchRadiusMeters,39.0438,-77.4874);
   nwr["man_made"="data_center"](around:$dataCenterSearchRadiusMeters,39.0438,-77.4874);
   nwr["name"~"data[ -]?cent(er|re)",i](around:$dataCenterSearchRadiusMeters,39.0438,-77.4874););
out center tags;
''';

    try {
      final endpoints = [
        'https://overpass-api.de/api/interpreter',
        'https://overpass.kumi.systems/api/interpreter',
      ];
      http.Response? response;
      for (final endpoint in endpoints) {
        try {
          final candidate = await http
              .get(
                Uri.parse(endpoint).replace(queryParameters: {'data': query}),
                headers: const {
                  'Accept': 'application/json',
                  'User-Agent': 'AshburnImpact/1.0 (community mapping app)',
                },
              )
              .timeout(const Duration(seconds: 6));
          if (candidate.statusCode == 200) {
            response = candidate;
            break;
          }
        } catch (_) {}
      }
      if (response == null) {
        throw Exception('No OpenStreetMap data server responded.');
      }
      if (response.statusCode != 200) {
        throw Exception('OpenStreetMap returned ${response.statusCode}.');
      }

      final json = jsonDecode(response.body) as Map<String, dynamic>;
      final elements = (json['elements'] as List<dynamic>? ?? [])
          .whereType<Map<String, dynamic>>()
          .map(InfrastructurePlace.fromJson)
          .where((place) => place != null)
          .cast<InfrastructurePlace>()
          .fold<Map<String, InfrastructurePlace>>({}, (unique, place) {
            unique['${place.location.latitude},${place.location.longitude}'] =
                place;
            return unique;
          })
          .values
          .toList();

      final isFallback = elements.isEmpty;
      final resolvedPlaces = isFallback
          ? fallbackAshburnCenters.toList()
          : elements;

      if (!mounted) return;
      setState(() {
        places = resolvedPlaces;
        isLoading = false;
        isShowingFallback = isFallback;
        errorMessage = isFallback
            ? 'No live OpenStreetMap matches were found.'
            : null;
      });
      cachedPlaces = resolvedPlaces;
      cacheTime = DateTime.now();
    } catch (_) {
      if (!mounted) return;
      setState(() {
        places = fallbackAshburnCenters.toList();
        isLoading = false;
        isShowingFallback = true;
        errorMessage = 'Live map data is unavailable.';
      });
      cachedPlaces = fallbackAshburnCenters.toList();
      cacheTime = DateTime.now();
    }
  }

  Future<void> _showPlaceDetails(InfrastructurePlace place) async {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _PlaceDetailsSheet(place: place),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DATA ON MAP'),
        actions: [
          IconButton(
            tooltip: 'Refresh map data',
            onPressed: isLoading
                ? null
                : () => _loadOpenStreetMapPlaces(forceRefresh: true),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: ashburn,
              initialZoom: 12.5,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.datacenterapp',
              ),
              MarkerLayer(
                markers: [
                  for (final place in places)
                    Marker(
                      point: place.location,
                      width: 44,
                      height: 44,
                      child: GestureDetector(
                        onTap: () => _showPlaceDetails(place),
                        child: Tooltip(
                          message: place.name,
                          child: const Icon(
                            Icons.dns,
                            color: Color(0xFF145DA0),
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _buildPlacePanel(),
          ),
        ],
      ),
    );
  }

  Widget _buildPlacePanel() {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(18),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: isLoading
            ? const Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  SizedBox(width: 12),
                  Text('Loading live OpenStreetMap data...'),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isShowingFallback
                        ? '${places.length} sample data centers shown (clickable)'
                        : errorMessage ??
                              (places.isEmpty
                                  ? 'No data centers found nearby'
                                  : '${places.length} data centers mapped nearby (clickable)'),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isShowingFallback
                        ? 'Live OpenStreetMap data could not provide the full inventory. Tap refresh to try again.'
                        : errorMessage == null && places.isNotEmpty
                        ? 'Data centers identified from OpenStreetMap.'
                        : 'Check your connection and tap refresh to try again.',
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  if (places.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 30,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: places.length,
                        separatorBuilder: (_, _) => const SizedBox(width: 8),
                        itemBuilder: (_, index) => GestureDetector(
                          onTap: () => _showPlaceDetails(places[index]),
                          child: Chip(
                            avatar: const Icon(Icons.dns, size: 16),
                            label: Text(places[index].name),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 8),
                  const Text(
                    'Map data OpenStreetMap contributors',
                    style: TextStyle(fontSize: 10, color: Colors.black45),
                  ),
                ],
              ),
      ),
    );
  }
}

class InfrastructurePlace {
  const InfrastructurePlace({
    required this.name,
    required this.location,
    required this.tags,
  });

  final String name;
  final LatLng location;
  final Map<String, dynamic> tags;

  static InfrastructurePlace? fromJson(Map<String, dynamic> json) {
    final tags = json['tags'] as Map<String, dynamic>? ?? {};
    final center = json['center'] as Map<String, dynamic>?;
    final latitude = json['lat'] as num? ?? center?['lat'] as num?;
    final longitude = json['lon'] as num? ?? center?['lon'] as num?;
    if (latitude == null || longitude == null) return null;

    return InfrastructurePlace(
      name: tags['name'] as String? ?? 'Data center',
      location: LatLng(latitude.toDouble(), longitude.toDouble()),
      tags: tags,
    );
  }
}

class _PlaceDetailsSheet extends StatefulWidget {
  const _PlaceDetailsSheet({required this.place});

  final InfrastructurePlace place;

  @override
  State<_PlaceDetailsSheet> createState() => _PlaceDetailsSheetState();
}

class _PlaceDetailsSheetState extends State<_PlaceDetailsSheet> {
  double? temperature;
  int? airQuality;
  double? pm25;
  double? pm10;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocalConditions();
  }

  Future<void> _loadLocalConditions() async {
    final latitude = widget.place.location.latitude;
    final longitude = widget.place.location.longitude;
    try {
      final uri = Uri.https('api.open-meteo.com', '/v1/forecast', {
        'latitude': '$latitude',
        'longitude': '$longitude',
        'current': 'temperature_2m',
        'temperature_unit': 'fahrenheit',
      });
      final airUri =
          Uri.https('air-quality-api.open-meteo.com', '/v1/air-quality', {
            'latitude': '$latitude',
            'longitude': '$longitude',
            'current': 'us_aqi,pm10,pm2_5',
          });
      final responses = await Future.wait([
        http.get(uri).timeout(const Duration(seconds: 8)),
        http.get(airUri).timeout(const Duration(seconds: 8)),
      ]);
      final weather = jsonDecode(responses[0].body) as Map<String, dynamic>;
      final quality = jsonDecode(responses[1].body) as Map<String, dynamic>;
      final currentWeather = weather['current'] as Map<String, dynamic>?;
      final currentAir = quality['current'] as Map<String, dynamic>?;
      if (!mounted) return;
      setState(() {
        temperature = (currentWeather?['temperature_2m'] as num?)?.toDouble();
        airQuality = (currentAir?['us_aqi'] as num?)?.round();
        pm25 = (currentAir?['pm2_5'] as num?)?.toDouble();
        pm10 = (currentAir?['pm10'] as num?)?.toDouble();
        isLoading = false;
      });
    } catch (_) {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final tags = widget.place.tags;
    final capacity =
        tags['capacity'] ?? tags['power'] ?? tags['capacity:power'];
    final cooling = tags['cooling'] ?? tags['cooling:method'];
    final campus = tags['operator'] ?? tags['brand'] ?? tags['site'];
    final status =
        tags['status'] ?? tags['building:use'] ?? tags['development_status'];
    final countyCase =
        tags['county_case'] ??
        tags['case_number'] ??
        tags['permit'] ??
        tags['planning:application'];
    final location =
        '${widget.place.location.latitude.toStringAsFixed(5)}, '
        '${widget.place.location.longitude.toStringAsFixed(5)}';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.place.name,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Data center details',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                TextButton.icon(
                  onPressed: () => _showCommunityImpact(context),
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFEAF2F8),
                    foregroundColor: const Color(0xFF145DA0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.groups_outlined, size: 18),
                  label: const Text('Community Impact'),
                ),
              ],
            ),
            const SizedBox(height: 18),
            _detailRow(Icons.location_on, 'Location', location),
            _detailRow(Icons.business, 'Facility / campus', _value(campus)),
            _detailRow(
              Icons.info_outline,
              'Status',
              _value(status, fallback: 'Not listed'),
            ),
            _detailRow(
              Icons.bolt,
              'Estimated power capacity',
              _value(capacity, suffix: capacity == null ? null : ' MW'),
            ),
            _detailRow(Icons.water_drop, 'Cooling method', _value(cooling)),
            _detailRow(
              Icons.gavel,
              'County case number',
              _value(countyCase, fallback: 'Not listed'),
            ),
            _detailRow(
              Icons.air,
              'Air quality (AQI)',
              isLoading
                  ? 'Loading...'
                  : airQuality == null
                  ? 'Unavailable'
                  : 'US AQI $airQuality',
            ),
            _detailRow(
              Icons.cloud,
              'Air pollution',
              isLoading
                  ? 'Loading...'
                  : (pm25 == null && pm10 == null)
                  ? 'Unavailable'
                  : 'PM2.5 ${pm25 ?? 0.0} µg/m³ • PM10 ${pm10 ?? 0.0} µg/m³',
            ),
            _detailRow(
              Icons.thermostat,
              'Local temperature',
              isLoading
                  ? 'Loading...'
                  : temperature == null
                  ? 'Unavailable'
                  : '${temperature!.toStringAsFixed(1)}°F',
            ),
            const SizedBox(height: 10),
            const Text(
              'Facility metadata from OpenStreetMap. Weather and air quality from Open-Meteo.',
              style: TextStyle(fontSize: 10, color: Colors.black45),
            ),
          ],
        ),
      ),
    );
  }

  String _value(
    Object? value, {
    String fallback = 'Not listed',
    String? suffix,
  }) {
    if (value == null || value.toString().trim().isEmpty) return fallback;
    final stringValue = value.toString();
    return suffix == null ? stringValue : '$stringValue$suffix';
  }

  Widget _detailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 21, color: const Color(0xFF145DA0)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCommunityImpact(BuildContext sheetContext) {
    final tags = widget.place.tags;
    final estimatedPower =
        tags['capacity'] ?? tags['power'] ?? tags['capacity:power'];
    final estimatedHomes = _estimateHomesPowered(estimatedPower);
    final coolingMethod =
        tags['cooling'] ?? tags['cooling:method'] ?? 'Not listed';
    final airSummary = airQuality == null
        ? 'Air quality data unavailable'
        : 'US AQI $airQuality • PM2.5 ${pm25 ?? 0.0} µg/m³ • PM10 ${pm10 ?? 0.0} µg/m³';
    final tempSummary = temperature == null
        ? 'Temperature unavailable'
        : '${temperature!.toStringAsFixed(1)}°F';

    showDialog(
      context: sheetContext,
      builder: (context) {
        return AlertDialog(
          title: const Text('COMMUNITY IMPACT'),
          content: SizedBox(
            width: 420,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'How does a data center use resources?',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Power capacity: ${estimatedPower ?? 'Not listed'} MW\n'
                    'Equivalent homes: ${estimatedHomes ?? 'Not listed'}\n'
                    'Cooling method: $coolingMethod',
                    style: const TextStyle(height: 1.6),
                  ),
                  const SizedBox(height: 18),
                  const Divider(),
                  const Text(
                    'Current local conditions',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Current air: $airSummary',
                    style: const TextStyle(
                      color: Color(0xFF145DA0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Live example: current air conditions near this site are ${airSummary.toLowerCase()}, which can be similar to traffic-heavy or smoke-affected conditions nearby.',
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Divider(),
                  const SizedBox(height: 18),
                  const Text(
                    '🌎 THE BIG PICTURE',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Data centers provide important\ndigital infrastructure, but they\nalso require resources.\n\nCurrent local temperature: $tempSummary\n\nExplore the data to understand\ntheir potential community impact.',
                    style: const TextStyle(height: 1.6),
                  ),
                  const SizedBox(height: 18),
                  const Divider(),
                  const SizedBox(height: 12),
                  const Text(
                    'Community benefit contributors',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Community benefits can show up in visible ways such as parks, support for seniors, and tax revenues that help fund local services. Source: lsars.com',
                    style: TextStyle(height: 1.6),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  int? _estimateHomesPowered(Object? powerValue) {
    final rawPower = powerValue?.toString() ?? '';
    final normalized = rawPower.replaceAll(RegExp(r'[^0-9.-]'), '');
    final megawatts = double.tryParse(normalized);
    if (megawatts == null) return null;
    return (megawatts * 750).round();
  }
}

class DataCenterNoiseSimulationScreen extends StatefulWidget {
  const DataCenterNoiseSimulationScreen({super.key});

  @override
  State<DataCenterNoiseSimulationScreen> createState() =>
      _DataCenterNoiseSimulationScreenState();
}

class _DataCenterNoiseSimulationScreenState
    extends State<DataCenterNoiseSimulationScreen> {
  double distanceMiles = 0.5;
  bool isPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  static const List<({double distance, String label, String desc})>
  _distancePresets = [
    (distance: 0.05, label: '0.05 mi (260 ft)', desc: 'Property fence line'),
    (distance: 0.1, label: '0.1 mi (528 ft)', desc: 'Adjacent street'),
    (
      distance: 0.25,
      label: '0.25 mi (1,320 ft)',
      desc: 'Nearest residential edge',
    ),
    (distance: 0.5, label: '0.5 mi (2,640 ft)', desc: 'Neighborhood boundary'),
    (distance: 1.0, label: '1.0 mi (5,280 ft)', desc: '1 mile away'),
    (distance: 2.0, label: '2.0 mi (10,560 ft)', desc: '2 miles away'),
  ];

  @override
  void initState() {
    super.initState();
    _audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _audioPlayer.dispose();
    super.dispose();
  }

  double _calculateDecibels(double distMiles) {
    final distanceFeet = max(50.0, distMiles * 5280.0);
    final dBA = 85.0 - 20.0 * (log(distanceFeet / 50.0) / ln10);
    return dBA.clamp(25.0, 88.0);
  }

  Uint8List _generateWavAudio(double distMiles) {
    const sampleRate = 22050;
    const durationSeconds = 3.0;
    final numSamples = (sampleRate * durationSeconds).toInt();

    final distanceFeet = max(50.0, distMiles * 5280.0);
    final dBA = _calculateDecibels(distMiles);
    double amplitude = pow(10.0, (dBA - 85.0) / 20.0).toDouble() * 4.0;
    amplitude = amplitude.clamp(0.001, 1.0);

    final filterAlpha = (800.0 / distanceFeet).clamp(0.02, 1.0);

    final bytes = Uint8List(44 + numSamples * 2);
    final byteData = ByteData.sublistView(bytes);

    bytes[0] = 0x52;
    bytes[1] = 0x49;
    bytes[2] = 0x46;
    bytes[3] = 0x46; // RIFF
    byteData.setUint32(4, 36 + numSamples * 2, Endian.little);
    bytes[8] = 0x57;
    bytes[9] = 0x41;
    bytes[10] = 0x56;
    bytes[11] = 0x45; // WAVE
    bytes[12] = 0x66;
    bytes[13] = 0x6D;
    bytes[14] = 0x74;
    bytes[15] = 0x20; // fmt
    byteData.setUint32(16, 16, Endian.little);
    byteData.setUint16(20, 1, Endian.little); // PCM
    byteData.setUint16(22, 1, Endian.little); // Mono
    byteData.setUint32(24, sampleRate, Endian.little);
    byteData.setUint32(28, sampleRate * 2, Endian.little);
    byteData.setUint16(32, 2, Endian.little);
    byteData.setUint16(34, 16, Endian.little);
    bytes[36] = 0x64;
    bytes[37] = 0x61;
    bytes[38] = 0x74;
    bytes[39] = 0x61; // data
    byteData.setUint32(40, numSamples * 2, Endian.little);

    double lastNoise = 0.0;
    final random = Random(42);

    for (var i = 0; i < numSamples; i++) {
      final t = i / sampleRate;
      final hum =
          sin(2 * pi * 60.0 * t) * 0.45 +
          sin(2 * pi * 120.0 * t) * 0.30 +
          sin(2 * pi * 180.0 * t) * 0.15 +
          sin(2 * pi * 85.0 * t) * 0.10 +
          sin(2 * pi * 240.0 * t) * 0.18 +
          sin(2 * pi * 480.0 * t) * 0.12 +
          sin(2 * pi * 720.0 * t) * 0.08;

      final rawNoise = (random.nextDouble() * 2.0 - 1.0) * 0.35;
      final filteredNoise = lastNoise + filterAlpha * (rawNoise - lastNoise);
      lastNoise = filteredNoise;

      final combinedSignal =
          (hum + filteredNoise + rawNoise * 0.25) * amplitude;
      final pcm16 = (combinedSignal * 32767.0).round().clamp(-32768, 32767);

      byteData.setInt16(44 + i * 2, pcm16, Endian.little);
    }

    return bytes;
  }

  Future<void> _togglePlayback() async {
    if (isPlaying) {
      await _audioPlayer.stop();
      setState(() => isPlaying = false);
    } else {
      try {
        await _updateAudioAndPlay();
        if (mounted) setState(() => isPlaying = true);
      } catch (_) {
        if (!mounted) return;
        setState(() => isPlaying = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not play the noise simulation.')),
        );
      }
    }
  }

  Future<void> _updateAudioAndPlay() async {
    final wavBytes = _generateWavAudio(distanceMiles);
    await _audioPlayer.stop();
    await _audioPlayer.play(BytesSource(wavBytes, mimeType: 'audio/wav'));
  }

  void _onDistanceChanged(double newDistance) {
    setState(() => distanceMiles = newDistance);
    if (isPlaying) {
      _updateAudioAndPlay();
    }
  }

  String _getComparisonText(double dBA) {
    if (dBA >= 75) {
      return 'Equivalent to standing near a loud vacuum cleaner, heavy HVAC plant, or busy main street.';
    } else if (dBA >= 65) {
      return 'Equivalent to a commercial outdoor air conditioning unit or normal conversational speech.';
    } else if (dBA >= 52) {
      return 'Equivalent to a quiet residential dishwasher or moderate rainfall outside.';
    } else if (dBA >= 40) {
      return 'Equivalent to a quiet suburban neighborhood at night or a quiet library.';
    } else if (dBA >= 32) {
      return 'Equivalent to a soft whisper or faint wind in nearby trees.';
    } else {
      return 'Equivalent to a quiet recording studio; essentially below the ambient outdoor noise floor.';
    }
  }

  Color _getDecibelColor(double dBA) {
    if (dBA >= 70) return const Color(0xFFD97706);
    if (dBA >= 50) return const Color(0xFF145DA0);
    return const Color(0xFF0C7C59);
  }

  @override
  Widget build(BuildContext context) {
    final currentdBA = _calculateDecibels(distanceMiles);
    final decibelColor = _getDecibelColor(currentdBA);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(title: const Text('NOISE SIMULATION')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Data Center Noise Simulator',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                'Listen to how cooling fans, chillers, and electrical transformers sound at different distances from a facility.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade200),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'DISTANCE FROM FACILITY',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                                color: decibelColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${distanceMiles < 0.1 ? (distanceMiles * 5280).round() : distanceMiles.toStringAsFixed(2)} ${distanceMiles < 0.1 ? 'ft' : 'miles'}',
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C2D48),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: decibelColor.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              Text(
                                '${currentdBA.round()} dBA',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: decibelColor,
                                ),
                              ),
                              const Text(
                                'ESTIMATED SOUND',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Slider(
                      value: distanceMiles,
                      min: 0.05,
                      max: 2.0,
                      divisions: 39,
                      activeColor: decibelColor,
                      label:
                          '${distanceMiles.toStringAsFixed(2)} mi (${currentdBA.round()} dBA)',
                      onChanged: _onDistanceChanged,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0.05 mi (Fence line)',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        Text(
                          '2.0 mi (2 miles away)',
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _togglePlayback,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isPlaying
                              ? const Color(0xFFD97706)
                              : const Color(0xFF145DA0),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 2,
                        ),
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_filled,
                          size: 26,
                        ),
                        label: Text(
                          isPlaying
                              ? 'PAUSE SOUND SIMULATION'
                              : 'PLAY NOISE SIMULATION',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Quick distance presets',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final preset in _distancePresets)
                    ChoiceChip(
                      label: Text(preset.label),
                      selected: (distanceMiles - preset.distance).abs() < 0.02,
                      onSelected: (_) => _onDistanceChanged(preset.distance),
                      selectedColor: const Color(0xFFEAF2F8),
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (distanceMiles - preset.distance).abs() < 0.02
                            ? const Color(0xFF145DA0)
                            : Colors.black87,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.graphic_eq, color: decibelColor, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'What this sound level means',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getComparisonText(currentdBA),
                      style: const TextStyle(
                        fontSize: 13.5,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2F8),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF145DA0).withValues(alpha: 0.2),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          color: Color(0xFF145DA0),
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'How noise is managed in Ashburn',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF145DA0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Loudoun County regulations require data centers to stay at or below 55 dBA at adjacent residential property boundaries at night. '
                      'Facilities use sound barrier walls, earth berms, water/air acoustic baffles, and directional fan louvers to absorb sound before it reaches nearby homes.',
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
