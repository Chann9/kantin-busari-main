
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

  final TextEditingController _noteController =
      TextEditingController();

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _addToOrder(MenuItem item) {
    final store = KantinStore.instance;

    for (int i = 0; i < _quantity; i++) {
      store.add(item);
    }

    final note = _noteController.text.trim();

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            '${item.name} ditambahkan ke keranjang.',
          ),
          duration: const Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'Lihat Pesanan',
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/pesan',
                arguments: note,
              );
            },
          ),
        ),
      );

    Navigator.pushNamed(
      context,
      '/pesan',
      arguments: note,
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
          backgroundColor: filled
              ? kOrange
              : const Color(0xFFF0E9DB),
          foregroundColor:
              filled ? Colors.white : kForest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        icon: Icon(icon, size: 20),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final argument =
        ModalRoute.of(context)?.settings.arguments;

    final MenuItem item =
        argument is MenuItem ? argument : kantinMenus.first;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Menu',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 800;

          final content = SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              wide ? 28 : 18,
              10,
              wide ? 28 : 18,
              28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // GAMBAR MENU
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: AspectRatio(
                    aspectRatio: wide ? 2.2 : 1.35,
                    child: Image.asset(
                      item.imageAsset,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) {
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

                // NAMA DAN HARGA
                Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding:
                                const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4EDE4),
                              borderRadius:
                                  BorderRadius.circular(20),
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
                          const SizedBox(height: 10),
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

                // DESKRIPSI
                const Text(
                  'Deskripsi Menu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: kForest,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: kMuted,
                  ),
                ),

                const SizedBox(height: 24),

                // JUMLAH PESANAN
                Card(
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

                const SizedBox(height: 20),

                // CATATAN PESANAN
                const Text(
                  'Catatan untuk Penjual',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: kText,
                  ),
                ),
                const SizedBox(height: 9),
                TextField(
                  controller: _noteController,
                  maxLines: 3,
                  textCapitalization:
                      TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    hintText:
                        'Contoh: tidak pedas, sambal dipisah, tanpa bawang...',
                    alignLabelWithHint: true,
                  ),
                ),

                const SizedBox(height: 24),

                // TOTAL DAN TOMBOL PESAN
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total item ini',
                            style: TextStyle(
                              color: kMuted,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            formatRupiah(
                              item.price * _quantity,
                            ),
                            style: const TextStyle(
                              color: kForest,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: () => _addToOrder(item),
                        icon: const Icon(
                          Icons.shopping_bag_outlined,
                        ),
                        label: const Text(
                          'Tambah ke Pesanan',
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
                constraints: const BoxConstraints(
                  maxWidth: 980,
                ),
                child: content,
              ),
            );
          }

          return content;
        },
      ),
    );
  }
}