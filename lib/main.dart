import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CampusNavigatorApp());
}

class CampusNavigatorApp extends StatelessWidget {
  const CampusNavigatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Campus Navigator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/detail': (context) => const DetailPage(),
        '/form': (context) => const RegistrationPage(),
        '/about': (context) => const AboutPage(),
      },
    );
  }
}

// ==================================================
// HOME PAGE
// ==================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tapCount = 0;
  bool notificationOn = true;
  String selectedRole = 'Mahasiswa';

  // Data pribadi untuk Tugas Mini 2
  final String nama = 'Naswa Vifda Zalianti';
  final String nim = '240605110047';

Future<void> openWebsite() async {
  final uri = Uri.parse('https://uin-malang.ac.id/id');

    final success = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Website tidak dapat dibuka.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Navigator'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Navigasi • Intent • Event',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Praktik interaksi antarmuka dengan Flutter.',
          ),

          const SizedBox(height: 24),

          // =========================
          // 1. PENANGANAN EVENT
          // =========================

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. Penanganan Event',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Tombol ditekan: $tapCount kali',
                  ),

                  const SizedBox(height: 8),

                  FilledButton(
                    onPressed: () {
                      setState(() {
                        tapCount++;
                      });
                    },
                    child: const Text('Tekan Saya'),
                  ),

                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Notifikasi'),
                    value: notificationOn,
                    onChanged: (value) {
                      setState(() {
                        notificationOn = value;
                      });
                    },
                  ),

                  DropdownButton<String>(
                    value: selectedRole,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(
                        value: 'Mahasiswa',
                        child: Text('Mahasiswa'),
                      ),
                      DropdownMenuItem(
                        value: 'Asisten',
                        child: Text('Asisten'),
                      ),
                      DropdownMenuItem(
                        value: 'Dosen',
                        child: Text('Dosen'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedRole = value;
                        });
                      }
                    },
                  ),

                  Text(
                    'Peran aktif: $selectedRole',
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // =========================
          // 2. NAVIGASI & INTENT
          // =========================

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    '2. Navigasi & Intent',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // =========================
                  // PROFILE + RESULT
                  // =========================

                  OutlinedButton(
                    onPressed: () async {
                      final result = await Navigator.push<String>(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ProfilePage(),
                        ),
                      );

                      if (!mounted) return;

                      if (result != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                    child: const Text('Buka Profile'),
                  ),

                  // =========================
                  // ABOUT
                  // =========================

                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/about',
                      );
                    },
                    child: const Text('Tentang Aplikasi'),
                  ),

                  // =========================
                  // DETAIL
                  // =========================

                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/detail',
                        arguments: {
                          'nama': nama,
                          'nim': nim,
                          'role': selectedRole,
                        },
                      );
                    },
                    child: const Text(
                      'Kirim Data ke Detail',
                    ),
                  ),

                  // =========================
                  // FORM
                  // =========================

                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/form',
                      );
                    },
                    child: const Text('Buka Form'),
                  ),

                  // =========================
                  // WEBSITE
                  // =========================

                  FilledButton.tonal(
                    onPressed: openWebsite,
                    child: const Text(
                      'Buka website kampus',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // =========================
          // 3. DOUBLE TAP
          // =========================

          GestureDetector(
            onDoubleTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Double tap terdeteksi'),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Double tap area ini',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==================================================
// PROFILE PAGE
// ==================================================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 36,
              child: Icon(
                Icons.person,
                size: 40,
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Mahasiswa Informatika',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Mengirim result ke Home
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  'Profile selesai dibuka',
                );
              },
              child: const Text('Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}

// ==================================================
// DETAIL PAGE
// ==================================================

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!
        .settings
        .arguments as Map<String, dynamic>?;

    final nama = args?['nama'] ?? '-';
    final nim = args?['nim'] ?? '-';
    final role = args?['role'] ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            leading: const Icon(
              Icons.badge,
            ),
            title: Text(
              nama,
            ),
            subtitle: Text(
              'NIM: $nim\nPeran: $role',
            ),
          ),
        ),
      ),
    );
  }
}

// ==================================================
// REGISTRATION PAGE
// ==================================================

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() =>
      _RegistrationPageState();
}

class _RegistrationPageState
    extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();

  String liveText = '';

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void submitForm() {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Data diterima',
          ),
          content: Text(
            'Selamat datang, ${nameController.text}!',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama mahasiswa',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    liveText = value;
                  });
                },
                validator: (value) {
                  if (value == null ||
                      value.trim().length < 3) {
                    return 'Nama minimal 3 karakter.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 12),

              Text(
                'Preview input: $liveText',
              ),

              const SizedBox(height: 16),

              FilledButton(
                onPressed: submitForm,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================================================
// ABOUT PAGE
// ==================================================

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.school,
                size: 64,
              ),

              const SizedBox(height: 16),

              const Text(
                'Campus Navigator',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Aplikasi sederhana untuk mempraktikkan '
                'navigasi dan interaksi antarmuka menggunakan Flutter.',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}