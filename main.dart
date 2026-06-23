import 'package:flutter/material.dart';
import 'dart:ui';

void main() {
  runApp(const PrivacyOSApp());
}

class PrivacyOSApp extends StatelessWidget {
  const PrivacyOSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PrivacyOS',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0D0F12),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FF66), // Neon Green
          secondary: Color(0xFF00E5FF), // Cyber Blue
          surface: Color(0xFF1A1F26),
          background: const Color(0xFF0D0F12),
        ),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
          bodyLarge: TextStyle(color: Colors.white70),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// REUSABLE WIDGETS
// ==========================================

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GlassCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.05),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// ==========================================
// SPLASH SCREEN
// ==========================================

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF14281E), Color(0xFF0D0F12)],
            radius: 1.2,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shield,
                  size: 100,
                  color: Color(0xFF00FF66),
                ),
                const SizedBox(height: 16),
                Text(
                  'PrivacyOS',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 36,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your Privacy. Your Control.',
                  style: TextStyle(color: Colors.white54, fontSize: 16),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF66),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MainNavigationController()),
                    );
                  },
                  child: const Text('GET STARTED', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// NAVIGATION CONTROLLER
// ==========================================

class MainNavigationController extends StatefulWidget {
  const MainNavigationController({super.key});

  @override
  State<MainNavigationController> createState() => _MainNavigationControllerState();
}

class _MainNavigationControllerState extends State<MainNavigationController> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const SecureStorageScreen(),
    const AppPermissionsScreen(),
    const ThreatScannerScreen(),
    const PrivacyReportsScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex > 4 ? 4 : _selectedIndex, // Keeps settings visually grouped or accessible
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF14181F),
        selectedItemColor: const Color(0xFF00FF66),
        unselectedItemColor: Colors.white38,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.lock), label: 'Storage'),
          BottomNavigationBarItem(icon: Icon(Icons.gpp_good), label: 'Perms'),
          BottomNavigationBarItem(icon: Icon(Icons.radar), label: 'Scanner'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Reports'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF1A1F26),
        child: Icon(Icons.settings, color: _selectedIndex == 5 ? const Color(0xFF00FF66) : Colors.white),
        onPressed: () {
          setState(() {
            _selectedIndex = 5;
          });
        },
      ),
    );
  }
}

// ==========================================
// SCREEN 1: HOME DASHBOARD
// ==========================================

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PrivacyOS Dashboard', style: TextStyle(fontFamily: 'monospace')),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.circle, color: Color(0xFF00FF66), size: 14),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GlassCard(
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF14281E),
                    child: Icon(Icons.person, color: Color(0xFF00FF66)),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome Back, Agent', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('System Status: Protected', style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GlassCard(
                    child: Column(
                      children: [
                        const Text('Privacy Score', style: TextStyle(color: Colors.white54)),
                        const SizedBox(height: 8),
                        Text('85%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: const Color(0xFF00FF66))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GlassCard(
                    child: Column(
                      children: [
                        const Text('Security Status', style: TextStyle(color: Colors.white54)),
                        const SizedBox(height: 8),
                        const Icon(Icons.verified_user, size: 38, color: Color(0xFF00E5FF)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text('Core Framework modules', style: TextStyle(fontSize: 16, color: Colors.white38, fontFamily: 'monospace')),
            const SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildFeatureTile(Icons.storage, 'Secure Storage', 'Encrypted vault'),
                _buildFeatureTile(Icons.vpn_lock, 'VPN', 'Tunnel Active'),
                _buildFeatureTile(Icons.password, 'Password Vault', 'Locked'),
                _buildFeatureTile(Icons.security, 'App Permissions', '4 Alerted'),
                _buildFeatureTile(Icons.bug_report, 'Threat Scanner', 'Clean'),
                _buildFeatureTile(Icons.assessment, 'Privacy Reports', 'Weekly available'),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureTile(IconData icon, String title, String subtitle) {
    return GlassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF00FF66), size: 32),
          const SizedBox(height: 12),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(subtitle, style: const TextStyle(color: Colors.white54, fontSize: 12)),
        ],
      ),
    );
  }
}

// ==========================================
// SCREEN 2: SECURE STORAGE
// ==========================================

class SecureStorageScreen extends StatelessWidget {
  const SecureStorageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> dummyFiles = [
      {'name': 'credentials.pdf.enc', 'size': '2.4 MB'},
      {'name': 'tax_return_2026.aes', 'size': '14.1 MB'},
      {'name': 'private_key.pem', 'size': '4 KB'},
      {'name': 'seed_phrase.txt.lock', 'size': '512 B'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Secure Storage'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search encrypted vault...',
                prefixIcon: const Icon(Icons.search, color: Colors.white54),
                filled: true,
                fillColor: Colors.white.withOpacity(0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF66),
                foregroundColor: Colors.black,
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {},
              icon: const Icon(Icons.upload_file),
              label: const Text('UPLOAD ENCRYPTED FILE'),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView.builder(
                itemCount: dummyFiles.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color(0xFF161A22),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.insert_drive_file, color: Color(0xFF00E5FF)),
                      title: Text(dummyFiles[index]['name']!, style: const TextStyle(fontFamily: 'monospace')),
                      subtitle: Text(dummyFiles[index]['size']!),
                      trailing: const Icon(Icons.more_vert, color: Colors.white54),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 3: APP PERMISSIONS
// ==========================================

class AppPermissionsScreen extends StatefulWidget {
  const AppPermissionsScreen({super.key});

  @override
  State<AppPermissionsScreen> createState() => _AppPermissionsScreenState();
}

class _AppPermissionsScreenState extends State<AppPermissionsScreen> {
  final List<Map<String, dynamic>> apps = [
    {'name': 'SocialConnect', 'cam': true, 'loc': false, 'mic': true, 'con': false},
    {'name': 'CryptoWallet X', 'cam': true, 'loc': false, 'mic': false, 'con': false},
    {'name': 'MapNav Pro', 'cam': false, 'loc': true, 'mic': false, 'con': true},
    {'name': 'ChatSphere', 'cam': true, 'loc': true, 'mic': true, 'con': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Permissions'), backgroundColor: Colors.transparent),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: apps.length,
        itemBuilder: (context, index) {
          return GlassCard(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ExpansionTile(
              title: Text(apps[index]['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: const Text('Tap to view subsystem access rules', style: TextStyle(fontSize: 12, color: Colors.white38)),
              children: [
                _buildPermissionSwitch(index, 'Camera', 'cam'),
                _buildPermissionSwitch(index, 'Location', 'loc'),
                _buildPermissionSwitch(index, 'Microphone', 'mic'),
                _buildPermissionSwitch(index, 'Contacts', 'con'),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPermissionSwitch(int appIndex, String label, String key) {
    return SwitchListTile(
      title: Text(label, style: const TextStyle(fontSize: 14)),
      activeColor: const Color(0xFF00FF66),
      value: apps[appIndex][key],
      onChanged: (bool value) {
        setState(() {
          apps[appIndex][key] = value;
        });
      },
    );
  }
}

// ==========================================
// SCREEN 4: THREAT SCANNER
// ==========================================

class ThreatScannerScreen extends StatefulWidget {
  const ThreatScannerScreen({super.key});

  @override
  State<ThreatScannerScreen> createState() => _ThreatScannerScreenState();
}

class _ThreatScannerScreenState extends State<ThreatScannerScreen> {
  bool _isScanning = false;
  double _progress = 0.0;
  String _statusText = 'System Ready for Diagnostics';

  void _startScan() async {
    setState(() {
      _isScanning = true;
      _progress = 0.0;
      _statusText = 'Analyzing Core Kernel...';
    });

    for (int i = 1; i <= 10; i++) {
      await Future.delayed(const Duration(milliseconds: 300));
      setState(() {
        _progress = i * 0.1;
        if (i == 4) _statusText = 'Checking Network Integrity...';
        if (i == 8) _statusText = 'Scanning Sandbox Permissions...';
      });
    }

    setState(() {
      _isScanning = false;
      _statusText = 'Scan Complete. 0 Malware Threats Detected.';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Threat Scanner'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_statusText, style: const TextStyle(fontFamily: 'monospace', fontSize: 16)),
            const SizedBox(height: 24),
            if (_isScanning) ...[
              LinearProgressIndicator(value: _progress, color: const Color(0xFF00FF66), backgroundColor: Colors.white12),
              const SizedBox(height: 8),
              Text('${(_progress * 100).toInt()}%', style: const TextStyle(color: Color(0xFF00FF66))),
            ] else ...[
              IconButton(
                iconSize: 80,
                icon: const Icon(Icons.radar, color: Color(0xFF00FF66)),
                onPressed: _startScan,
              ),
              const Text('Tap radar icon to initiate deep scan', style: TextStyle(color: Colors.white38)),
            ],
            const SizedBox(height: 40),
            const Row(
              children: [
                Expanded(
                  child: Card(
                    color: Color(0xFF1A1F26),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Critical Alerts', style: TextStyle(color: Colors.redAccent)),
                          Text('0', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    color: Color(0xFF1A1F26),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('Network Risk', style: TextStyle(color: Color(0xFF00E5FF))),
                          Text('Low', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// SCREEN 5: PRIVACY REPORTS
// ==========================================

class PrivacyReportsScreen extends StatelessWidget {
  const PrivacyReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Metrics'), backgroundColor: Colors.transparent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Weekly Data Exploit Mitigation', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            // Custom Mock Chart using Basic Layout Containers
            GlassCard(
              child: SizedBox(
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildBar('Mon', 40),
                    _buildBar('Tue', 70),
                    _buildBar('Wed', 90),
                    _buildBar('Thu', 50),
                    _buildBar('Fri', 110),
                    _buildBar('Sat', 30),
                    _buildBar('Sun', 60),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Recent Intercepts', style: TextStyle(color: Colors.white38, fontFamily: 'monospace')),
            const SizedBox(height: 12),
            Expanded(
              child: ListView(
                children: const [
                  ListTile(
                    leading: Icon(Icons.block, color: Colors.orangeAccent),
                    title: Text('Cross-site Tracker Blocked'),
                    subtitle: Text('3 minutes ago - SocialConnect app'),
                  ),
                  ListTile(
                    leading: Icon(Icons.g_mobiledata, color: Color(0xFF00FF66)),
                    title: Text('Location Spoofing Successful'),
                    subtitle: Text('1 hour ago - MapNav Pro data request obfuscated'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBar(String label, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 20,
          height: height,
          decoration: BoxDecoration(
            color: const Color(0xFF00FF66),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 10, color: Colors.white54)),
      ],
    );
  }
}

// ==========================================
// SCREEN 6: SETTINGS
// ==========================================

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('System Preferences'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Dark Cyber Mode'),
            subtitle: const Text('Force high-contrast black backdrops'),
            value: true,
            activeColor: const Color(0xFF00FF66),
            onChanged: (val) {},
          ),
          ListTile(
            title: const Text('System Language'),
            subtitle: const Text('English (US) - English (UK) - Terminal Bash'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {}, //  Fixed!
          ),
          const Divider(color: Colors.white12, height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('ABOUT PRIVACYOS', style: TextStyle(fontSize: 12, color: Color(0xFF00E5FF), fontFamily: 'monospace')),
                SizedBox(height: 12),
                Text('Version: 1.0.0-Beta-MVP'),
                SizedBox(height: 4),
                Text('Encryption Engine: AES-GCM-256 bits'),
                SizedBox(height: 4),
                Text('Built for open-source structural sandbox privacy prototyping.', style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
