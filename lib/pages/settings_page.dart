import 'package:brivlo/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserSettings();
  }

  Future<void> _loadUserSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _nicknameController.text = prefs.getString('nickname') ?? '';
    _cityController.text = prefs.getString('city') ?? '';
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nickname', _nicknameController.text.trim());
    await prefs.setString('city', _cityController.text.trim());

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Settings saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
              ? Colors.black
              : Colors.blue,
          title: const Text(
            "Settings",
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter your nickname:"),
            const SizedBox(height: 8),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                hintText: "e.g. Champ, Captain, Buddy",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("Enter your city name:"),
            const SizedBox(height: 8),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                hintText: "e.g. Tokyo, Paris, New York",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                backgroundColor: Provider.of<ThemeProvider>(context).isDarkMode
                    ? Colors.black
                    : Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("Save Settings",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  )),
            ),
            Expanded(
              child: Container(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Light/Dark Mode',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context).isDarkMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:brivlo/theme/theme_provider.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SettingsPage extends StatefulWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   State<SettingsPage> createState() => _SettingsPageState();
// }

// class _SettingsPageState extends State<SettingsPage> {
//   final TextEditingController _nicknameController = TextEditingController();
//   final TextEditingController _cityController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _loadUserSettings();
//   }

//   Future<void> _loadUserSettings() async {
//     final prefs = await SharedPreferences.getInstance();
//     _nicknameController.text = prefs.getString('nickname') ?? '';
//     _cityController.text = prefs.getString('city') ?? '';
//   }

//   Future<void> _saveSettings() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('nickname', _nicknameController.text.trim());
//     await prefs.setString('city', _cityController.text.trim());

//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('Settings saved!')),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Settings")),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text("Enter your nickname:"),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _nicknameController,
//               decoration: InputDecoration(
//                 hintText: "e.g. Champ, Captain, Buddy",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text("Enter your city name:"),
//             const SizedBox(height: 8),
//             TextField(
//               controller: _cityController,
//               decoration: InputDecoration(
//                 hintText: "e.g. Tokyo, Paris, New York",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _saveSettings,
//               child: const Text("Save Settings"),
//             ),
//             const SizedBox(height: 30),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Light/Dark Mode',
//                   style: TextStyle(
//                     fontSize: 20,
//                   ),
//                 ),
//                 CupertinoSwitch(
//                   value: Provider.of<ThemeProvider>(context).isDarkMode,
//                   onChanged: (value) =>
//                       Provider.of<ThemeProvider>(context, listen: false)
//                           .toggleTheme(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
