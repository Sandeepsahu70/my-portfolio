import 'package:flutter/material.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  final List<Experience> experiences = const [
    Experience(
      company: 'WebSenor',
      position: 'Flutter Developer',
      period: '02/2025 – Present',
      location: 'Udaipur, Rajasthan',
      description:
      'Developing scalable mobile apps with adaptive UIs and optimized state management for performance.',
      achievements: [
        'Designed 200+ adaptive screens using Flutter widgets for a seamless user experience',
        'Delivered 3 user interfaces for mobile apps within 5 months',
        'Engineered robust state management using GetX and Provider, increasing maintainability by 40%',
        'Integrated multiple RESTful APIs, optimizing data handling and reducing loading time by 25%',
        'Collaborated in Agile sprints with designers and testers, achieving a 95% on-time delivery rate',
        'Conducted code reviews and maintained technical documentation to support scaling',
        'Resolved bugs through performance optimization and UI rendering fixes',
      ],
      technologies: ['Flutter', 'GetX', 'Provider', 'REST API', 'Agile'],
      color: Color(0xFF6366F1),
      isCurrentJob: true,
    ),
    Experience(
      company: 'AinFit Innovation',
      position: 'Flutter Developer Intern',
      period: '05/2024 – 07/2024',
      location: 'Noida, UttarPradesh',
      description:
      'Contributed to cross-platform app development during internship, creating reusable widgets and enhancing navigation flows.',
      achievements: [
        'Created 15+ responsive UIs using Stateless and Stateful widgets across Android and iOS',
        'Streamlined navigation flows using named routes for enhanced usability',
        'Authored reusable custom widgets ensuring consistent UI components across the app',
        'Resolved 20+ bugs through performance optimization and UI rendering fixes',
      ],
      technologies: ['Flutter', 'Dart', 'Named Routes', 'Custom Widgets'],
      color: Color(0xFF10B981),
      isCurrentJob: false,
    ),
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
            _buildTimeline(isDesktop),
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
            'Experience',
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
          'Professional Journey',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'My professional experience and the amazing companies I\'ve worked with',
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey[600],
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildTimeline(bool isDesktop) {
    return Column(
      children: experiences.asMap().entries.map((entry) {
        final index = entry.key;
        final experience = entry.value;
        final isLast = index == experiences.length - 1;

        return _buildTimelineItem(experience, isLast, isDesktop);
      }).toList(),
    );
  }

  Widget _buildTimelineItem(Experience experience, bool isLast, bool isDesktop) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: experience.color,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: experience.color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 120,
                color: Colors.grey[300],
                margin: const EdgeInsets.symmetric(vertical: 8),
              ),
          ],
        ),
        const SizedBox(width: 24),

        // Experience card
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 40),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildExperienceHeader(experience, isDesktop),
                const SizedBox(height: 16),
                _buildExperienceDescription(experience),
                const SizedBox(height: 24),
                _buildAchievements(experience),
                const SizedBox(height: 24),
                _buildTechnologies(experience),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceHeader(Experience experience, bool isDesktop) {
    return isDesktop
        ? Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    experience.position,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  if (experience.isCurrentJob) ...[
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'Current',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                experience.company,
                style: TextStyle(
                  fontSize: 18,
                  color: experience.color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: experience.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                experience.period,
                style: TextStyle(
                  color: experience.color,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 14,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 4),
                Text(
                  experience.location,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    )
        : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              experience.position,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            if (experience.isCurrentJob) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'Current',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          experience.company,
          style: TextStyle(
            fontSize: 16,
            color: experience.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
          Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: experience.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                experience.period,
                style: TextStyle(
                  color: experience.color,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 12,
                  color: Colors.grey[500],
                ),
                const SizedBox(width: 2),
                Text(
                  experience.location,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceDescription(Experience experience) {
    return Text(
      experience.description,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
        height: 1.6,
      ),
    );
  }

  Widget _buildAchievements(Experience experience) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Key Achievements',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 12),
        ...experience.achievements.map((achievement) => Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 6,
                height: 6,
                margin: const EdgeInsets.only(top: 6, right: 12),
                decoration: BoxDecoration(
                  color: experience.color,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Text(
                  achievement,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }

  Widget _buildTechnologies(Experience experience) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Technologies Used',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: experience.technologies
              .map((tech) => Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: experience.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: experience.color.withOpacity(0.3),
              ),
            ),
            child: Text(
              tech,
              style: TextStyle(
                color: experience.color,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ))
              .toList(),
        ),
      ],
    );
  }
}

class Experience {
  final String company;
  final String position;
  final String period;
  final String location;
  final String description;
  final List<String> achievements;
  final List<String> technologies;
  final Color color;
  final bool isCurrentJob;

  const Experience({
    required this.company,
    required this.position,
    required this.period,
    required this.location,
    required this.description,
    required this.achievements,
    required this.technologies,
    required this.color,
    required this.isCurrentJob,
  });
}
