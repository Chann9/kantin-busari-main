
import 'package:flutter/material.dart';

import '../main.dart';
import 'menu_list_page.dart';

class MenuDetailPage extends StatefulWidget {
  const MenuDetailPage({super.key});

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  int _quantity = 1;
  final TextEditingController _noteController = TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)?.settings.arguments;
    final MenuItem item =
        argument is MenuItem ? argument : kantinMenus.first;

    final store = KantinStore.instance;

    return Scaffold(
      backgroundColor: kCream,
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAECE1),
        foregroundColor: kForest,
        elevation: 0,
        title: const Text(
          'Detail Menu',
          style: TextStyle(fontWeight: FontWeight.w800),
        ),
        leading: IconButton(
          onPressed: () => Navigator.maybePop(context),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 800;

          final content = SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              wide ? 28 : 18,
              18,
              wide ? 28 : 18,
              28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: AspectRatio(
                    aspectRatio: wide ? 2.2 : 1.35,
                    child: Image.asset(
                      item.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFFE7E1D4),
                          child: const Center(
                            child: Icon(
                              Icons.restaurant,
                              color: kForest,
                              size: 70,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4EDE4),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.category,
                              style: const TextStyle(
                                color: kForest,
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: kText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      formatRupiah(item.price),
                      style: const TextStyle(
                        fontSize: 20,
                        color: kOrange,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Deskripsi tanpa label favorit atau pedas.
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.7,
                    color: kMuted,
                  ),
                ),

                const SizedBox(height: 24),

                Card(
                  color: kCard,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                    side: const BorderSide(
                      color: Color(0xFFECE7DC),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 13,
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'Jumlah pesanan',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: kText,
                            ),
                          ),
                        ),
                        _quantityButton(
                          Icons.remove,
                          _quantity > 1
                              ? () {
                                  setState(() {
                                    _quantity--;
                                  });
                                }
                              : null,
                        ),
                        SizedBox(
                          width: 46,
                          child: Center(
                            child: Text(
                              '$_quantity',
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w800,
                                color: kText,
                              ),
                            ),
                          ),
                        ),
                        _quantityButton(
                          Icons.add,
                          () {
                            setState(() {
                              _quantity++;
                            });
                          },
                          filled: true,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 22),

                const Text(
                  'Catatan untuk penjual',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: kText,
                  ),
                ),
                const SizedBox(height: 10),

                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText:
                        'Contoh: tidak pedas, sambal dipisah, tanpa bawang...',
                    hintStyle: const TextStyle(
                      color: kMuted,
                      fontSize: 13,
                    ),
                    filled: true,
                    fillColor: kCard,
                    contentPadding: const EdgeInsets.all(16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFE5DED0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFFE5DED0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: kForest,
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total item ini',
                            style: TextStyle(
                              color: kMuted,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            formatRupiah(item.price * _quantity),
                            style: const TextStyle(
                              color: kForest,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          for (int i = 0; i < _quantity; i++) {
                            store.add(item);
                          }

                          final note = _noteController.text.trim();

                          Navigator.pushNamed(
                            context,
                            '/pesan',
                            arguments: note,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kForest,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                        ),
                        label: const Text(
                          'Tambah ke Pesanan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

          if (wide) {
            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 980),
                child: content,
              ),
            );
          }

          return content;
        },
      ),
    );
  }

  Widget _quantityButton(
    IconData icon,
    VoidCallback? onPressed, {
    bool filled = false,
  }) {
    return SizedBox(
      width: 38,
      height: 38,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor:
              filled ? kOrange : const Color(0xFFF0E9DB),
          foregroundColor: filled ? Colors.white : kForest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        icon: Icon(icon, size: 20),
      ),
    );
  }
}