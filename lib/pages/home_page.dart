import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/navbar.dart';
import '../widgets/footer.dart';
import '../widgets/glass_container.dart';
import '../widgets/fluid_background_animation.dart'; // Import the new background animation
import 'projects_page.dart';
import 'contact_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _contentController;
  late Animation<double> _contentAnimation;

  @override
  void initState() {
    super.initState();
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _contentAnimation = CurvedAnimation(parent: _contentController, curve: Curves.easeOutCubic);

    _contentController.forward();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          children: [
            FluidBackgroundAnimation( // Use FluidBackgroundAnimation here
              color1: Color.fromARGB(255, 9, 114, 149),
              color2: Color(0xFF50E3C2),
            ),
            Column(
              children: [
                Navbar(
                  currentIndex: _currentIndex,
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                      _contentController.reset();
                      _contentController.forward();
                    });
                  },
                ),
                Expanded(
                  child: AnimatedBuilder(
                    animation: _contentAnimation,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _contentAnimation.value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - _contentAnimation.value)),
                          child: _buildPage(),
                        ),
                      );
                    },
                  ),
                ),
                Footer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomePage();
      case 1:
        return ProjectsPage();
      case 2:
        return ContactPage();
      default:
        return _buildHomePage();
    }
  }

  Widget _buildHomePage() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: GlassContainer(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/profile_picture.jpg'),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Aditya Kumar',
                          style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Flutter Developer | UI/UX Enthusiast',
                          style: TextStyle(fontSize: 24, color: Colors.white70),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            _buildSocialIcon(FontAwesomeIcons.github, 'https://github.com/Aditya0973'),
                            SizedBox(width: 10),
                            _buildSocialIcon(FontAwesomeIcons.linkedin, 'https://www.linkedin.com/in/adityakumar0973'),
                            SizedBox(width: 10),
                            _buildSocialIcon(FontAwesomeIcons.twitter, 'https://x.com/AdityaKumar4727'),
                          ],
                        ),
                        SizedBox(height: 30),
                        ElevatedButton.icon(
                          onPressed: _downloadCV,
                          icon: Icon(Icons.download),
                          label: Text('Download CV'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.tealAccent,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                            textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: GlassContainer(
                  child: Padding(
                    padding: EdgeInsets.all(40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'About Me',
                          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        const Text(
                          'I\'m a passionate Flutter developer with a deep commitment to creating intuitive and visually appealing user experiences. '
                          'With a solid background in computer science and a strong foundation in mobile app development, I specialize in building high-quality, '
                          'functional apps that not only meet user needs but also provide a delightful experience. My love for design and attention to detail drive '
                          'me to craft beautiful, efficient solutions that turn innovative ideas into reality. I continuously strive to improve my skills and stay updated '
                          'with the latest industry trends, always aiming to deliver exceptional results through code.',
                          style: TextStyle(fontSize: 16, color: Colors.white70),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Skills',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        SizedBox(height: 10),
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
              ),
            ],
          ),
          SizedBox(height: 40),
          GlassContainer(
            child: Padding(
              padding: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Featured Project',
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  _buildFeaturedProject(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Chip(
      label: Text(skill),
      backgroundColor: Colors.tealAccent.withOpacity(0.2),
      labelStyle: TextStyle(color: Colors.white),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url) {
    return IconButton(
      icon: FaIcon(icon, color: Colors.white),
      onPressed: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          print('Could not launch $url');
        }
      },
    );
  }

  Widget _buildFeaturedProject() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              'assets/featured_project.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project Name',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'A brief description of your featured project. Highlight key features and technologies used.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to project details
                },
                child: Text('View Project'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.tealAccent,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _downloadCV() async {
    final url = Uri.parse('https://drive.google.com/file/d/1hXyr6lLmGCcE1ZtA-dfzq-kIJkFB_cWp/view?usp=sharing'); // Update with the correct direct download URL

    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication); // Opens the URL in the browser
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
