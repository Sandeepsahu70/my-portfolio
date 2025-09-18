import 'package:flutter/material.dart';
import '../utils/responsive_utils.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFF8FAFC),
      child: Padding(
        padding: ResponsiveUtils.sectionPadding(context),
        child: Column(
          children: [
            _buildSectionHeader(context),
            ResponsiveUtils.verticalSpace(
                context, ResponsiveUtils.isDesktop(context) ? 80 : 50),
            ResponsiveUtils.isDesktop(context)
                ? _buildDesktopLayout(context)
                : _buildMobileLayout(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: ResponsiveUtils.paddingSymmetric(context,
              horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius:
            BorderRadius.circular(ResponsiveUtils.radius(context, 50)),
          ),
          child: Text(
            'About Me',
            style: TextStyle(
              color: const Color(0xFF6366F1),
              fontSize: ResponsiveUtils.fontSize(context, 14),
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        ResponsiveUtils.verticalSpace(context, 16),
        Text(
          'Passionate Developer',
          style: ResponsiveUtils.headingLarge(context).copyWith(
            color: const Color(0xFF1E293B),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildAboutContent(context),
        ),
        ResponsiveUtils.horizontalSpace(context, 80),
        Expanded(
          flex: 1,
          child: _buildSkillsSection(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAboutContent(context),
        ResponsiveUtils.verticalSpace(context, 50),
        _buildSkillsSection(context),
      ],
    );
  }

  Widget _buildAboutContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatsRow(context),
        ResponsiveUtils.verticalSpace(context, 40),
        _buildAboutText(context),
        ResponsiveUtils.verticalSpace(context, 30),
        _buildFeatures(context),
      ],
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    // Always use row layout regardless of screen size
    return Row(
      children: [
        Expanded(
            child: _buildStatCard(context, '1+', 'Years\nExperience')),
        ResponsiveUtils.horizontalSpace(context, 20),
        Expanded(
            child: _buildStatCard(context, '10+', 'Projects\nCompleted')),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String number, String label) {
    return Container(
      padding: ResponsiveUtils.paddingAll(context, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(ResponsiveUtils.radius(context, 16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: ResponsiveUtils.width(context, 20),
            offset: Offset(0, ResponsiveUtils.height(context, 10)),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            number,
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSize(
                  context, ResponsiveUtils.isMobile(context) ? 24 : 32),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF6366F1),
            ),
          ),
          ResponsiveUtils.verticalSpace(context, 8),
          Text(
            label,
            style: ResponsiveUtils.bodySmall(context).copyWith(
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAboutText(BuildContext context) {
    final textStyle = ResponsiveUtils.bodyLarge(context).copyWith(
      color: Colors.grey[700],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello! I\'m a passionate Flutter developer with a love for creating beautiful, functional, and user-friendly mobile applications.',
          style: textStyle,
        ),
        ResponsiveUtils.verticalSpace(context, 20),
        Text(
          'I specialize in cross-platform development using Flutter and have experience working with various state management solutions, backend integration, and modern UI/UX principles.',
          style: textStyle,
        ),
        ResponsiveUtils.verticalSpace(context, 20),
        Text(
          'When I\'m not coding, you can find me exploring new technologies, contributing to open-source projects, or enjoying a good cup of coffee while planning my next big project.',
          style: textStyle,
        ),
      ],
    );
  }

  Widget _buildFeatures(BuildContext context) {
    final features = [
      {
        'icon': Icons.mobile_friendly,
        'title': 'Mobile First',
        'desc': 'Responsive design for all devices'
      },
      {
        'icon': Icons.speed,
        'title': 'Fast Performance',
        'desc': 'Optimized for speed and efficiency'
      },
      {
        'icon': Icons.brush,
        'title': 'Modern UI',
        'desc': 'Beautiful and intuitive interfaces'
      },
    ];

    return Column(
      children: features
          .map((feature) => Padding(
        padding: ResponsiveUtils.paddingOnly(context, bottom: 20),
        child: Row(
          children: [
            Container(
              width: ResponsiveUtils.width(context, 48),
              height: ResponsiveUtils.height(context, 48),
              decoration: BoxDecoration(
                color: const Color(0xFF6366F1).withOpacity(0.1),
                borderRadius: BorderRadius.circular(
                    ResponsiveUtils.radius(context, 12)),
              ),
              child: Icon(
                feature['icon'] as IconData,
                color: const Color(0xFF6366F1),
                size: ResponsiveUtils.width(context, 24),
              ),
            ),
            ResponsiveUtils.horizontalSpace(context, 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feature['title'] as String,
                    style:
                    ResponsiveUtils.headingSmall(context).copyWith(
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    feature['desc'] as String,
                    style: ResponsiveUtils.bodySmall(context).copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ))
          .toList(),
    );
  }

  Widget _buildSkillsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Skills & Technologies',
          style: ResponsiveUtils.headingMedium(context).copyWith(
            color: const Color(0xFF1E293B),
          ),
        ),
        ResponsiveUtils.verticalSpace(context, 24),
        ...skills.map((skill) => _buildSkillItem(context, skill)),
      ],
    );
  }

  Widget _buildSkillItem(BuildContext context, Skill skill) {
    return Container(
      margin: ResponsiveUtils.paddingOnly(context, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                skill.name,
                style: ResponsiveUtils.headingSmall(context).copyWith(
                  color: const Color(0xFF1E293B),
                ),
              ),
              Text(
                '${(skill.level * 100).toInt()}%',
                style: ResponsiveUtils.bodySmall(context).copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          ResponsiveUtils.verticalSpace(context, 8),
          Container(
            height: ResponsiveUtils.height(context, 6),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius:
              BorderRadius.circular(ResponsiveUtils.radius(context, 3)),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: skill.level,
              child: Container(
                decoration: BoxDecoration(
                  color: skill.color,
                  borderRadius:
                  BorderRadius.circular(ResponsiveUtils.radius(context, 3)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}