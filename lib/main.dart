import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const DigitalCardApp());
}

class DigitalCardApp extends StatefulWidget {
  const DigitalCardApp({super.key});

  @override
  State<DigitalCardApp> createState() => _DigitalCardAppState();
}

class _DigitalCardAppState extends State<DigitalCardApp> {

  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        scaffoldBackgroundColor: isDarkMode ? const Color(0xFF121212) : const Color(0xFFF9F9FB),
      ),
      home: BusinessCardScreen(isDarkMode: isDarkMode, onToggleTheme: toggleTheme),
    );
  }
}

class BusinessCardScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const BusinessCardScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  // Fonction pour ouvrir les liens hypertextes
  Future<void> _launchUrl(String urlString) async {
    final Uri uri = Uri.parse(urlString);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $urlString');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Couleurs adaptatives selon le mode
    final cardColor = isDarkMode ? const Color(0xFF1E1E24) : Colors.white;
    final textColor = isDarkMode ? Colors.white : const Color(0xFF1D1D1F);
    final subtitleColor = isDarkMode ? Colors.purple[300] : const Color(0xFF7C3AED);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Ligne du haut : Titre "DIGITAL CARD" et Bouton Dark Mode
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Colors.purple,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'DIGITAL CARD',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  // Bouton Dark Mode à la place de Premium
                  ElevatedButton.icon(
                    onPressed: onToggleTheme,
                    icon: Icon(
                      isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                      size: 16,
                      color: isDarkMode ? Colors.amber : Colors.purple,
                    ),
                    label: Text(
                      isDarkMode ? 'Light Mode' : 'Dark Mode',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.white : Colors.purple[800],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDarkMode ? const Color(0xFF2C2C35) : Colors.purple.withOpacity(0.1),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Photo de profil avec bordure gradient
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.pinkAccent, Colors.amber],
                  ),
                ),
                child: const CircleAvatar(
                  radius: 55,
                  backgroundImage: AssetImage('assets/images/monphoto.jpg'), // Remplace par ton image
                ),
              ),
              const SizedBox(height: 20),

              // Nom : Benaissa Roumeissa
              Text(
                'Benaissa Roumeissa',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'serif', // Style élégant similaire à l'image
                  color: textColor,
                ),
              ),
              const SizedBox(height: 8),

              // Titre académique et professionnel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Master's Data Science & AI Student, Mobile Developer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: subtitleColor,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              // Badge Localisation (Constantine, Algeria)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: isDarkMode ? const Color(0xFF252530) : Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.circle, size: 8, color: Colors.purple),
                    const SizedBox(width: 6),
                    Text(
                      'Constantine, Algeria',
                      style: TextStyle(
                        fontSize: 12,
                        color: isDarkMode ? Colors.grey[300] : Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Divider(thickness: 0.5),
              const SizedBox(height: 15),

              // Titre section CONNECT
              Text(
                'CONNECT',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),

              // 1. LinkedIn Link
              BuildContactCard(
                icon: Icons.work,
                title: 'LinkedIn',
                subtitle: '/benaissa-roumeissa',
                cardColor: cardColor,
                textColor: textColor,
                onTap: () => _launchUrl('https://www.linkedin.com/in/roumeissa-benaissa-4b9924351/'),
              ),

              // 2. GitHub Link
              BuildContactCard(
                icon: Icons.code,
                title: 'GitHub',
                subtitle: '@benaissa-roumeissa',
                cardColor: cardColor,
                textColor: textColor,
                onTap: () => _launchUrl('https://github.com/roumeissabenaissa-ai'),
              ),

              // 3. Email Link
              BuildContactCard(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'roumeissa.benaissa@univ-constantine2.dz',
                cardColor: cardColor,
                textColor: textColor,
                onTap: () => _launchUrl('mailto:roumeissa.benaissa@univ-constantine2.dz'),
              ),

              // 4. Phone Call Link
              BuildContactCard(
                icon: Icons.phone_outlined,
                title: 'Call',
                subtitle: '+213 655 11 39 53',
                cardColor: cardColor,
                textColor: textColor,
                onTap: () => _launchUrl('tel:+213 655113953'),
              ),

              const SizedBox(height: 30),
              Text(
                'Crafted as a premium digital badge',
                style: TextStyle(fontSize: 11, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget réutilisable pour les cartes de liens
class BuildContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color cardColor;
  final Color textColor;
  final VoidCallback onTap;

  const BuildContactCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.cardColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        elevation: 1,
        shadowColor: Colors.black12,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: Colors.purple, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}