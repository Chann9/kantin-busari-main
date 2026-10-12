// import 'package:flutter/material.dart';

// class MenuListPage extends StatelessWidget {
//   const MenuListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kantin Bu Sari - Daftar Menu'),
//         backgroundColor: Colors.deepOrange,
//         foregroundColor: Colors.white,
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text(
//                 'Selamat Datang di Kantin Bu Sari!',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 8),
//               const Text(
//                 'Pilih menu favoritmu di bawah ini:',
//                 textAlign: TextAlign.center,
//               ),
//               const SizedBox(height: 24),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/detail');
//                 },
//                 icon: const Icon(Icons.restaurant_menu),
//                 label: const Text('Lihat Detail Menu'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

import '../main.dart';

// ============================================================
// MODEL MENU
// ============================================================

class MenuItem {
  const MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageAsset,
    this.tag,
  });

  final String id;
  final String name;
  final String category;
  final int price;
  final String description;
  final String imageAsset;
  final String? tag;
}

// ============================================================
// MODEL KERANJANG DAN PENYIMPANAN DATA SEMENTARA
// ============================================================

class CartEntry {
  CartEntry({
    required this.item,
    this.quantity = 1,
  });

  final MenuItem item;
  int quantity;
}

class KantinStore extends ChangeNotifier {
  KantinStore._();

  static final KantinStore instance = KantinStore._();

  final Map<String, CartEntry> cart = {};
  final Set<String> favorites = {};

  int get itemCount =>
      cart.values.fold(0, (sum, entry) => sum + entry.quantity);

  int get subtotal =>
      cart.values.fold(0, (sum, entry) => sum + entry.item.price * entry.quantity);

  void add(MenuItem item, [int quantity = 1]) {
    if (cart.containsKey(item.id)) {
      cart[item.id]!.quantity += quantity;
    } else {
      cart[item.id] = CartEntry(
        item: item,
        quantity: quantity,
      );
    }
    notifyListeners();
  }

  void setQuantity(String id, int quantity) {
    if (!cart.containsKey(id)) return;

    if (quantity <= 0) {
      cart.remove(id);
    } else {
      cart[id]!.quantity = quantity;
    }

    notifyListeners();
  }

  void remove(String id) {
    cart.remove(id);
    notifyListeners();
  }

  void toggleFavorite(String id) {
    if (!favorites.add(id)) {
      favorites.remove(id);
    }
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}

// ============================================================
// DATA 24 MENU KANTIN BU SARI
// Nama aset disesuaikan dengan file yang tersedia.
// ============================================================

const List<MenuItem> kantinMenus = [
  // -------------------- MAKANAN --------------------

  MenuItem(
    id: 'm1',
    name: 'Nasi Goreng Seafood',
    category: 'Makanan',
    price: 25000,
    description:
        'Nasi goreng gurih dengan udang, cumi, telur, dan sayuran segar.',
    imageAsset: 'assets/images/nasigoreng.jpeg',
    tag: 'Favorit',
  ),
  MenuItem(
    id: 'm2',
    name: 'Ayam Penyet',
    category: 'Makanan',
    price: 22000,
    description:
        'Ayam goreng empuk dengan sambal khas dan lalapan segar.',
    imageAsset: 'assets/images/ayampenyet.jpeg',
    tag: 'Pedas',
  ),
  MenuItem(
    id: 'm3',
    name: 'Nasi Bakar Cumi',
    category: 'Makanan',
    price: 24000,
    description:
        'Nasi berbumbu yang dibungkus daun pisang dan dibakar bersama cumi.',
    imageAsset: 'assets/images/nasibakar.jpeg',
  ),
  MenuItem(
    id: 'm4',
    name: 'Soto Ayam',
    category: 'Makanan',
    price: 18000,
    description:
        'Soto ayam hangat dengan kuah rempah, suwiran ayam, dan bawang goreng.',
    imageAsset: 'assets/images/soto.jpeg',
  ),
  MenuItem(
    id: 'm5',
    name: 'Bakso',
    category: 'Makanan',
    price: 18000,
    description:
        'Bakso kenyal dengan kuah kaldu hangat, mi, dan sayuran.',
    imageAsset: 'assets/images/bakso.jpeg',
  ),
  MenuItem(
    id: 'm6',
    name: 'Kwetiau Telur',
    category: 'Makanan',
    price: 18000,
    description:
        'Kwetiau tumis dengan telur, sayuran, dan bumbu gurih.',
    imageAsset: 'assets/images/Kwetiau.jpeg',
  ),
  MenuItem(
    id: 'm7',
    name: 'Mie Ayam',
    category: 'Makanan',
    price: 15000,
    description:
        'Mi kenyal dengan topping ayam berbumbu dan sayuran.',
    imageAsset: 'assets/images/mieayam.jpeg',
    tag: 'Populer',
  ),
  MenuItem(
    id: 'm8',
    name: 'Sate',
    category: 'Makanan',
    price: 22000,
    description:
        'Sate panggang dengan bumbu kacang khas yang gurih.',
    imageAsset: 'assets/images/sate.jpeg',
  ),

  // -------------------- MINUMAN --------------------

  MenuItem(
    id: 'd1',
    name: 'Es Teh Manis',
    category: 'Minuman',
    price: 5000,
    description:
        'Teh manis dingin yang menyegarkan untuk menemani makanan.',
    imageAsset: 'assets/images/estehmanis.jpeg',
  ),
  MenuItem(
    id: 'd2',
    name: 'Es Jeruk',
    category: 'Minuman',
    price: 8000,
    description:
        'Minuman jeruk segar dengan perpaduan rasa manis dan asam.',
    imageAsset: 'assets/images/esjeruk.jpeg',
  ),
  MenuItem(
    id: 'd3',
    name: 'Matcha Latte',
    category: 'Minuman',
    price: 15000,
    description:
        'Matcha dengan susu lembut dan rasa khas yang nikmat.',
    imageAsset: 'assets/images/matchalatte.jpeg',
    tag: 'Favorit',
  ),
  MenuItem(
    id: 'd4',
    name: 'Coffee Susu Gula Aren',
    category: 'Minuman',
    price: 15000,
    description:
        'Kopi susu dengan manis legit gula aren dan aroma kopi.',
    imageAsset: 'assets/images/coffegulren.jpeg',
  ),
  MenuItem(
    id: 'd5',
    name: 'Thai Tea',
    category: 'Minuman',
    price: 12000,
    description:
        'Teh khas Thailand dengan susu creamy dan rasa yang nikmat.',
    imageAsset: 'assets/images/thaitea.jpeg',
  ),
  MenuItem(
    id: 'd6',
    name: 'Jus Alpukat',
    category: 'Minuman',
    price: 12000,
    description:
        'Jus alpukat lembut yang dibuat dari buah pilihan.',
    imageAsset: 'assets/images/jusalpukat.jpeg',
  ),
  MenuItem(
    id: 'd7',
    name: 'Jus Mangga',
    category: 'Minuman',
    price: 12000,
    description:
        'Jus mangga segar dengan rasa manis alami.',
    imageAsset: 'assets/images/jusmangga.jpeg',
  ),
  MenuItem(
    id: 'd8',
    name: 'Air Putih',
    category: 'Minuman',
    price: 4000,
    description:
        'Air mineral untuk menemani hidangan pilihanmu.',
    imageAsset: 'assets/images/airputih.jpeg',
  ),

  // -------------------- CEMILAN --------------------

  MenuItem(
    id: 'c1',
    name: 'Dimsum Mentai',
    category: 'Cemilan',
    price: 20000,
    description:
        'Dimsum lembut dengan saus mentai creamy yang gurih.',
    imageAsset: 'assets/images/dimsummentai.jpeg',
    tag: 'Favorit',
  ),
  MenuItem(
    id: 'c2',
    name: 'Udang Keju',
    category: 'Cemilan',
    price: 18000,
    description:
        'Camilan udang renyah dengan isian keju yang lumer.',
    imageAsset: 'assets/images/udangkeju.jpeg',
  ),
  MenuItem(
    id: 'c3',
    name: 'Cheese Roll',
    category: 'Cemilan',
    price: 12000,
    description:
        'Gulungan renyah dengan isian keju yang gurih.',
    imageAsset: 'assets/images/Cheeseroll.jpeg',
  ),
  MenuItem(
    id: 'c4',
    name: 'Cireng Ayam Suwir',
    category: 'Cemilan',
    price: 12000,
    description:
        'Cireng renyah dengan isian ayam suwir berbumbu.',
    imageAsset: 'assets/images/cirengjs.jpeg',
  ),
  MenuItem(
    id: 'c5',
    name: 'Piscok Lumer',
    category: 'Cemilan',
    price: 10000,
    description:
        'Pisang dan cokelat dalam kulit renyah dengan isian lumer.',
    imageAsset: 'assets/images/piscoklumer.jpeg',
  ),
  MenuItem(
    id: 'c6',
    name: 'Pisang Goreng',
    category: 'Cemilan',
    price: 10000,
    description:
        'Pisang goreng hangat dengan bagian luar renyah.',
    imageAsset: 'assets/images/pisgor.jpeg',
  ),
  MenuItem(
    id: 'c7',
    name: 'Waffle',
    category: 'Cemilan',
    price: 15000,
    description:
        'Waffle hangat dengan tekstur renyah di luar dan lembut di dalam.',
    imageAsset: 'assets/images/waffle.jpeg',
  ),
  MenuItem(
    id: 'c8',
    name: 'Cilok Mercon',
    category: 'Cemilan',
    price: 12000,
    description:
        'Cilok kenyal dengan bumbu pedas yang menggugah selera.',
    imageAsset: 'assets/images/cilok.jpeg',
    tag: 'Pedas',
  ),
];

// ============================================================
// FORMAT HARGA RUPIAH
// ============================================================

String formatRupiah(int amount) {
  final digits = amount.toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);

    final remaining = digits.length - i - 1;
    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write('.');
    }
  }

  return 'Rp ${buffer.toString()}';
}

// ============================================================
// HALAMAN DAFTAR MENU
// ============================================================

class MenuListPage extends StatefulWidget {
  const MenuListPage({super.key});

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final TextEditingController _searchController =
      TextEditingController();

  String _category = 'Semua';
  String _search = '';
  int _tab = 0;
  bool _routeTabInitialized = false;

  final List<String> _categories = const [
    'Semua',
    'Makanan',
    'Minuman',
    'Cemilan',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_routeTabInitialized) {
      final argument = ModalRoute.of(context)?.settings.arguments;

      if (argument == 'menu') {
        _tab = 1;
      }

      _routeTabInitialized = true;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _openDetail(MenuItem item) {
    Navigator.pushNamed(
      context,
      '/detail',
      arguments: item,
    );
  }

  List<MenuItem> _getVisibleMenus() {
    return kantinMenus.where((item) {
      final categoryMatch =
          _category == 'Semua' || item.category == _category;

      final query = _search.trim().toLowerCase();

      final searchMatch =
          item.name.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query);

      return categoryMatch && searchMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final store = KantinStore.instance;
    final visibleMenus = _getVisibleMenus();

    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: kForest,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.restaurant_menu_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kantin Bu Sari',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: kForest,
                        ),
                      ),
                      Text(
                        'Enak, praktis, harga bersahabat',
                        style: TextStyle(
                          fontSize: 11,
                          color: kMuted,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                tooltip: 'Pesanan saya',
                onPressed: () {
                  Navigator.pushNamed(context, '/pesan');
                },
                icon: Badge(
                  label: Text('${store.itemCount}'),
                  isLabelVisible: store.itemCount > 0,
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),

          body: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth = constraints.maxWidth > 1200
                  ? 1200.0
                  : constraints.maxWidth;

              return Center(
                child: SizedBox(
                  width: maxWidth,
                  child: CustomScrollView(
                    slivers: [
                      if (_tab == 0) ...[
                        SliverToBoxAdapter(
                          child: _buildWelcome(),
                        ),
                        SliverToBoxAdapter(
                          child: _buildSearch(),
                        ),
                        SliverToBoxAdapter(
                          child: _buildCategoryChips(),
                        ),
                        SliverToBoxAdapter(
                          child: _buildHeroBanner(),
                        ),
                        SliverToBoxAdapter(
                          child: _sectionTitle(
                            'Rekomendasi Bu Sari',
                            'Pilihan favorit',
                          ),
                        ),
                      ] else ...[
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              20,
                              18,
                              20,
                              8,
                            ),
                            child: Text(
                              'Jelajahi Menu',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                    color: kForest,
                                  ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: _buildSearch(),
                        ),
                        SliverToBoxAdapter(
                          child: _buildCategoryChips(),
                        ),
                      ],

                      // GRID MENU
                      if (_tab == 0 &&
                          _search.isEmpty &&
                          _category == 'Semua')
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                            20,
                            0,
                            20,
                            12,
                          ),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  _columns(constraints.maxWidth),
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio:
                                  constraints.maxWidth < 520
                                      ? 0.62
                                      : 0.82,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return _menuCard(kantinMenus[index]);
                              },
                              childCount: 4,
                            ),
                          ),
                        )
                      else
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(
                            20,
                            4,
                            20,
                            24,
                          ),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  _columns(constraints.maxWidth),
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio:
                                  constraints.maxWidth < 520
                                      ? 0.62
                                      : 0.82,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return _menuCard(visibleMenus[index]);
                              },
                              childCount: visibleMenus.length,
                            ),
                          ),
                        ),

                      if (visibleMenus.isEmpty)
                        const SliverToBoxAdapter(
                          child: Padding(
                            padding: EdgeInsets.all(40),
                            child: Center(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search_off_rounded,
                                    size: 48,
                                    color: kMuted,
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    'Menu tidak ditemukan.',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: kText,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Coba kata kunci atau kategori lain.',
                                    style: TextStyle(color: kMuted),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      const SliverToBoxAdapter(
                        child: SizedBox(height: 20),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          bottomNavigationBar: NavigationBar(
            selectedIndex: _tab,
            backgroundColor: kCard,
            indicatorColor: const Color(0xFFDDE9DF),
            onDestinationSelected: (index) {
              if (index == 2) {
                Navigator.pushNamed(context, '/pesan');
              } else {
                setState(() {
                  _tab = index;
                  _category = 'Semua';
                });
              }
            },
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: 'Beranda',
              ),
              NavigationDestination(
                icon: Icon(Icons.restaurant_menu_outlined),
                selectedIcon: Icon(Icons.restaurant_menu),
                label: 'Menu',
              ),
              NavigationDestination(
                icon: Icon(Icons.receipt_long_outlined),
                selectedIcon: Icon(Icons.receipt_long),
                label: 'Pesanan',
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // RESPONSIVE GRID
  // ==========================================================

  int _columns(double width) {
    if (width >= 1000) return 4;
    if (width >= 650) return 3;
    if (width >= 390) return 2;
    return 1;
  }

  // ==========================================================
  // SAPAAN BERANDA
  // ==========================================================

  Widget _buildWelcome() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 18, 20, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halo, selamat datang!',
            style: TextStyle(
              color: kMuted,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Lagi pengin makan apa?',
            style: TextStyle(
              color: kText,
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PENCARIAN MENU
  // ==========================================================

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
      child: TextField(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _search = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search_rounded),
          hintText: 'Cari makanan atau minuman...',
          suffixIcon: _search.isNotEmpty
              ? IconButton(
                  tooltip: 'Hapus pencarian',
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _search = '';
                    });
                  },
                  icon: const Icon(Icons.close_rounded),
                )
              : null,
        ),
      ),
    );
  }

  // ==========================================================
  // FILTER KATEGORI
  // ==========================================================

  Widget _buildCategoryChips() {
    return SizedBox(
      height: 52,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 4,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final selected = _category == category;

          return ChoiceChip(
            avatar: selected
                ? const Icon(
                    Icons.check,
                    size: 16,
                    color: Colors.white,
                  )
                : null,
            label: Text(category),
            selected: selected,
            labelStyle: TextStyle(
              color: selected ? Colors.white : kText,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) {
              setState(() {
                _category = category;
              });
            },
          );
        },
      ),
    );
  }

  // ==========================================================
  // BANNER BERANDA
  // ==========================================================

  Widget _buildHeroBanner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Container(
        height: 184,
        decoration: BoxDecoration(
          color: kForest,
          borderRadius: BorderRadius.circular(22),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Positioned(
              right: -20,
              top: -15,
              bottom: -15,
              width: 205,
              child: Image.asset(
                kantinMenus.first.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return const ColoredBox(
                    color: kForestDark,
                    child: Icon(
                      Icons.restaurant,
                      size: 80,
                      color: Colors.white24,
                    ),
                  );
                },
              ),
            ),
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kForest,
                      kForest.withValues(alpha: 0.96),
                      kForest.withValues(alpha: 0.05),
                    ],
                    stops: const [0, 0.55, 1],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: SizedBox(
                width: 230,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Lapar?\nPilih favoritmu!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        height: 1.1,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Makanan lezat, dibuat dengan sepenuh hati.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: 42,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _tab = 1;
                            _category = 'Semua';
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kOrange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          tapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text(
                          'Lihat Menu  →',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // JUDUL BAGIAN
  // ==========================================================

  Widget _sectionTitle(String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: kText,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 12,
              color: kOrange,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // KARTU MENU
  // ==========================================================

  Widget _menuCard(MenuItem item) {
    final store = KantinStore.instance;
    final favorite = store.favorites.contains(item.id);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () => _openDetail(item),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FOTO DAN LABEL
            Expanded(
              flex: 6,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    item.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: Color(0xFFE7E1D4),
                        child: Center(
                          child: Icon(
                            Icons.restaurant,
                            color: kForest,
                            size: 38,
                          ),
                        ),
                      );
                    },
                  ),
                  if (item.tag != null)
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: kCard,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          item.tag!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: kForest,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  Positioned(
                    right: 5,
                    top: 5,
                    child: Material(
                      color: kCard,
                      shape: const CircleBorder(),
                      child: IconButton(
                        tooltip: favorite
                            ? 'Hapus dari favorit'
                            : 'Tambah ke favorit',
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints(
                          minWidth: 36,
                          minHeight: 36,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          store.toggleFavorite(item.id);
                        },
                        icon: Icon(
                          favorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: favorite ? kOrange : kForest,
                          size: 19,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // INFORMASI MENU
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 9, 10, 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NAMA MENU
                    Text(
                      item.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.2,
                        fontWeight: FontWeight.w800,
                        color: kText,
                      ),
                    ),

                    const SizedBox(height: 5),

                    // DESKRIPSI MENU
                    Text(
                      item.description.trim().isEmpty
                          ? 'Menu lezat dari Kantin Bu Sari.'
                          : item.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 11,
                        height: 1.3,
                        color: kMuted,
                      ),
                    ),

                    const Spacer(),

                    // HARGA DAN TOMBOL TAMBAH
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            formatRupiah(item.price),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              color: kOrange,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        SizedBox(
                          width: 32,
                          height: 32,
                          child: IconButton.filled(
                            tooltip: 'Tambah ke pesanan',
                            padding: EdgeInsets.zero,
                            style: IconButton.styleFrom(
                              backgroundColor: kOrange,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              store.add(item);

                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${item.name} ditambahkan ke pesanan',
                                    ),
                                    duration: const Duration(
                                      milliseconds: 1200,
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                            },
                            icon: const Icon(
                              Icons.add,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}