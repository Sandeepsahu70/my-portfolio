import 'package:flutter/material.dart';
import 'dart:math' as math;

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
    final isDesktop = size.width > 768;

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
              padding: EdgeInsets.symmetric(
                horizontal: isDesktop ? 80 : 20,
                vertical: 40,
              ),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: isDesktop
                          ? _buildDesktopLayout(size)
                          : _buildMobileLayout(size),
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

  Widget _buildDesktopLayout(Size size) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildGreeting(),
              const SizedBox(height: 20),
              _buildName(),
              const SizedBox(height: 20),
              _buildTitle(),
              const SizedBox(height: 30),
              _buildDescription(),
              const SizedBox(height: 40),
              _buildActionButtons(),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: _buildProfileImage(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfileImage(),
        const SizedBox(height: 30),
        _buildGreeting(),
        const SizedBox(height: 15),
        _buildName(),
        const SizedBox(height: 15),
        _buildTitle(),
        const SizedBox(height: 25),
        _buildDescription(),
        const SizedBox(height: 30),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildGreeting() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: const Text(
        '👋 Hello, I\'m',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildName() {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Colors.white, Color(0xFFE0E7FF)],
      ).createShader(bounds),
      child: const Text(
        'Sandeep Teli',
        style: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.1,
          letterSpacing: -1,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Flutter Developer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF10B981),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            '1+ Years Experience',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      'Passionate about creating beautiful, performant mobile applications with Flutter. I love turning complex problems into simple, elegant solutions.',
      style: TextStyle(
        color: Colors.white.withOpacity(0.9),
        fontSize: 18,
        height: 1.6,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        _buildPrimaryButton(),
        const SizedBox(width: 16),
        _buildSecondaryButton(),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B6B), Color(0xFFEE5A24)],
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF6B6B).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {}, // Add your contact action here
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.work_rounded, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Hire Me',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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

  Widget _buildSecondaryButton() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () {}, // Add your portfolio download action here
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.download_rounded, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text(
                  'Resume',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        width: 300,
        height: 300,
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
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
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
              ),
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