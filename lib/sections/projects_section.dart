import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/responsive_utils.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int selectedCategory = 0;
  final List<String> categories = ['All', 'Mobile', 'Web'];

  final List<Project> projects = [
    Project(
      title: 'AstroUnikon-Talk to Astrologer',
      description:
          'AstroUnikon connects users with astrologers through live chat and call features, Live Streams etc.',
      imageUrl: 'assets/images/astrounikon.png',
      category: 'Mobile',
      technologies: ['Flutter', 'Firebase', 'Razorpay', 'GetX'],
      githubUrl: '#',
      liveUrl:
          'https://play.google.com/store/apps/details?id=com.astrounikondiploy.user',
      color: const Color(0xFF6366F1),
    ),
    Project(
      title: 'AstroUnikon-Partner',
      description:
          'Astrologers connects users with AstroUnikon-Partner through live chat and call features, Live Streams etc.',
      imageUrl: 'assets/images/astrounikon.png',
      category: 'Mobile',
      technologies: ['Flutter', 'Firebase', 'Razorpay', 'GetX'],
      githubUrl: '#',
      liveUrl:
          'https://play.google.com/store/apps/details?id=com.astrounikondiploy.user',
      color: const Color(0xFF10B981),
    ),
    Project(
      title: 'Inventoresy',
      description:
          'Inventory Easy is a powerful and user-friendly inventory management system designed to help businesses efficiently track and manage their sales, purchases, expenses, and profits.',
      imageUrl: 'assets/images/inventory.png',
      category: 'Mobile',
      technologies: ['Dart', 'Flutter', 'REST API'],
      githubUrl: '#',
      liveUrl:
          'https://play.google.com/store/apps/details?id=com.inventoryeasy',
      color: const Color(0xFFF59E0B),
    ),
    Project(
      title: 'Portfolio Website',
      description:
          'Responsive portfolio website built with Flutter Web showcasing modern design principles.',
      imageUrl: 'assets/images/PP.png',
      category: 'Web',
      technologies: ['Flutter Web', 'Responsive Design', 'Animations'],
      githubUrl: '#',
      liveUrl: 'https://sandeep-portfolio-2025.web.app',
      color: const Color(0xFF8B5CF6),
    ),
  ];

  List<Project> get filteredProjects {
    if (selectedCategory == 0) return projects;
    return projects
        .where((project) => project.category == categories[selectedCategory])
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: ResponsiveUtils.sectionPadding(context),
        child: Column(
          children: [
            _buildSectionHeader(context),
            ResponsiveUtils.verticalSpace(
                context, ResponsiveUtils.isDesktop(context) ? 50 : 40),
            _buildCategoryFilter(context),
            ResponsiveUtils.verticalSpace(
                context, ResponsiveUtils.isDesktop(context) ? 50 : 40),
            _buildProjectsGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1024;
    final isTablet = size.width > 768 && size.width <= 1024;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF6366F1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Text(
            'My Work',
            style: TextStyle(
              color: Color(0xFF6366F1),
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Featured Projects',
          style: TextStyle(
            fontSize: isDesktop ? 36 : (isTablet ? 28 : 24),
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1E293B),
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isDesktop ? 600 : double.infinity,
          ),
          child: Text(
            'A collection of projects that showcase my skills and passion for development',
            style: TextStyle(
              fontSize: isDesktop ? 18 : (isTablet ? 16 : 14),
              color: Colors.grey[600],
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 768;

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(categories.length, (index) {
            final isSelected = selectedCategory == index;
            return GestureDetector(
              onTap: () => setState(() => selectedCategory = index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.only(
                  right: index < categories.length - 1 ? 12 : 0,
                  left: index == 0 ? (isMobile ? 16 : 0) : 0,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color:
                      isSelected ? const Color(0xFF6366F1) : Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF6366F1)
                        : Colors.grey[300]!,
                  ),
                ),
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: FontWeight.w600,
                    fontSize: isMobile ? 14 : 16,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    int crossAxisCount;
    double childAspectRatio;
    double crossAxisSpacing;
    double mainAxisSpacing;

    if (width >= 1200) {
      // Large Desktop
      crossAxisCount = 3;
      childAspectRatio = 0.75;
      crossAxisSpacing = 24;
      mainAxisSpacing = 24;
    } else if (width >= 1024) {
      // Desktop
      crossAxisCount = 2;
      childAspectRatio = 0.8;
      crossAxisSpacing = 20;
      mainAxisSpacing = 20;
    } else if (width >= 768) {
      // Tablet
      crossAxisCount = 2;
      childAspectRatio = 0.85;
      crossAxisSpacing = 16;
      mainAxisSpacing = 16;
    } else if (width >= 600) {
      // Small Tablet
      crossAxisCount = 1;
      childAspectRatio = 1.1;
      crossAxisSpacing = 16;
      mainAxisSpacing = 16;
    } else {
      // Mobile
      crossAxisCount = 1;
      childAspectRatio = 0.9;
      crossAxisSpacing = 16;
      mainAxisSpacing = 16;
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: filteredProjects.length,
      itemBuilder: (context, index) {
        return _buildProjectCard(filteredProjects[index], context);
      },
    );
  }

  Widget _buildProjectCard(Project project, BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width <= 768;
    final isSmallMobile = size.width <= 360;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Project Image Section
                Expanded(
                  flex: isMobile ? 2 : 2,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          color: Colors.grey[100],
                          child: Image.asset(
                            project.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              color: Colors.grey[200],
                              child: Icon(
                                Icons.image,
                                size: isMobile ? 40 : 60,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 8 : 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            project.category,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: isSmallMobile ? 10 : 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Project Info Section
                Expanded(
                  flex: isMobile ? 3 : 3,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(isMobile ? 16 : 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        Flexible(
                          child: Text(
                            project.title,
                            style: TextStyle(
                              fontSize: isMobile ? 16 : 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF1E293B),
                              height: 1.2,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: isMobile ? 8 : 12),

                        // Description
                        Flexible(
                          child: Text(
                            project.description,
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 14,
                              color: Colors.grey[600],
                              height: 1.4,
                            ),
                            maxLines: isMobile ? 2 : 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: isMobile ? 8 : 12),

                        // Technologies
                        Flexible(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children:
                                  project.technologies.take(3).map((tech) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 6),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 6 : 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: project.color.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    tech,
                                    style: TextStyle(
                                      fontSize: isSmallMobile ? 9 : 10,
                                      color: project.color,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(height: isMobile ? 12 : 16),

                        // Action Button
                        SizedBox(
                          width: double.infinity,
                          height: isMobile ? 36 : 40,
                          child: _buildActionButton(
                            'View Live',
                            Icons.launch,
                            project.color,
                            () async {
                              final Uri url = Uri.parse(project.liveUrl);
                              if (!await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw 'Could not launch $url';
                              }
                            },
                            isMobile,
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
      },
    );
  }

  Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    Future<void> Function()? onTap,
    bool isMobile,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: isMobile ? 14 : 16,
            ),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isMobile ? 11 : 12,
                  fontWeight: FontWeight.w600,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Project {
  final String title;
  final String description;
  final String imageUrl;
  final String category;
  final List<String> technologies;
  final String githubUrl;
  final String liveUrl;
  final Color color;

  Project({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
    required this.technologies,
    required this.githubUrl,
    required this.liveUrl,
    required this.color,
  });
}
