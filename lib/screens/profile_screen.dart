import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profilim'),
        backgroundColor: Color(0xFF4B2676),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 48,
                backgroundColor: Color(0xFF4B2676),
                child: Icon(Icons.person, color: Colors.white, size: 48),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Ad Soyad',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(user?.displayName ?? '-'),
            const SizedBox(height: 16),
            Text(
              'E-posta',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(user?.email ?? '-'),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
              icon: Icon(Icons.logout),
              label: Text('Çıkış Yap'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4B2676),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 32,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF4B2676)),
              title: Text('Ayarlar'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.info, color: Color(0xFF4B2676)),
              title: Text('Hakkında'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.help, color: Color(0xFF4B2676)),
              title: Text('Yardım'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
