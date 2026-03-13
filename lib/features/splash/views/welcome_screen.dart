import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:universe_app/core/constants/app_routes.dart';
import 'package:universe_app/shared/widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFEFF4F7),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0xFFDDE8EE), Color(0xFFEFF4F7)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                      top: 64,
                      child: Container(
                        width: 190,
                        height: 190,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 92,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          size: 100,
                          color: Color(0xFF37AED8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 22),
              decoration: BoxDecoration(
                color: const Color(0xFFF3F5F7),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const _PageIndicatorRow(),
                  const SizedBox(height: 18),
                  Text(
                    'Find various courses on\nOur platform',
                    textAlign: TextAlign.center,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF101820),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Courses that are different from the others that you\nwill find only with us',
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF9FB2BE),
                      height: 1.45,
                    ),
                  ),
                  const SizedBox(height: 22),
                  CustomButton(
                    label: 'Login',
                    onPressed: () => context.go(AppRoutes.login),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 6),
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
        SizedBox(width: 10),
        _IndicatorBar(isActive: true),
        SizedBox(width: 10),
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
      width: 74,
      height: 4,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF5CC0E4) : const Color(0xFFD4E6EE),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
