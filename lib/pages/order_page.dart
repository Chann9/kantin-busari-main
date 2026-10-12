
import 'package:flutter/material.dart';

import '../main.dart';
import 'menu_list_page.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _noteController = TextEditingController();

  bool _needCutlery = true;
  bool _takeaway = false;
  bool _isCheckingOut = false;

  static const int _serviceFee = 2000;

  @override
  void dispose() {
    _nameController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _checkout(KantinStore store) async {
    if (_isCheckingOut || store.cart.isEmpty) return;

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isCheckingOut = true);

    final customerName = _nameController.text.trim();
    final note = _noteController.text.trim();
    final itemCount = store.itemCount;
    final subtotal = store.subtotal;
    final total = subtotal + _serviceFee;

    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: kCard,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          icon: const Icon(
            Icons.receipt_long_rounded,
            color: kForest,
            size: 42,
          ),
          title: const Text(
            'Konfirmasi Pesanan',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kForest,
              fontWeight: FontWeight.w800,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _summaryRow('Nama pemesan', customerName),
                const SizedBox(height: 10),
                _summaryRow('Jumlah item', '$itemCount item'),
                const SizedBox(height: 10),
                _summaryRow('Subtotal', formatRupiah(subtotal)),
                const SizedBox(height: 10),
                _summaryRow(
                  'Biaya layanan',
                  formatRupiah(_serviceFee),
                ),
                const Divider(height: 24),
                _summaryRow(
                  'Total pembayaran',
                  formatRupiah(total),
                  bold: true,
                ),
                const SizedBox(height: 16),

                // SATU-SATUNYA METODE PEMBAYARAN
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7EFE7),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.payments_outlined,
                        color: kForest,
                        size: 28,
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pembayaran Tunai',
                              style: TextStyle(
                                color: kForest,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Bayar langsung di kasir Kantin Bu Sari.',
                              style: TextStyle(
                                color: kMuted,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: kForest,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),
                _summaryRow(
                  'Pengambilan',
                  _takeaway ? 'Dibawa pulang' : 'Makan di tempat',
                ),
                const SizedBox(height: 8),
                _summaryRow(
                  'Alat makan',
                  _needCutlery ? 'Diperlukan' : 'Tidak diperlukan',
                ),
                if (note.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  _summaryRow('Catatan', note),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text(
                'Periksa Lagi',
                style: TextStyle(color: kMuted),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kForest,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Konfirmasi'),
            ),
          ],
        );
      },
    );

    if (!mounted) return;

    if (confirmed == true) {
      store.clearCart();
      _nameController.clear();
      _noteController.clear();

      setState(() {
        _needCutlery = true;
        _takeaway = false;
      });

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text(
              'Pesanan dikonfirmasi. Silakan bayar tunai di kasir.',
            ),
            duration: Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
    }

    if (mounted) {
      setState(() => _isCheckingOut = false);
    }
  }

  Widget _summaryRow(
    String label,
    String value, {
    bool bold = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              color: kMuted,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 13,
              color: kText,
              fontWeight: bold ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 30,
      height: 30,
      child: IconButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        style: IconButton.styleFrom(
          backgroundColor: const Color(0xFFE7EFE7),
          foregroundColor: kForest,
        ),
        icon: Icon(icon, size: 17),
      ),
    );
  }

  Widget _buildCartItem(CartEntry entry, KantinStore store) {
    final item = entry.item;

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                item.imageAsset,
                width: 86,
                height: 94,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 86,
                  height: 94,
                  color: const Color(0xFFE7E1D4),
                  child: const Icon(
                    Icons.restaurant,
                    color: kForest,
                    size: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kText,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.category,
                    style: const TextStyle(
                      fontSize: 11,
                      color: kMuted,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formatRupiah(item.price * entry.quantity),
                    style: const TextStyle(
                      fontSize: 13,
                      color: kOrange,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _quantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          store.setQuantity(
                            item.id,
                            entry.quantity - 1,
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Text(
                          '${entry.quantity}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: kText,
                          ),
                        ),
                      ),
                      _quantityButton(
                        icon: Icons.add,
                        onPressed: () {
                          store.setQuantity(
                            item.id,
                            entry.quantity + 1,
                          );
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        tooltip: 'Hapus menu',
                        visualDensity: VisualDensity.compact,
                        onPressed: () => store.remove(item.id),
                        icon: const Icon(
                          Icons.delete_outline,
                          color: kOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckoutForm(KantinStore store) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Pemesan',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
              labelText: 'Nama pemesan',
              hintText: 'Masukkan nama kamu',
              prefixIcon: Icon(Icons.person_outline),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Nama pemesan wajib diisi';
              }
              if (value.trim().length < 2) {
                return 'Nama minimal 2 karakter';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _noteController,
            textCapitalization: TextCapitalization.sentences,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Catatan pesanan (opsional)',
              hintText: 'Contoh: sambal dipisah',
              prefixIcon: Icon(Icons.edit_note),
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: kForest,
            value: _needCutlery,
            onChanged: (value) {
              setState(() => _needCutlery = value ?? false);
            },
            title: const Text(
              'Gunakan alat makan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: kText,
              ),
            ),
            subtitle: const Text(
              'Sendok dan garpu sekali pakai',
              style: TextStyle(fontSize: 11, color: kMuted),
            ),
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            activeTrackColor: kForest,
            value: _takeaway,
            onChanged: (value) {
              setState(() => _takeaway = value);
            },
            title: const Text(
              'Dibawa pulang',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: kText,
              ),
            ),
            subtitle: const Text(
              'Aktifkan jika pesanan ingin dibungkus',
              style: TextStyle(fontSize: 11, color: kMuted),
            ),
          ),
          const SizedBox(height: 14),

          // METODE PEMBAYARAN TUNAI SAJA
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xFFE7EFE7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFD3E2D5),
              ),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.payments_outlined,
                  color: kForest,
                  size: 30,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pembayaran Tunai',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: kForest,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Bayar langsung di kasir Kantin Bu Sari.',
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.4,
                          color: kMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: kForest,
                  size: 22,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Ringkasan Pembayaran',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: kForest,
            ),
          ),
          const SizedBox(height: 12),
          _summaryRow('Jumlah item', '${store.itemCount} item'),
          const SizedBox(height: 10),
          _summaryRow('Subtotal', formatRupiah(store.subtotal)),
          const SizedBox(height: 10),
          _summaryRow(
            'Biaya layanan',
            formatRupiah(_serviceFee),
          ),
          const Divider(height: 26),
          _summaryRow(
            'Total pembayaran',
            formatRupiah(store.subtotal + _serviceFee),
            bold: true,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isCheckingOut
                  ? null
                  : () => _checkout(store),
              style: ElevatedButton.styleFrom(
                backgroundColor: kOrange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.receipt_long_outlined),
              label: const Text('Konfirmasi Pesanan Tunai'),
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Pembayaran dilakukan langsung di kasir.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: kMuted),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 94,
              height: 94,
              decoration: BoxDecoration(
                color: const Color(0xFFE7EFE7),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                size: 48,
                color: kForest,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Keranjang masih kosong',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: kForest,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Yuk, pilih makanan, minuman, atau cemilan favoritmu.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: kMuted,
              ),
            ),
            const SizedBox(height: 22),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.restaurant_menu),
              label: const Text('Lihat Menu'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = KantinStore.instance;

    return AnimatedBuilder(
      animation: store,
      builder: (context, _) {
        final isEmpty = store.cart.isEmpty;

        return Scaffold(
          appBar: AppBar(
            title: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pesanan Saya',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: kForest,
                  ),
                ),
                Text(
                  'Periksa pesanan sebelum checkout',
                  style: TextStyle(fontSize: 11, color: kMuted),
                ),
              ],
            ),
            actions: [
              if (!isEmpty)
                TextButton.icon(
                  onPressed: () {
                    showDialog<void>(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        title: const Text('Kosongkan keranjang?'),
                        content: const Text(
                          'Semua menu dalam keranjang akan dihapus.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () =>
                                Navigator.pop(dialogContext),
                            child: const Text('Batal'),
                          ),
                          TextButton(
                            onPressed: () {
                              store.clearCart();
                              Navigator.pop(dialogContext);
                            },
                            child: const Text(
                              'Kosongkan',
                              style: TextStyle(color: kOrange),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    color: kOrange,
                  ),
                  label: const Text(
                    'Hapus semua',
                    style: TextStyle(color: kOrange),
                  ),
                ),
              const SizedBox(width: 8),
            ],
          ),
          body: isEmpty
              ? _buildEmptyCart()
              : LayoutBuilder(
                  builder: (context, constraints) {
                    final maxWidth = constraints.maxWidth > 900
                        ? 900.0
                        : constraints.maxWidth;

                    return Center(
                      child: SizedBox(
                        width: maxWidth,
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.fromLTRB(
                            18, 12, 18, 30,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: kForest,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.shopping_bag_outlined,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Keranjang Kamu',
                                            style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w800,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${store.itemCount} item dalam pesanan',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 18),
                              const Text(
                                'Daftar Menu',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  color: kForest,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...store.cart.values.map(
                                (entry) => Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 12,
                                  ),
                                  child: _buildCartItem(entry, store),
                                ),
                              ),
                              const SizedBox(height: 10),
                              _buildCheckoutForm(store),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}