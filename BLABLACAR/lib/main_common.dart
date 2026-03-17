import 'package:blabla/ui/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nested/nested.dart';
import 'ui/theme/theme.dart';

///
/// Launch the application with the given list of providers
///
void mainCommon(List<SingleChildWidget> providers) {
  runApp(
    MultiProvider(
      providers: providers,
      child: MaterialApp(debugShowCheckedModeBanner: false, home: BlaBlaApp()),
    ),
  );
}
class BlaBlaApp extends StatelessWidget {
  const BlaBlaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: blaTheme,
      home: Scaffold(body: HomeScreen()),
    );
  }
}











// class BlaBlaApp extends StatefulWidget {
//   const BlaBlaApp({super.key});

//   @override
//   State<BlaBlaApp> createState() => _BlaBlaAppState();
// }

// class _BlaBlaAppState extends State<BlaBlaApp> {
//   // int _currentIndex = 1;

//   // final List<Widget> _pages = [
//   //   HomeScreen(),
//   //   RidesSelectionScreen()
//   // ];

//   @override
//   Widget build(BuildContext context) {
//     // 1- Get the globbal settings state
//     AppSettingsState settingsState = context.read<AppSettingsState>();

//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: appTheme,
//       home: Scaffold(
//         body: _pages[_currentIndex],

//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           selectedItemColor: settingsState.theme.color,
//           items: [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.library_music),
//               label: 'Library',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.heart_broken),
//               label: 'Favorites',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }