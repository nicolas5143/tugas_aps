import 'package:flutter/material.dart';
import 'package:tugas_aps/pages/HalamanUtama.dart';
import 'package:tugas_aps/pages/NavigatorBar.dart';
import 'package:tugas_aps/pages/SplashScreen.dart';
import 'package:tugas_aps/pages/HalamanLogin.dart';
import 'package:tugas_aps/pages/halaman_tugas/HalamanBuatCatatanTugas.dart';
import 'package:tugas_aps/pages/halaman_tugas/HalamanTambahTugas.dart';
import 'package:tugas_aps/pages/halaman_tugas/HalamanLihatTugas.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.green,
          scaffoldBackgroundColor: Colors.white
        ),
        home: const HalamanLogin(),
        routes: {
          '/splash_screen': (context) => const SplashScreen(),
          '/navigator': (context) => const NavigatorBar(),
          '/halaman_login': (context) => const HalamanLogin(),
          '/halaman_utama': (context) => const HalamanUtama(),
          '/halaman_lihat_tugas': (context) => const HalamanLihatTugas(),
          '/halaman_tambah_tugas': (context) => const HalamanTambahTugas(),
          '/halaman_buat_catatan_tugas': (context) => const HalamanBuatCatatanTugas(),
        });
  }
}

