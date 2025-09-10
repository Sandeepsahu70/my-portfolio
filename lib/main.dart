import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/widgets/floatingactionbutton.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/projects_section.dart';
import 'sections/experience_section.dart';
import 'sections/contact_section.dart';
import 'widgets/custom_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sandeep Teli Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage>
    with TickerProviderStateMixin {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  late ScrollController _scrollController;
  late AnimationController _navbarController;
  bool _isScrolled = false;
  int _currentSection = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _navbarController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _navbarController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_isScrolled) {
      setState(() => _isScrolled = true);
      _navbarController.forward();
    } else if (_scrollController.offset <= 100 && _isScrolled) {
      setState(() => _isScrolled = false);
      _navbarController.reverse();
    }

    // Update current section based on scroll position
    final scrollPosition = _scrollController.offset;
    final screenHeight = MediaQuery.of(context).size.height;

    int newSection = (scrollPosition / screenHeight).floor();
    if (newSection != _currentSection && newSection >= 0 && newSection < 5) {
      setState(() => _currentSection = newSection);
    }
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AnimatedBuilder(
          animation: _navbarController,
          builder: (context, child) => CustomNavbar(
            homeKey: homeKey,
            aboutKey: aboutKey,
            projectsKey: projectsKey,
            experienceKey: experienceKey,
            contactKey: contactKey,
            onSectionTap: scrollToSection,
            isScrolled: _isScrolled,
            currentSection: _currentSection,
            animation: _navbarController,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            HomeSection(key: homeKey),
            AboutSection(key: aboutKey),
            ProjectsSection(key: projectsKey),
            ExperienceSection(key: experienceKey),
            ContactSection(key: contactKey),
          ],
        ),
      ),
      floatingActionButton: FloatingActionMenu(
        scrollController: _scrollController,
        onScrollToTop: () => scrollToSection(homeKey),
      ),
    );
  }
}