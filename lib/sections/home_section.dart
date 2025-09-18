import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../utils/responsive_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _particleController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  final Uri resumeUrl = Uri.parse(
    "https://drive.google.com/uc?export=download&id=1Yh1Xk-_AWAhW4NNdnS9exT9_QJQx34kD",
  );

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 1.0, curve: Curves.elasticOut),
    ));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF667EEA),
            Color(0xFF764BA2),
            Color(0xFF6B73FF),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated background particles
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, child) => CustomPaint(
              painter: ParticlesPainter(_particleController.value),
              size: size,
            ),
          ),

          // Main content
          SafeArea(
            child: Padding(
              padding: ResponsiveUtils.sectionPadding(context),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: ResponsiveUtils.isDesktop(context)
                          ? _buildDesktopLayout(context)
                          : _buildMobileLayout(context),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGreeting(context),
              ResponsiveUtils.verticalSpace(context, 15),
              _buildName(context),
              ResponsiveUtils.verticalSpace(context, 20),
              _buildTitle(context),
              ResponsiveUtils.verticalSpace(context, 20),
              _buildDescription(context),
              ResponsiveUtils.verticalSpace(context, 30),
              _buildActionButtons(context),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: _buildProfileImage(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(context),
        ResponsiveUtils.verticalSpace(context, 30),
        _buildGreeting(context),
        ResponsiveUtils.verticalSpace(context, 15),
        _buildName(context),
        ResponsiveUtils.verticalSpace(context, 15),
        _buildTitle(context),
        ResponsiveUtils.verticalSpace(context, 25),
        _buildDescription(context),
        ResponsiveUtils.verticalSpace(context, 30),
        _buildActionButtons(context),
      ],
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return Container(
      padding: ResponsiveUtils.paddingSymmetric(context,
          horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius:
            BorderRadius.circular(ResponsiveUtils.radius(context, 50)),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Text(
        '👋 Hello, I\'m',
        style: TextStyle(
          color: Colors.white,
          fontSize: ResponsiveUtils.fontSize(context, 16),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Color(0xFFE0E7FF)],
      ).createShader(bounds),
      child: Text(
        'Sandeep Teli',
        style: TextStyle(
          fontSize: ResponsiveUtils.fontSize(
              context,
              ResponsiveUtils.isMobile(context)
                  ? 32
                  : ResponsiveUtils.isTablet(context)
                      ? 40
                      : 48),
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.1,
          letterSpacing: -1,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              'Flutter Developer',
              style: TextStyle(
                color: Colors.white,
                fontSize: ResponsiveUtils.fontSize(
                    context,
                    ResponsiveUtils.isMobile(context)
                        ? 18
                        : ResponsiveUtils.isTablet(context)
                            ? 20
                            : 24),
                fontWeight: FontWeight.w600,
              ),
            ),
            ResponsiveUtils.horizontalSpace(context, 12),
            Container(
              width: ResponsiveUtils.width(context, 8),
              height: ResponsiveUtils.height(context, 8),
              decoration: const BoxDecoration(
                color: Color(0xFF10B981),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
        ResponsiveUtils.verticalSpace(context, 8),
        Text(
          '1+ Years Experience',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: ResponsiveUtils.fontSize(
                context,
                ResponsiveUtils.isMobile(context)
                    ? 14
                    : ResponsiveUtils.isTablet(context)
                        ? 16
                        : 18),
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      'Passionate about creating beautiful, performant mobile applications with Flutter. I love turning complex problems into simple, elegant solutions.',
      style: ResponsiveUtils.bodyLarge(context).copyWith(
        color: Colors.white.withOpacity(0.9),
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ResponsiveUtils.isMobile(context)
        ? Column(
            children: [
              _buildPrimaryButton(context),
              ResponsiveUtils.verticalSpace(context, 12),
              _buildSecondaryButton(context),
            ],
          )
        : Row(
            children: [
              _buildPrimaryButton(context),
              ResponsiveUtils.horizontalSpace(context, 16),
              _buildSecondaryButton(context),
            ],
          );
  }

  Widget _buildPrimaryButton(BuildContext context) {
    return Container(
      width: ResponsiveUtils.isMobile(context) ? double.infinity : null,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFEE5A24)],
        ),
        borderRadius:
            BorderRadius.circular(ResponsiveUtils.radius(context, 30)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B6B).withOpacity(0.4),
            blurRadius: ResponsiveUtils.width(context, 20),
            offset: Offset(0, ResponsiveUtils.height(context, 10)),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius:
              BorderRadius.circular(ResponsiveUtils.radius(context, 30)),
          onTap: () {}, // Add your contact action here
          child: Padding(
            padding: ResponsiveUtils.paddingSymmetric(context,
                horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: ResponsiveUtils.isMobile(context)
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.work_rounded,
                    color: Colors.white,
                    size: ResponsiveUtils.width(context, 20)),
                ResponsiveUtils.horizontalSpace(context, 8),
                Text(
                  'Hire Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveUtils.fontSize(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context) {
    return Container(
      width: ResponsiveUtils.isMobile(context) ? double.infinity : null,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius:
            BorderRadius.circular(ResponsiveUtils.radius(context, 30)),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(ResponsiveUtils.radius(context, 30)),
          onTap: () async {
            if (!await launchUrl(resumeUrl, mode: LaunchMode.externalApplication)) {
              throw Exception("Could not launch $resumeUrl");
            }
          },
          child: Padding(
            padding: ResponsiveUtils.paddingSymmetric(context,
                horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: ResponsiveUtils.isMobile(context)
                  ? MainAxisSize.max
                  : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.download_rounded,
                    color: Colors.white,
                    size: ResponsiveUtils.width(context, 20)),
                ResponsiveUtils.horizontalSpace(context, 8),
                Text(
                  'Resume',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveUtils.fontSize(context, 16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImage(BuildContext context) {
    final imageSize = ResponsiveUtils.isMobile(context)
        ? 200.0
        : ResponsiveUtils.isTablet(context)
        ? 250.0
        : 300.0;

    return Center(
      child: Container(
        width: ResponsiveUtils.width(context, imageSize),
        height: ResponsiveUtils.width(context, imageSize), // keep width = height
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.1),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: ResponsiveUtils.width(context, 20),
              offset: Offset(0, ResponsiveUtils.height(context, 15)),
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.all(4), // border effect
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFFFF6B6B), Color(0xFFEE5A24)],
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              "assets/profile_img.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }

}

class ParticlesPainter extends CustomPainter {
  final double animationValue;
  final List<Particle> particles = [];

  ParticlesPainter(this.animationValue) {
    // Generate particles
    for (int i = 0; i < 50; i++) {
      particles.add(Particle());
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.1)
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final x = particle.x * size.width +
          math.sin(animationValue * 2 * math.pi + particle.phase) * 20;
      final y = particle.y * size.height +
          math.cos(animationValue * 2 * math.pi + particle.phase) * 15;

      canvas.drawCircle(
        Offset(x, y),
        particle.size,
        paint..color = Colors.white.withOpacity(particle.opacity),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Particle {
  final double x = math.Random().nextDouble();
  final double y = math.Random().nextDouble();
  final double size = math.Random().nextDouble() * 3 + 1;
  final double opacity = math.Random().nextDouble() * 0.3 + 0.1;
  final double phase = math.Random().nextDouble() * 2 * math.pi;
}
