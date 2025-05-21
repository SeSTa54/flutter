import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:ui';

const String kAppLogo = 'lib/assets/Lemon -9.jpg';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  String? surname;
  String? email;
  bool isLoading = false;
  int _selectedTab = 0;
  int _selectedGroupTab = 1; // 0: Tümü, 1: Sınıfım, 2: Ödevlerim

  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    name = user?.displayName ?? '';
    surname = '';
    email = user?.email ?? '';
    isLoading = false;
  }

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedTab = index;
    });
    switch (index) {
      case 0:
        // Home Page, stay here
        break;
      case 1:
        Navigator.pushNamed(context, '/courses');
        break;
      case 2:
        Navigator.pushNamed(context, '/ai_chat');
        break;
      case 3:
        Navigator.pushNamed(context, '/homework');
        break;
      case 4:
        Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  void _onProfileTap() {
    Navigator.pushNamed(context, '/profile');
  }

  void onNewHomeworkTap() {
    Navigator.pushNamed(context, '/homework');
  }

  Widget _buildGroupTab(String label, int index) {
    final isSelected = _selectedGroupTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGroupTab = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF4B2676) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFF4B2676),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildGroupCard({
    required int week,
    required int userCount,
    required String time,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'lib/assets/Lemon -9.jpg',
                height: 40,
                width: 40,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$week. Hafta',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.circle, color: Colors.green, size: 12),
                      const SizedBox(width: 4),
                      Text(userCount.toString()),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Color(0xFF8A6FC7),
                      ),
                      const SizedBox(width: 4),
                      Text(time),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Color(0xFF4B2676)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 36,
                      color: Color(0xFF4B2676),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    name != null ? '$name $surname' : '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    email ?? '',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home Page'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Courses'),
              onTap: () => Navigator.pushNamed(context, '/courses'),
            ),
            ListTile(
              leading: const Icon(Icons.assignment),
              title: const Text('Homework'),
              onTap: () => Navigator.pushNamed(context, '/homework'),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profilim'),
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          // Blur arka plan limon resmi
          SizedBox.expand(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
              child: Image.asset('lib/assets/Lemon -9.jpg', fit: BoxFit.cover),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Builder(
                          builder:
                              (context) => GestureDetector(
                                onTap: () => Scaffold.of(context).openDrawer(),
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF3F0FA),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            color: const Color(0xFF4B2676),
                                          ),
                                          const SizedBox(width: 4),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            color: const Color(0xFF4B2676),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          Container(
                                            width: 8,
                                            height: 8,
                                            color: const Color(0xFF4B2676),
                                          ),
                                          const SizedBox(width: 4),
                                          Container(
                                            width: 8,
                                            height: 8,
                                            color: const Color(0xFF4B2676),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              name != null ? '$name $surname' : '',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'What do you want to learn Today?',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF8A6FC7),
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: _onProfileTap,
                          child: const CircleAvatar(
                            backgroundColor: Color(0xFF4B2676),
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF4B2676), width: 1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.search, color: Color(0xFF8A6FC7)),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                hintText: 'Search..',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Mor kutunun içindeki limon resmi ve chat butonu
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/ai_chat');
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: const Color(0xFF7B3FE4).withOpacity(0.95),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Yapay Zeka ile Sohbet!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 6),
                                  Text(
                                    'Sorularını ChatGPT ile sorabilirsin',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  SizedBox(
                                    width: 120,
                                    child: ElevatedButton(
                                      onPressed: null, // Sadece görsel amaçlı
                                      style: ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                          Color(0xFF4B2676),
                                        ),
                                        foregroundColor: WidgetStatePropertyAll(
                                          Colors.white,
                                        ),
                                        padding: WidgetStatePropertyAll(
                                          EdgeInsets.symmetric(vertical: 8),
                                        ),
                                      ),
                                      child: Text('ChatGPT ile Aç'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'lib/assets/Lemon -9.jpg',
                                height: 60,
                                width: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Bartalk Groups',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildGroupTab('Tümü', 0),
                        _buildGroupTab('Sınıfım', 1),
                        _buildGroupTab('Ödevlerim', 2),
                        _buildGroupTab('deney', 3),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Grup listesi örnek
                    Column(
                      children: List.generate(
                        20,
                        (i) => _buildGroupCard(
                          week: i + 1,
                          userCount: i == 0 ? 5 : 4,
                          time: '20:00',
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/groupDetail',
                              arguments: {'week': i + 1},
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: _onBottomNavTap,
        selectedItemColor: const Color(0xFF4B2676),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Page'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble),
            label: 'ChatGPT',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Homework',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profilim'),
        ],
      ),
    );
  }
}
