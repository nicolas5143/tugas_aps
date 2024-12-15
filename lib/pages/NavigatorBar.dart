import 'package:flutter/material.dart';
import 'package:tugas_aps/pages/HalamanUtama.dart';
import 'halaman_tugas/HalamanLihatTugas.dart';
import 'HalamanJadwal.dart';
import 'HalamanNotifikasi.dart';


class NavigatorBar extends StatefulWidget {
  const NavigatorBar({super.key});

  @override
  State<NavigatorBar> createState() => _NavigatorBarState();
}

class _NavigatorBarState extends State<NavigatorBar> {
  int _currentIndex = 3;
  List<Widget> nav = const [
    HalamanLihatTugas(),
    HalamanJadwal(),
    HalamanNotifikasi(),
    HalamanUtama()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        backgroundColor: const Color(0xFFF2F2F2),
        currentIndex: _currentIndex,
        onTap: (int newIndex) {
          setState(() {
            _currentIndex = newIndex;
          });
        },
        items: [
          BottomNavigationBarItem(
            label: 'Tugas',
            icon: Container(
              decoration: BoxDecoration(
                  color: (_currentIndex == 0) ? const Color(0xFF5DB075): const Color(0xFFDCDCDC),
                  borderRadius: BorderRadius.circular(50)),
              height: 50,
              width: 50,
              child: const Icon(Icons.task),
            ),
          ),
          BottomNavigationBarItem(
              label: 'Jadwal',
              icon: Container(
                decoration: BoxDecoration(
                    color: (_currentIndex == 1) ? const Color(0xFF5DB075): const Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(50)),
                height: 50,
                width: 50,
                child: const Icon(Icons.calendar_month),
              )),
          BottomNavigationBarItem(
              label: 'Notifikasi',
              icon: Container(
                decoration: BoxDecoration(
                    color: (_currentIndex == 2) ? const Color(0xFF5DB075): const Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(50)),
                height: 50,
                width: 50,
                child: const Icon(Icons.notifications),
              )),
          BottomNavigationBarItem(
              label: 'Utama',
              icon: Container(
                decoration: BoxDecoration(
                    color: (_currentIndex == 3) ? const Color(0xFF5DB075): const Color(0xFFDCDCDC),
                    borderRadius: BorderRadius.circular(50)),
                height: 50,
                width: 50,
                child: const Icon(Icons.account_circle_rounded),
              ))
        ],
      ),
      body: nav[_currentIndex]
    );
  }
}
