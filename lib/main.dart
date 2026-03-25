import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Premium Mobile Banking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color(0xFF1E3A8A),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Inter',
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  bool _isBalanceVisible = true;

  // Layanan Utama (diperbanyak menjadi 8)
  final List<Map<String, dynamic>> _menuItems = [
    {'icon': Icons.swap_horiz_rounded, 'title': 'Transfer', 'color': const Color(0xFF3B82F6)},
    {'icon': Icons.account_balance_wallet_rounded, 'title': 'E-Wallet', 'color': const Color(0xFF10B981)},
    {'icon': Icons.receipt_long_rounded, 'title': 'Tagihan', 'color': const Color(0xFFF59E0B)},
    {'icon': Icons.phone_android_rounded, 'title': 'Pulsa/Data', 'color': const Color(0xFF06B6D4)},
    {'icon': Icons.flight_takeoff_rounded, 'title': 'Travel', 'color': const Color(0xFF8B5CF6)},
    {'icon': Icons.gamepad_rounded, 'title': 'Games', 'color': const Color(0xFFEC4899)},
    {'icon': Icons.health_and_safety_rounded, 'title': 'Asuransi', 'color': const Color(0xFF14B8A6)},
    {'icon': Icons.grid_view_rounded, 'title': 'Semua Menu', 'color': const Color(0xFF64748B)},
  ];

  // Riwayat Transaksi Palsu
  final List<Map<String, dynamic>> _recentTransactions = [
    {'title': 'Transfer ke Budi', 'date': 'Hari ini, 10:45', 'amount': '-Rp 250.000', 'isIncome': false, 'icon': Icons.arrow_upward_rounded},
    {'title': 'Top Up GoPay', 'date': 'Kemarin, 19:20', 'amount': '-Rp 100.000', 'isIncome': false, 'icon': Icons.account_balance_wallet},
    {'title': 'Terima dari PT Makmur', 'date': '23 Mar, 14:00', 'amount': '+Rp 5.500.000', 'isIncome': true, 'icon': Icons.arrow_downward_rounded},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6F9),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderAndBalance(),
            const SizedBox(height: 20),
            _buildActionMenu(),
            const SizedBox(height: 25),
            _buildQuickSend(),
            const SizedBox(height: 25),
            _buildPromoSection(),
            const SizedBox(height: 25),
            _buildRecentTransactions(),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeaderAndBalance() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background Gradient
        Container(
          height: 250,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 60, left: 24, right: 24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Selamat pagi,',
                      style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ZAINUL AVIEN FAIQ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 22,
                    child: Icon(Icons.person, color: Color(0xFF203A43), size: 28),
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Floating Saldo
        Positioned(
          top: 140,
          left: 24,
          right: 24,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF203A43).withValues(alpha: 0.15),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                  spreadRadius: -5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0F2FE),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.account_balance_wallet, size: 16, color: Color(0xFF0369A1)),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Total Saldo Anda',
                          style: TextStyle(
                            color: Color(0xFF64748B),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _isBalanceVisible = !_isBalanceVisible),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              _isBalanceVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                              color: const Color(0xFF64748B),
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _isBalanceVisible ? 'Sembunyikan' : 'Tampilkan',
                              style: const TextStyle(color: Color(0xFF64748B), fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _isBalanceVisible ? 'Rp 24.850.500' : 'Rp •••••••••',
                  style: const TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.0,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'Rekening Tahapan',
                      style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFECFDF5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.trending_up_rounded, size: 14, color: Color(0xFF059669)),
                          SizedBox(width: 4),
                          Text('+4.2%', style: TextStyle(color: Color(0xFF059669), fontSize: 12, fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionMenu() {
    return Padding(
      padding: const EdgeInsets.only(top: 85, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Layanan Utama',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              Icon(Icons.tune_rounded, color: const Color(0xFF94A3B8), size: 20),
            ],
          ),
          const SizedBox(height: 16),
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _menuItems.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Diubah menjadi 4 kolom lebih compact
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = _menuItems[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: index == 7 ? const Color(0xFFF1F5F9) : Colors.white, // warna beda untuk menu "Semuanya"
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: index == 7 ? [] : [
                        BoxShadow(
                          color: const Color(0xFF94A3B8).withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(item['icon'], color: item['color'], size: 28),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    item['title'],
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF475569),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuickSend() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Akses Cepat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 90,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: 6,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Column(
                      children: [
                        Container(
                          width: 55,
                          height: 55,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE2E8F0), width: 2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add_rounded, color: Color(0xFF3B82F6), size: 28),
                        ),
                        const SizedBox(height: 8),
                        const Text('Baru', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFF64748B))),
                      ],
                    ),
                  );
                }
                final names = ['Andi', 'Siti', 'Budi', 'Rina', 'Joko'];
                final colors = [Colors.redAccent, Colors.blueAccent, Colors.green, Colors.orange, Colors.purple];
                return Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: colors[index - 1].withValues(alpha: 0.15),
                        child: Text(
                          names[index - 1][0], // Huruf depan
                          style: TextStyle(color: colors[index - 1], fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(names[index - 1], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF475569))),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Promo Spesial',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Semua Promo', style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.w600)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 160,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              physics: const BouncingScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                final images = [
                  'https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
                  'https://images.unsplash.com/photo-1555529733-0e670560f8e1?ixlib=rb-1.2.1&auto=format&fit=crop&w=800&q=80',
                ];
                final titles = ['Cashback 50% Travel', 'Makan Mewah Hemat 30%'];
                final subTitles = ['Promo Merchant hingga Rp 50.000', 'Gunakan kartu kredit Anda sekarang'];
                
                return Container(
                  width: MediaQuery.of(context).size.width - 60,
                  margin: EdgeInsets.only(right: index == 0 ? 16 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    image: DecorationImage(
                      image: NetworkImage(images[index]),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF1E293B).withValues(alpha: 0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      gradient: LinearGradient(
                        colors: [Colors.black.withValues(alpha: 0.8), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(titles[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(height: 4),
                            Text(subTitles[index], style: const TextStyle(color: Colors.white70, fontSize: 13)),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentTransactions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Transaksi Terakhir',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF94A3B8)),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF94A3B8).withValues(alpha: 0.1),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: _recentTransactions.length,
              separatorBuilder: (context, index) => const Divider(color: Color(0xFFF1F5F9), height: 1),
              itemBuilder: (context, index) {
                final t = _recentTransactions[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: t['isIncome'] ? const Color(0xFFECFDF5) : const Color(0xFFFEF2F2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(t['icon'], color: t['isIncome'] ? const Color(0xFF059669) : const Color(0xFFDC2626), size: 20),
                  ),
                  title: Text(t['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  subtitle: Text(t['date'], style: const TextStyle(fontSize: 12, color: Color(0xFF94A3B8))),
                  trailing: Text(
                    t['amount'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: t['isIncome'] ? const Color(0xFF059669) : const Color(0xFF1E293B),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF94A3B8).withValues(alpha: 0.15),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildNavItem(Icons.home_rounded, 'Home', 0),
              _buildNavItem(Icons.insert_chart_rounded, 'Mutasi', 1),
              _buildScanQRButton(),
              _buildNavItem(Icons.notifications_rounded, 'Pesan', 3),
              _buildNavItem(Icons.person_rounded, 'Profil', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? const Color(0xFF0F2027) : const Color(0xFF94A3B8);
    
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 26),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScanQRButton() {
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = 2),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF203A43).withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Icon(Icons.qr_code_scanner_rounded, color: Colors.white, size: 28),
      ),
    );
  }
}
