// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  const BottomNavBar({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (int tappedIndex) {
          navigationShell.goBranch(tappedIndex);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_outlined),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'Episodes',
          ),
        ],
      ),
    );
  }
}
