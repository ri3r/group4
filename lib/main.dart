import 'package:flutter/material.dart';

void main() {
  runApp(const TeamApp());
}

class TeamApp extends StatelessWidget {
  const TeamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      home: const TeamScreen(),
    );
  }
}

class TeamMember {
  final String name;
  final String studentId;
  final String email;
  final String imageUrl;
  final Color accentColor;

  TeamMember({
    required this.name,
    required this.studentId,
    required this.email,
    required this.imageUrl,
    required this.accentColor,
  });
}

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<TeamScreen> createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  final PageController _controller = PageController(viewportFraction: 0.86);
  int _currentPage = 0;

  late final List<TeamMember> team;

  @override
  void initState() {
    super.initState();
    team = [
      TeamMember(
        name: "Shahin Firuzi",
        studentId: "2304466",
        email: "shahin.firuzi@tuni.fi",
        imageUrl: "https://randomuser.me/api/portraits/men/1.jpg",
        accentColor: Colors.indigo,
      ),
      TeamMember(
        name: "Chen Chen",
        studentId: "2304457",
        email: "chen.chen@tuni.fi",
        imageUrl: "https://randomuser.me/api/portraits/men/2.jpg",
        accentColor: Colors.teal,
      ),
      TeamMember(
        name: "Dániel Zetovics",
        studentId: "2600143",
        email: "daniel.zetovics@tuni.fi",
        imageUrl: "https://randomuser.me/api/portraits/men/3.jpg",
        accentColor: Colors.deepPurple,
      ),
      TeamMember(
        name: "Elisa Holzheid",
        studentId: "6123103",
        email: "Elisa.holzheid@study.thws.de",
        imageUrl: "lib/assets/images/elisa.png",
        accentColor: Colors.pink,
      ),
      TeamMember(
        name: "Edin Putzu",
        studentId: "5121046",
        email: "edin.putzu@study.thws.de",
        imageUrl: "https://randomuser.me/api/portraits/men/4.jpg",
        accentColor: Colors.blue,
      ),
      TeamMember(
        name: "Gino Chianese",
        studentId: "5024401",
        email: "Gino.Chianese@study.thws.de",
        imageUrl: "lib/assets/images/gino.png",
        accentColor: Colors.green,
      ),
    ];

    _controller.addListener(() {
      final page = _controller.page ?? 0.0;
      final int rounded = page.round();
      if (rounded != _currentPage) {
        setState(() => _currentPage = rounded);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 204),
        elevation: 0,
        scrolledUnderElevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: 28),
          onPressed: () {},
        ),
        title: const Text(
          "Group 4 - Mobile Applications",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline, size: 22, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titel & Beschreibung
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Group 4 - Mobile Applications",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Meet the members of Group 4 from Finland to Germany",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            // Carousel (Paged)
            SizedBox(
              height: 420,
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _controller,
                      itemCount: team.length,
                      padEnds: false,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final member = team[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          child: TeamCard(member: member),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(team.length, (i) {
                      final bool active = i == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        width: active ? 18 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: active
                              ? Theme.of(context).primaryColor
                              : const Color(0xFFE2E8F0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            // Call to Action (CTA)
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.indigo[600],
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withValues(alpha: 76),

                      blurRadius: 15,
                      offset: const Offset(0, 8),
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
}

class TeamCard extends StatelessWidget {
  final TeamMember member;

  const TeamCard({super.key, required this.member});

  Widget _buildMemberImage(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 90,
          height: 90,
          color: Colors.grey[300],
          child: const Icon(Icons.person),
        ),
      );
    } else {
      return Image.asset(
        imageUrl,
        width: 90,
        height: 90,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 90,
          height: 90,
          color: Colors.grey[300],
          child: const Icon(Icons.person),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 13),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  color: member.accentColor,
                ),
                Positioned(
                  bottom: -40,
                  left: 24,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 4),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 26),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                     child: _buildMemberImage(member.imageUrl),
                    ),
                  ),
                ),
              ],
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 56, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "ID: ${member.studentId}",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      member.email,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        _socialIcon(Icons.email),
                      ],
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

  Widget _socialIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, size: 18, color: const Color(0xFF475569)),
    );
  }
}