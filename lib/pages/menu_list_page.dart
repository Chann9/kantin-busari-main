
import 'package:flutter/material.dart';

import '../main.dart';

// ========================
// MODEL MENU
// ========================

class MenuItem {
  final String id;
  final String name;
  final String category;
  final int price;
  final String description;
  final String imageAsset;
  final String tag;

  const MenuItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.description,
    required this.imageAsset,
    this.tag = '',
  });
}

class CartEntry {
  final MenuItem item;
  final int quantity;

  const CartEntry({
    required this.item,
    required this.quantity,
  });
}

// ========================
// PENYIMPANAN KERANJANG
// ========================

class KantinStore extends ChangeNotifier {
  KantinStore._();

  static final KantinStore instance = KantinStore._();

  final Map<String, CartEntry> cart = {};

  int get itemCount {
    return cart.values.fold(
      0,
      (total, entry) => total + entry.quantity,
    );
  }

  int get subtotal {
    return cart.values.fold(
      0,
      (total, entry) =>
          total + (entry.item.price * entry.quantity),
    );
  }

  void add(MenuItem item) {
    final existing = cart[item.id];

    if (existing != null) {
      cart[item.id] = CartEntry(
        item: item,
        quantity: existing.quantity + 1,
      );
    } else {
      cart[item.id] = CartEntry(
        item: item,
        quantity: 1,
      );
    }

    notifyListeners();
  }

  void setQuantity(String id, int quantity) {
    if (!cart.containsKey(id)) return;

    if (quantity <= 0) {
      cart.remove(id);
    } else {
      final existing = cart[id]!;

      cart[id] = CartEntry(
        item: existing.item,
        quantity: quantity,
      );
    }

    notifyListeners();
  }

  void remove(String id) {
    cart.remove(id);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}

// ========================
// DATA MENU KANTIN BU SARI
// ========================

const List<MenuItem> kantinMenus = [
  // MAKANAN

  MenuItem(
    id: 'nasi_goreng',
    name: 'Nasi Goreng Seafood',
    category: 'Makanan',
    price: 25000,
    description:
        'Nasi goreng dengan perpaduan seafood dan bumbu khas yang gurih.',
    imageAsset: 'assets/images/nasigoreng.jpeg',
    tag: 'Favorit Kantin',
  ),
  MenuItem(
    id: 'ayam_penyet',
    name: 'Ayam Penyet',
    category: 'Makanan',
    price: 22000,
    description:
        'Ayam goreng dengan sambal penyet, lalapan, dan nasi hangat.',
    imageAsset: 'assets/images/ayampenyet.jpeg',
  ),
  MenuItem(
    id: 'nasi_bakar',
    name: 'Nasi Bakar Cumi',
    category: 'Makanan',
    price: 23000,
    description:
        'Nasi berbumbu yang dibungkus daun pisang dengan isian cumi.',
    imageAsset: 'assets/images/nasibakar.jpeg',
  ),
  MenuItem(
    id: 'soto_ayam',
    name: 'Soto Ayam',
    category: 'Makanan',
    price: 18000,
    description:
        'Soto ayam berkuah hangat dengan rempah dan pelengkap pilihan.',
    imageAsset: 'assets/images/soto.jpeg',
  ),
  MenuItem(
    id: 'bakso',
    name: 'Bakso',
    category: 'Makanan',
    price: 17000,
    description:
        'Bakso dengan kuah gurih, mi, dan pelengkap yang nikmat.',
    imageAsset: 'assets/images/bakso.jpeg',
  ),
  MenuItem(
    id: 'kwetiau',
    name: 'Kwetiau Telur',
    category: 'Makanan',
    price: 20000,
    description:
        'Kwetiau yang dimasak dengan telur dan bumbu pilihan.',
    imageAsset: 'assets/images/Kwetiau.jpeg',
  ),
  MenuItem(
    id: 'mie_ayam',
    name: 'Mie Ayam',
    category: 'Makanan',
    price: 16000,
    description:
        'Mi kenyal dengan topping ayam berbumbu dan sayuran.',
    imageAsset: 'assets/images/mieayam.jpeg',
  ),
  MenuItem(
    id: 'sate',
    name: 'Sate',
    category: 'Makanan',
    price: 22000,
    description:
        'Sate dengan bumbu kacang gurih dan pelengkap pilihan.',
    imageAsset: 'assets/images/sate.jpeg',
  ),

  // MINUMAN

  MenuItem(
    id: 'es_teh',
    name: 'Es Teh Manis',
    category: 'Minuman',
    price: 5000,
    description:
        'Teh manis dingin yang menyegarkan untuk menemani makan.',
    imageAsset: 'assets/images/estehmanis.jpeg',
  ),
  MenuItem(
    id: 'es_jeruk',
    name: 'Es Jeruk',
    category: 'Minuman',
    price: 8000,
    description:
        'Minuman jeruk dingin dengan rasa manis dan segar.',
    imageAsset: 'assets/images/esjeruk.jpeg',
  ),
  MenuItem(
    id: 'matcha',
    name: 'Matcha Latte',
    category: 'Minuman',
    price: 18000,
    description:
        'Perpaduan matcha dan susu dengan rasa lembut.',
    imageAsset: 'assets/images/matchalatte.jpeg',
  ),
  MenuItem(
    id: 'kopi_susu',
    name: 'Coffee Susu Gula Aren',
    category: 'Minuman',
    price: 18000,
    description:
        'Kopi susu dengan manis khas gula aren.',
    imageAsset: 'assets/images/coffegulren.jpeg',
  ),
  MenuItem(
    id: 'thai_tea',
    name: 'Thai Tea',
    category: 'Minuman',
    price: 15000,
    description:
        'Teh susu ala Thailand dengan rasa manis dan creamy.',
    imageAsset: 'assets/images/thaitea.jpeg',
  ),
  MenuItem(
    id: 'jus_alpukat',
    name: 'Jus Alpukat',
    category: 'Minuman',
    price: 15000,
    description:
        'Jus alpukat lembut yang dibuat untuk menemani waktu makan.',
    imageAsset: 'assets/images/jusalpukat.jpeg',
  ),
  MenuItem(
    id: 'jus_mangga',
    name: 'Jus Mangga',
    category: 'Minuman',
    price: 14000,
    description:
        'Jus mangga dengan rasa manis dan menyegarkan.',
    imageAsset: 'assets/images/jusmangga.jpeg',
  ),
  MenuItem(
    id: 'air_putih',
    name: 'Air Putih',
    category: 'Minuman',
    price: 4000,
    description:
        'Air mineral untuk menemani aktivitas sehari-hari.',
    imageAsset: 'assets/images/airputih.jpeg',
  ),

  // CAMILAN

  MenuItem(
    id: 'dimsum_mentai',
    name: 'Dimsum Mentai',
    category: 'Camilan',
    price: 18000,
    description:
        'Dimsum lembut dengan saus mentai yang gurih.',
    imageAsset: 'assets/images/dimsummentai.jpeg',
  ),
  MenuItem(
    id: 'udang_keju',
    name: 'Udang Keju',
    category: 'Camilan',
    price: 16000,
    description:
        'Camilan renyah dengan perpaduan udang dan keju.',
    imageAsset: 'assets/images/udangkeju.jpeg',
  ),
  MenuItem(
    id: 'cheese_roll',
    name: 'Cheese Roll',
    category: 'Camilan',
    price: 12000,
    description:
        'Gulungan pastry renyah dengan isian keju.',
    imageAsset: 'assets/images/Cheeseroll.jpeg',
  ),
  MenuItem(
    id: 'cireng',
    name: 'Cireng Ayam Suwir',
    category: 'Camilan',
    price: 12000,
    description:
        'Cireng renyah dengan isian ayam suwir berbumbu.',
    imageAsset: 'assets/images/cirengjs.jpeg',
  ),
  MenuItem(
    id: 'piscok',
    name: 'Piscok Lumer',
    category: 'Camilan',
    price: 10000,
    description:
        'Pisang cokelat dengan isian cokelat yang lumer.',
    imageAsset: 'assets/images/piscoklumer.jpeg',
  ),
  MenuItem(
    id: 'pisang_goreng',
    name: 'Pisang Goreng',
    category: 'Camilan',
    price: 10000,
    description:
        'Pisang goreng dengan tekstur renyah di luar dan lembut di dalam.',
    imageAsset: 'assets/images/pisgor.jpeg',
  ),
  MenuItem(
    id: 'waffle',
    name: 'Waffle',
    category: 'Camilan',
    price: 15000,
    description:
        'Waffle hangat yang cocok untuk camilan sore.',
    imageAsset: 'assets/images/waffle.jpeg',
  ),
  MenuItem(
    id: 'cilok',
    name: 'Cilok Mercon',
    category: 'Camilan',
    price: 10000,
    description:
        'Cilok kenyal dengan isian dan cita rasa pedas.',
    imageAsset: 'assets/images/cilok.jpeg',
  ),
];

// ========================
// FORMAT HARGA
// ========================

String formatRupiah(int amount) {
  final digits = amount.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < digits.length; i++) {
    buffer.write(digits[i]);

    final remaining = digits.length - i - 1;

    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write('.');
    }
  }

  return 'Rp$buffer';
}

// ========================
// HALAMAN DAFTAR MENU
// ========================

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

  final List<String> _categories = const [
    'Semua',
    'Makanan',
    'Minuman',
    'Camilan',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<MenuItem> get _filteredMenus {
    return kantinMenus.where((item) {
      final matchesCategory =
          _category == 'Semua' || item.category == _category;

      final query = _search.toLowerCase();

      final matchesSearch =
          item.name.toLowerCase().contains(query) ||
          item.category.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  void _openDetail(MenuItem item) {
    Navigator.pushNamed(
      context,
      '/detail',
      arguments: item,
    );
  }

  void _addToCart(MenuItem item) {
    KantinStore.instance.add(item);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('${item.name} ditambahkan ke keranjang'),
          duration: const Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Lihat',
            onPressed: () {
              Navigator.pushNamed(context, '/pesan');
            },
          ),
        ),
      );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      decoration: BoxDecoration(
        color: kForest,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'KANTIN BU SARI',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 2,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Makan enak,\nharga bersahabat.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 27,
              height: 1.2,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Temukan menu favoritmu untuk hari ini.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.restaurant_menu,
                  color: Colors.white,
                  size: 18,
                ),
                SizedBox(width: 8),
                Text(
                  'Pilihan makanan, minuman, dan camilan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      onChanged: (value) {
        setState(() {
          _search = value.trim();
        });
      },
      decoration: InputDecoration(
        hintText: 'Cari menu yang kamu inginkan...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _search.isNotEmpty
            ? IconButton(
                onPressed: () {
                  _searchController.clear();

                  setState(() {
                    _search = '';
                  });
                },
                icon: const Icon(Icons.close),
              )
            : null,
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _categories.map((category) {
          final selected = _category == category;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: selected,
              showCheckmark: false,
              selectedColor: kForest,
              backgroundColor: const Color(0xFFF0E9DB),
              labelStyle: TextStyle(
                color: selected ? Colors.white : kText,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
              onSelected: (_) {
                setState(() {
                  _category = category;
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMenuCard(MenuItem item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  item.imageAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Container(
                      color: const Color(0xFFE7E1D4),
                      child: const Center(
                        child: Icon(
                          Icons.restaurant,
                          color: kForest,
                          size: 42,
                        ),
                      ),
                    );
                  },
                ),
                if (item.tag.isNotEmpty)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: kOrange,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        item.tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 9, 10, 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.category.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kMuted,
                      fontSize: 9,
                      letterSpacing: 0.8,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: kText,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    formatRupiah(item.price),
                    maxLines: 1,
                    style: const TextStyle(
                      color: kOrange,
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 34,
                          child: OutlinedButton(
                            onPressed: () => _openDetail(item),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              foregroundColor: kForest,
                              side: const BorderSide(
                                color: kForest,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text(
                              'Detail',
                              style: TextStyle(fontSize: 11),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 6),
                      SizedBox(
                        width: 36,
                        height: 34,
                        child: ElevatedButton(
                          onPressed: () => _addToCart(item),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            backgroundColor: kOrange,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Icon(
                            Icons.add_shopping_cart,
                            size: 17,
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
    );
  }

  Widget _buildMenuGrid() {
    final menus = _filteredMenus;

    if (menus.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 48),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 48,
                color: kMuted,
              ),
              SizedBox(height: 12),
              Text(
                'Menu tidak ditemukan',
                style: TextStyle(
                  color: kText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Coba kata kunci atau kategori lain.',
                style: TextStyle(
                  color: kMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        final columns = width >= 900
            ? 4
            : width >= 600
                ? 3
                : 2;

        final ratio = width < 360 ? 0.57 : 0.64;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menus.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: ratio,
          ),
          itemBuilder: (context, index) {
            return _buildMenuCard(menus[index]);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = KantinStore.instance;

    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Kantin Bu Sari',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Center(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () {
                      Navigator.pushNamed(context, '/pesan');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 9,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7EFE7),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            color: kForest,
                            size: 20,
                          ),
                          if (store.itemCount > 0) ...[
                            const SizedBox(width: 6),
                            Text(
                              '${store.itemCount}',
                              style: const TextStyle(
                                color: kForest,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 22),
                  _buildSearchField(),
                  const SizedBox(height: 18),
                  const Text(
                    'Kategori Menu',
                    style: TextStyle(
                      fontSize: 17,
                      color: kForest,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildCategoryFilter(),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Menu Pilihan',
                          style: TextStyle(
                            fontSize: 19,
                            color: kForest,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        '${_filteredMenus.length} menu',
                        style: const TextStyle(
                          color: kMuted,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildMenuGrid(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: 0,
            onDestinationSelected: (index) {
              if (index == 1) {
                Navigator.pushNamed(context, '/pesan');
              }
            },
            destinations: [
              const NavigationDestination(
                icon: Icon(Icons.restaurant_menu_outlined),
                selectedIcon: Icon(Icons.restaurant_menu),
                label: 'Menu',
              ),
              NavigationDestination(
                icon: Badge(
                  isLabelVisible: store.itemCount > 0,
                  label: Text('${store.itemCount}'),
                  child: const Icon(Icons.shopping_bag_outlined),
                ),
                selectedIcon: const Icon(Icons.shopping_bag),
                label: 'Pesanan',
              ),
            ],
          ),
        );
      },
    );
  }
}