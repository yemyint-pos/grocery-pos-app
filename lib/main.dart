import 'package:flutter/material.dart';

void main() {
  runApp(const GroceryPOS());
}

class GroceryPOS extends StatelessWidget {
  const GroceryPOS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery POS',
      theme: ThemeData(
        colorSchemeSeed: Colors.green,
        useMaterial3: true,
      ),
      home: const POSHome(),
    );
  }
}

class POSHome extends StatefulWidget {
  const POSHome({super.key});

  @override
  State<POSHome> createState() => _POSHomeState();
}

class _POSHomeState extends State<POSHome> {
  final List<Map<String, dynamic>> cart = [];

  int get total => cart.fold(
    0,
    (sum, item) =>
        sum + (item['price'] as int) * (item['qty'] as int),
  );

  void addItem(String name, int price) {
    setState(() {
      final index = cart.indexWhere(
        (item) => item['name'] == name,
      );

      if (index >= 0) {
        cart[index]['qty']++;
      } else {
        cart.add({
          'name': name,
          'price': price,
          'qty': 1,
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GROCERY POS'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'အရောင်းဘောင်ချာ',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: cart.isEmpty
                ? const Center(
                    child: Text('ပစ္စည်း မထည့်ရသေးပါ'),
                  )
                : ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return ListTile(
                        title: Text(item['name']),
                        subtitle: Text(
                          '${item['price']} Ks',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('x ${item['qty']}'),
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  item['qty']--;
                                  if (item['qty'] <= 0) {
                                    cart.removeAt(index);
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'TOTAL',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$total Ks',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addItem('ဆန်', 5000);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
