// import 'package:flutter/material.dart';

// class MenuDetailPage extends StatelessWidget {
//   const MenuDetailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kantin Bu Sari - Detail Menu'),
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
//                 'Detail Menu Pilihan',
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               const Text('Harga, deskripsi, dan gambar menu.'),
//               const SizedBox(height: 24),
//               ElevatedButton.icon(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/pesan');
//                 },
//                 icon: const Icon(Icons.shopping_cart),
//                 label: const Text('Pesan Sekarang'),
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
    final MenuItem item = argument is MenuItem ? argument : kantinMenus.first;
    final store = KantinStore.instance;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu', style: TextStyle(fontWeight: FontWeight.w800)),
        leading: IconButton(onPressed: () => Navigator.maybePop(context), icon: const Icon(Icons.arrow_back_rounded)),
        actions: [
          AnimatedBuilder(
            animation: store,
            builder: (context, _) => IconButton(
              tooltip: 'Favorit',
              onPressed: () => store.toggleFavorite(item.id),
              icon: Icon(store.favorites.contains(item.id) ? Icons.favorite : Icons.favorite_border, color: kOrange),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 800;
        final content = SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(wide ? 28 : 18, 10, wide ? 28 : 18, 28),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: AspectRatio(
                aspectRatio: wide ? 2.2 : 1.35,
                child: Image.asset(item.imageAsset, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(color: const Color(0xFFE7E1D4), child: const Icon(Icons.restaurant, color: kForest, size: 70))),
              ),
            ),
            const SizedBox(height: 22),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: const Color(0xFFE4EDE4), borderRadius: BorderRadius.circular(20)), child: Text(item.category, style: const TextStyle(color: kForest, fontWeight: FontWeight.w700, fontSize: 12))),
                const SizedBox(height: 10),
                Text(item.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800, color: kText)),
              ])),
              const SizedBox(width: 10),
              Text(formatRupiah(item.price), style: const TextStyle(fontSize: 20, color: kOrange, fontWeight: FontWeight.w800)),
            ]),
            const SizedBox(height: 12),
            const Row(children: [Icon(Icons.star_rounded, color: Color(0xFFF4B323), size: 20), SizedBox(width: 4), Text('Favorit pelanggan', style: TextStyle(fontSize: 12, color: kMuted, fontWeight: FontWeight.w600))]),
            const SizedBox(height: 12),
            Text(item.description, style: const TextStyle(fontSize: 14, height: 1.6, color: kMuted)),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                child: Row(children: [
                  const Expanded(child: Text('Jumlah pesanan', style: TextStyle(fontWeight: FontWeight.w700, color: kText))),
                  _quantityButton(Icons.remove, _quantity > 1 ? () => setState(() => _quantity--) : null),
                  SizedBox(width: 46, child: Center(child: Text('$_quantity', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800)))),
                  _quantityButton(Icons.add, () => setState(() => _quantity++), filled: true),
                ]),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Catatan untuk penjual', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: kText)),
            const SizedBox(height: 9),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: const InputDecoration(hintText: 'Contoh: tidak pedas, sambal dipisah, tanpa bawang...'),
            ),
            const SizedBox(height: 24),
            Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text('Total item ini', style: TextStyle(color: kMuted, fontSize: 12)),
                const SizedBox(height: 3),
                Text(formatRupiah(item.price * _quantity), style: const TextStyle(color: kForest, fontSize: 20, fontWeight: FontWeight.w800)),
              ])),
              Expanded(flex: 2, child: ElevatedButton.icon(
                onPressed: () {
                  store.add(item, _quantity);
                  Navigator.pushNamed(context, '/pesan', arguments: _noteController.text.trim());
                },
                icon: const Icon(Icons.shopping_bag_outlined),
                label: const Text('Tambah ke Pesanan'),
              )),
            ]),
          ]),
        );

        if (wide) {
          return Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 980), child: content));
        }
        return content;
      }),
    );
  }

  Widget _quantityButton(IconData icon, VoidCallback? onPressed, {bool filled = false}) {
    return SizedBox(
      width: 38,
      height: 38,
      child: IconButton(
        onPressed: onPressed,
        style: IconButton.styleFrom(
          backgroundColor: filled ? kOrange : const Color(0xFFF0E9DB),
          foregroundColor: filled ? Colors.white : kForest,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        ),
        icon: Icon(icon, size: 20),
      ),
    );
  }
}