import 'package:flutter/material.dart';
import 'package:quizmaster/about/about.dart';
import 'package:quizmaster/profile/profile.dart';
import 'package:quizmaster/topics/topics.dart';

class TopicsAboutProfileScreen extends StatefulWidget {
   const TopicsAboutProfileScreen({Key? key}) : super(key: key);

  @override
  State<TopicsAboutProfileScreen> createState() => _TopicsAboutProfileScreenState();
}

class _TopicsAboutProfileScreenState extends State<TopicsAboutProfileScreen> {
  var _selectedIndex = 0;
  var pageController = PageController();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: PageView(
         controller: pageController,
         children: const [
           TopicsScreen(),
           AboutScreen(),
           ProfileScreen()
         ],
         onPageChanged: (index) => setState(() => _selectedIndex = index),
       ),
       bottomNavigationBar: BottomNavigationBar(
         items: const [
           BottomNavigationBarItem(icon: Icon(Icons.school), label: 'Topics',),
           BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'About',),
           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile',),
         ],
         currentIndex: _selectedIndex,
         selectedItemColor: Colors.amber[800],
         onTap: _onItemTapped,
       ),
     );
   }

  void _onItemTapped(int value) {
    setState(() => _selectedIndex = value);
    pageController.animateToPage(value, duration: const Duration(milliseconds: 350), curve: Curves.ease);
  }
}
