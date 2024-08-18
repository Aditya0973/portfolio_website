import 'package:flutter/material.dart';
import '../widgets/glass_container.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'About Me',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 30),
            GlassContainer(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hi, I\'m Aditya Kumar',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'I\'m a passionate Flutter developer with a deep commitment to creating intuitive and visually appealing user experiences. '
                      'With a solid background in computer science and a strong foundation in mobile app development, I specialize in building high-quality, '
                      'functional apps that not only meet user needs but also provide a delightful experience. My love for design and attention to detail drive '
                      'me to craft beautiful, efficient solutions that turn innovative ideas into reality. I continuously strive to improve my skills and stay updated '
                      'with the latest industry trends, always aiming to deliver exceptional results through code.',
                      style: TextStyle(fontSize: 16, color: Colors.white70),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'Skills',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        _buildSkillChip('Flutter'),
                        _buildSkillChip('Dart'),
                        _buildSkillChip('Firebase'),
                        _buildSkillChip('UI/UX Design'),
                        _buildSkillChip('Git'),
                        _buildSkillChip('RESTful APIs'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: Colors.tealAccent.withOpacity(0.2),
      labelStyle: const TextStyle(color: Colors.white),
    );
  }
}