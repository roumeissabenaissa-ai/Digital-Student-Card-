import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final VoidCallback onMenuTap;

  const Navbar({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + nom
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFF3D1F3D),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                'Roumeissa.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          // Boutons dark mode + menu
          Row(
            children: [
              _CircleButton(
                icon: isDarkMode ? Icons.light_mode : Icons.dark_mode,
                onTap: onThemeToggle,
              ),
              const SizedBox(width: 10),
              _CircleButton(
                icon: Icons.menu,
                onTap: onMenuTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Icon(icon, size: 18),
      ),
    );
  }
}