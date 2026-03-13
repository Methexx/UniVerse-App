import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universe_app/core/constants/app_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Primary Font is already applied globally via AppTheme
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF0FBFF), // BG Primary Color
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            // --- Top Section: Image ---
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                    'Assets/welcome1.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            
            // --- Bottom Section: White Card ---
            Container(
              width: 350,
              height: 320,
              padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF), // White Component
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: <Widget>[
                  const _PageIndicatorRow(),
                  const SizedBox(height: 24),
                  // Title
                  Text(
                    'Find various courses on\nOur platform',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF101820),
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Subtitle
                  Text(
                    'Courses that are different from the others that\nyou will find only with us',
                    textAlign: TextAlign.center,
                    style: textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFFA7BFC6), // Specific Text Color
                      height: 1.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const Spacer(),

                  // --- Login Button ---
                  // "Button color = 6ACFEF, Corner Radius = 10, Drop Shadow"
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.11),
                          blurRadius: 4,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () => context.go(AppRoutes.login),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6ACFEF),
                        foregroundColor: Colors.white,
                        elevation: 0, // We implemented custom shadow above
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class _PageIndicatorRow extends StatelessWidget {
  const _PageIndicatorRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _IndicatorBar(isActive: false),
        SizedBox(width: 8),
        _IndicatorBar(isActive: true),
        SizedBox(width: 8),
        _IndicatorBar(isActive: false),
      ],
    );
  }
}

class _IndicatorBar extends StatelessWidget {
  const _IndicatorBar({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF6ACFEF) : const Color(0xFFE3F7FD),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

