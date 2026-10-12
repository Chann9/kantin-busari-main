
import 'package:flutter/material.dart';
import '../main.dart';

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
  int quantity;

  CartEntry({required this.item, this.quantity = 1});
}

class KantinStore extends ChangeNotifier {
  KantinStore._();

  static final KantinStore instance = KantinStore._();

  final Map<String, CartEntry> cart = {};

  int get itemCount =>
      cart.values.fold(0, (total, entry) => total + entry.quantity);

  int get subtotal => cart.values.fold(
        0,
        (total, entry) => total + entry.item.price * entry.quantity,
      );

  void add(MenuItem item) {
    if (cart.containsKey(item.id)) {
      cart[item.id]!.quantity++;
    } else {
      cart[item.id] = CartEntry(item: item);
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

  void clearCart() {
    cart.clear();
    notifyListeners();
  }
}

const List<MenuItem> kantinMenus = [
  MenuItem(
    id: '1',
    name: 'Nasi Goreng Seafood',
    category: 'Makanan',
    price: 25000,
    description:
        'Nasi goreng gurih dengan udang, cumi, telur, dan sayuran segar.',
    imageAsset: 'assets/images/nasigoreng.jpeg',
  ),
  MenuItem(
    id: '2',
    name: 'Ayam Penyet',
    category: 'Makanan',
    price: 20000,
    description:
        'Ayam goreng empuk dengan sambal khas dan lalapan segar.',
    imageAsset: 'assets/images/ayampenyet.jpeg',
  ),
  MenuItem(
    id: '3',
    name: 'Nasi Bakar Cumi',
    category: 'Makanan',
    price: 22000,
    description:
        'Nasi berbumbu yang dibungkus daun pisang dan dibakar bersama cumi.',
    imageAsset: 'assets/images/nasibakar.jpeg',
  ),
  MenuItem(
    id: '4',
    name: 'Soto Ayam',
    category: 'Makanan',
    price: 18000,
    description:
        'Soto ayam hangat dengan kuah rempah, suwiran ayam, dan bawang goreng.',
    imageAsset: 'assets/images/soto.jpeg',
  ),
  MenuItem(
    id: '5',
    name: 'Bakso',
    category: 'Makanan',
    price: 15000,
    description: 'Bakso daging dengan kuah gurih, mi, dan pelengkap segar.',
    imageAsset: 'assets/images/bakso.jpeg',
  ),
  MenuItem(
    id: '6',
    name: 'Kwetiau Goreng',
    category: 'Makanan',
    price: 20000,
    description: 'Kwetiau goreng dengan bumbu khas dan sayuran pilihan.',
    imageAsset: 'assets/images/Kwetiau.jpeg',
  ),
  MenuItem(
    id: '7',
    name: 'Mi Ayam',
    category: 'Makanan',
    price: 16000,
    description: 'Mi kenyal dengan ayam berbumbu dan sayuran segar.',
    imageAsset: 'assets/images/mieayam.jpeg',
  ),
  MenuItem(
    id: '8',
    name: 'Sate Ayam',
    category: 'Makanan',
    price: 22000,
    description: 'Sate ayam panggang dengan bumbu kacang yang gurih.',
    imageAsset: 'assets/images/sate.jpeg',
  ),
  MenuItem(
    id: '9',
    name: 'Es Teh Manis',
    category: 'Minuman',
    price: 5000,
    description: 'Teh manis dingin yang menyegarkan.',
    imageAsset: 'assets/images/estehmanis.jpeg',
  ),
  MenuItem(
    id: '10',
    name: 'Es Jeruk',
    category: 'Minuman',
    price: 7000,
    description: 'Minuman jeruk segar dengan rasa manis dan sedikit asam.',
    imageAsset: 'assets/images/esjeruk.jpeg',
  ),
  MenuItem(
    id: '11',
    name: 'Matcha Latte',
    category: 'Minuman',
    price: 15000,
    description: 'Perpaduan matcha dan susu dengan rasa lembut.',
    imageAsset: 'assets/images/matchalatte.jpeg',
  ),
  MenuItem(
    id: '12',
    name: 'Kopi Gula Aren',
    category: 'Minuman',
    price: 15000,
    description: 'Kopi susu dengan manis khas gula aren.',
    imageAsset: 'assets/images/coffegulren.jpeg',
  ),
  MenuItem(
    id: '13',
    name: 'Thai Tea',
    category: 'Minuman',
    price: 12000,
    description: 'Teh khas Thailand dengan campuran susu yang creamy.',
    imageAsset: 'assets/images/thaitea.jpeg',
  ),
  MenuItem(
    id: '14',
    name: 'Jus Alpukat',
    category: 'Minuman',
    price: 12000,
    description: 'Jus alpukat lembut yang dibuat dari buah segar.',
    imageAsset: 'assets/images/jusalpukat.jpeg',
  ),
  MenuItem(
    id: '15',
    name: 'Jus Mangga',
    category: 'Minuman',
    price: 12000,
    description: 'Jus mangga dengan rasa manis dan menyegarkan.',
    imageAsset: 'assets/images/jusmangga.jpeg',
  ),
  MenuItem(
    id: '16',
    name: 'Air Putih',
    category: 'Minuman',
    price: 4000,
    description: 'Air mineral untuk menemani santapanmu.',
    imageAsset: 'assets/images/airputih.jpeg',
  ),
  MenuItem(
    id: '17',
    name: 'Dimsum Mentai',
    category: 'Camilan',
    price: 18000,
    description: 'Dimsum lembut dengan saus mentai yang gurih.',
    imageAsset: 'assets/images/dimsummentai.jpeg',
  ),
  MenuItem(
    id: '18',
    name: 'Udang Keju',
    category: 'Camilan',
    price: 15000,
    description: 'Camilan renyah dengan isian udang dan keju.',
    imageAsset: 'assets/images/udangkeju.jpeg',
  ),
  MenuItem(
    id: '19',
    name: 'Cheese Roll',
    category: 'Camilan',
    price: 12000,
    description: 'Gulungan pastry renyah dengan isian keju.',
    imageAsset: 'assets/images/Cheeseroll.jpeg',
  ),
  MenuItem(
    id: '20',
    name: 'Cireng',
    category: 'Camilan',
    price: 10000,
    description: 'Cireng renyah di luar dan kenyal di dalam.',
    imageAsset: 'assets/images/cirengisi.jpeg',
  ),
  MenuItem(
    id: '21',
    name: 'Pisang Cokelat',
    category: 'Camilan',
    price: 12000,
    description: 'Pisang dengan cokelat lumer dalam balutan kulit renyah.',
    imageAsset: 'assets/images/piscok.jpeg',
  ),
  MenuItem(
    id: '22',
    name: 'Pisang Goreng',
    category: 'Camilan',
    price: 10000,
    description: 'Pisang goreng hangat dengan tekstur renyah.',
    imageAsset: 'assets/images/pisgor.jpeg',
  ),
  MenuItem(
    id: '23',
    name: 'Waffle',
    category: 'Camilan',
    price: 15000,
    description: 'Waffle hangat dengan tekstur lembut dan topping lezat.',
    imageAsset: 'assets/images/waffle.jpeg',
  ),
  MenuItem(
    id: '24',
    name: 'Cilok',
    category: 'Camilan',
    price: 8000,
    description: 'Cilok kenyal dengan bumbu pelengkap yang gurih.',
    imageAsset: 'assets/images/cilok.jpeg',
  ),
];

String formatRupiah(int amount) {
  final value = amount.toString();
  final buffer = StringBuffer();

  for (int i = 0; i < value.length; i++) {
    buffer.write(value[i]);
    final remaining = value.length - i - 1;

    if (remaining > 0 && remaining % 3 == 0) {
      buffer.write('.');
    }
  }

  return 'Rp$buffer';
}

class MenuListPage extends StatefulWidget {
  const MenuListPage({super.key});

  @override
  State<MenuListPage> createState() => _MenuListPageState();
}

class _MenuListPageState extends State<MenuListPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _menuSectionKey = GlobalKey();

  String _selectedCategory = 'Semua';
  String _searchQuery = '';
  int _selectedNavIndex = 0;

  final List<String> _categories = [
    'Semua',
    'Makanan',
    'Minuman',
    'Camilan',
  ];

  List<MenuItem> get _filteredMenus {
    return kantinMenus.where((item) {
      final matchesCategory = _selectedCategory == 'Semua' ||
          item.category == _selectedCategory;

      final query = _searchQuery.toLowerCase();
      final matchesSearch = item.name.toLowerCase().contains(query) ||
          item.description.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} ditambahkan ke keranjang'),
        duration: const Duration(seconds: 1),
        backgroundColor: kForest,
      ),
    );
  }

  void _goToHome() {
    setState(() {
      _selectedNavIndex = 0;
    });

    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _goToMenu() {
    setState(() {
      _selectedNavIndex = 1;
      _selectedCategory = 'Semua';
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final menuContext = _menuSectionKey.currentContext;

      if (menuContext != null && mounted) {
        Scrollable.ensureVisible(
          menuContext,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          alignment: 0.02,
        );
      }
    });
  }

  void _goToOrders() {
    setState(() {
      _selectedNavIndex = 2;
    });

    Navigator.pushNamed(context, '/pesan').then((_) {
      if (mounted) {
        setState(() {
          _selectedNavIndex = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAECE1),
        foregroundColor: kForest,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 76,
        titleSpacing: 20,
        title: Row(
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: kForest,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.restaurant_menu,
                color: Colors.white,
                size: 30,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kantin Bu Sari',
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: kForest,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Enak, praktis, harga bersahabat',
                    style: TextStyle(
                      fontSize: 14,
                      color: kMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Keranjang',
            onPressed: _goToOrders,
            icon: AnimatedBuilder(
              animation: KantinStore.instance,
              builder: (context, child) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(
                      Icons.shopping_bag_outlined,
                      size: 29,
                    ),
                    if (KantinStore.instance.itemCount > 0)
                      Positioned(
                        right: -8,
                        top: -8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: kOrange,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${KantinStore.instance.itemCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildBanner(),
                  const SizedBox(height: 28),
                  const Text(
                    'Rekomendasi Bu Sari',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: kText,
                    ),
                  ),
                  const SizedBox(height: 18),
                  _buildRecommendedMenus(),
                  const SizedBox(height: 30),

                  // Bagian tujuan navigasi tombol Menu.
                  KeyedSubtree(
                    key: _menuSectionKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cari Menu',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color: kText,
                          ),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _searchController,
                          onChanged: (value) {
                            setState(() {
                              _searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Cari makanan atau minuman...',
                            prefixIcon: const Icon(
                              Icons.search,
                              color: kForest,
                            ),
                            filled: true,
                            fillColor: kCard,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _categories.map((category) {
                            final selected =
                                _selectedCategory == category;

                            return ChoiceChip(
                              label: Text(category),
                              selected: selected,
                              onSelected: (_) {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                              selectedColor: kForest,
                              backgroundColor: kCard,
                              labelStyle: TextStyle(
                                color:
                                    selected ? Colors.white : kForest,
                                fontWeight: FontWeight.w600,
                              ),
                              side: BorderSide(
                                color: selected
                                    ? kForest
                                    : kForest.withValues(alpha: 0.15),
                              ),
                              showCheckmark: false,
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _selectedCategory == 'Semua'
                              ? 'Semua Menu'
                              : _selectedCategory,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: kText,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildMenuGrid(_filteredMenus),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildBottomNavigation(),
        ],
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 200,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: kForest,
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nikmati Menu Kami!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Makanan lezat, dibuat dengan sepenuh hati.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFFD7E2DA),
                    ),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton(
                    onPressed: _goToMenu,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      'Lihat Menu  →',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Image.asset(
              'assets/images/nasigoreng.jpeg',
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: kForestDark,
                  child: const Center(
                    child: Icon(
                      Icons.restaurant,
                      color: Colors.white,
                      size: 70,
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

  Widget _buildRecommendedMenus() {
    final recommended = kantinMenus.take(4).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final crossAxisCount = width >= 1100
            ? 4
            : width >= 650
                ? 2
                : 1;

        final aspectRatio = crossAxisCount == 4
            ? 0.77
            : crossAxisCount == 2
                ? 0.85
                : 1.25;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recommended.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: aspectRatio,
          ),
          itemBuilder: (context, index) {
            return _buildMenuCard(recommended[index]);
          },
        );
      },
    );
  }

  Widget _buildMenuGrid(List<MenuItem> menus) {
    if (menus.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 54,
                color: kMuted,
              ),
              SizedBox(height: 12),
              Text(
                'Menu tidak ditemukan.',
                style: TextStyle(
                  fontSize: 16,
                  color: kMuted,
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
        final crossAxisCount = width >= 1100
            ? 4
            : width >= 650
                ? 3
                : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: menus.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 14,
            mainAxisSpacing: 14,
            childAspectRatio: width < 400 ? 0.57 : 0.68,
          ),
          itemBuilder: (context, index) {
            return _buildMenuCard(menus[index]);
          },
        );
      },
    );
  }

  Widget _buildMenuCard(MenuItem item) {
    return Card(
      color: kCard,
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: Color(0xFFECE7DC)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                item.imageAsset,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFFEAECE1),
                    child: const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: kForest,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Expanded(
                    child: Text(
                      item.description,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: kMuted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    formatRupiah(item.price),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: kOrange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => _openDetail(item),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: kForest,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 10,
                            ),
                            side: const BorderSide(color: kForest),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Detail',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        tooltip: 'Tambah ke keranjang',
                        onPressed: () => _addToCart(item),
                        style: IconButton.styleFrom(
                          backgroundColor: kForest,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          size: 19,
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

  Widget _buildBottomNavigation() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFECE7DC)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(
            icon: Icons.home_rounded,
            label: 'Beranda',
            selected: _selectedNavIndex == 0,
            onTap: _goToHome,
          ),
          _buildNavItem(
            icon: Icons.restaurant_menu,
            label: 'Menu',
            selected: _selectedNavIndex == 1,
            onTap: _goToMenu,
          ),
          _buildNavItem(
            icon: Icons.receipt_long,
            label: 'Pesanan',
            selected: _selectedNavIndex == 2,
            onTap: _goToOrders,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 70,
              height: 38,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFDCE9DF)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Icon(
                icon,
                color: selected
                    ? kForestDark
                    : const Color(0xFF414B44),
                size: 25,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: selected ? kText : const Color(0xFF414B44),
                fontWeight:
                    selected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}