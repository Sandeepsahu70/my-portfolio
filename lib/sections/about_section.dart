import 'package:flutter/material.dart';


class Skill {
  final String name;
  final double level;
  final Color color;


  Skill(this.name, this.level, this.color);
}

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection> {
  final List<Skill> skills = [
    Skill('Flutter', 0.95, const Color(0xFF02569B)),
    Skill('Dart', 0.90, const Color(0xFF0175C2)),
    Skill('Firebase', 0.85, const Color(0xFFFFCA28)),
    Skill('GetX', 0.88, const Color(0xFF9C27B0)),
    Skill('REST API', 0.82, const Color(0xFF4CAF50)),
    Skill('Git', 0.80, const Color(0xFFFF5722)),
    Skill('UI/UX', 0.75, const Color(0xFFE91E63)),
    // Skill('Node.js', 0.70, const Color(0xFF68A063)),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 768;

    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isDesktop ? 80 : 20,
          vertical: isDesktop ? 100 : 60,
        ),
        child: Column(
          children: [
            _buildSectionHeader(),
            SizedBox(height: isDesktop ? 80 : 50),
            isDesktop 
                ? _buildDesktopLayout() 
                : _buildMobileLayout(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Text(
            'About Me',
            style: TextStyle(
              color: Color(0xFF6366F1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Passionate Developer ',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildAboutContent(),
        ),
        const SizedBox(width: 80),
        Expanded(
          flex: 1,
          child: _buildSkillsSection(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildAboutContent(),
        const SizedBox(height: 50),
        _buildSkillsSection(),
      ],
    );
  }

  Widget _buildAboutContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsRow(),
        const SizedBox(height: 40),
        _buildAboutText(),
        const SizedBox(height: 30),
        _buildFeatures(),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildStatCard('1+', 'Years\nExperience')),
        const SizedBox(width: 20),
        Expanded(child: _buildStatCard('10+', 'Projects\nCompleted')),
        // const SizedBox(width: 20),
        // Expanded(child: _buildStatCard('100%', 'Client\nSatisfaction')),
      ],
    );
  }

  Widget _buildStatCard(String number, String label) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            number,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6366F1),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello! I\'m a passionate Flutter developer with a love for creating beautiful, functional, and user-friendly mobile applications.',
          style: TextStyle(
            fontSize: 18,
            height: 1.7,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'I specialize in cross-platform development using Flutter and have experience working with various state management solutions, backend integration, and modern UI/UX principles.',
          style: TextStyle(
            fontSize: 18,
            height: 1.7,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'When I\'m not coding, you can find me exploring new technologies, contributing to open-source projects, or enjoying a good cup of coffee while planning my next big project.',
          style: TextStyle(
            fontSize: 18,
            height: 1.7,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }

  Widget _buildFeatures() {
    final features = [
      {'icon': Icons.mobile_friendly, 'title': 'Mobile First', 'desc': 'Responsive design for all devices'},
      {'icon': Icons.speed, 'title': 'Fast Performance', 'desc': 'Optimized for speed and efficiency'},
      {'icon': Icons.brush, 'title': 'Modern UI', 'desc': 'Beautiful and intuitive interfaces'},
      // {'icon': Icons.support_agent, 'title': '24/7 Support', 'desc': 'Always available for my clients'},
    ];

    return Column(
      children: features.map((feature) => Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                feature['icon'] as IconData,
                color: const Color(0xFF6366F1),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature['title'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    feature['desc'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      )).toList(),
    );
  }

  Widget _buildSkillsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skills & Technologies',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 24),
        ...skills.map((skill) => _buildSkillItem(skill)).toList(),
      ],
    );
  }

  Widget _buildSkillItem( skill) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
              Text(
                '${(skill.level * 100).toInt()}%',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: skill.level,
              child: Container(
                decoration: BoxDecoration(
                  color: skill.color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
