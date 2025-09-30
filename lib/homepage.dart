// lib/pages/home_page.dart
import 'package:flutter/material.dart';
import 'productcard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Sample products
  final List<Map<String, dynamic>> products = List.generate(
    6,
    (i) => {
      'id': i,
      'title': 'Product ${i + 1}',
      'imageUrl': 'https://picsum.photos/seed/product$i/400/300',
      'description': 'Nice product number ${i + 1}.',
      'price': 10.0 + i,
    },
  );

  final List<Map<String, dynamic>> featured = List.generate(
    3,
    (i) => {
      'id': 100 + i,
      'title': 'Featured ${i + 1}',
      'imageUrl': 'https://picsum.photos/seed/featured$i/800/400',
      'description': 'Featured item ${i + 1}',
      'price': 20 + i,
    },
  );

  final List<Map<String, String>> offers = List.generate(5, (i) {
    return {
      'image': 'https://picsum.photos/seed/offer$i/200/120',
      'desc': 'Hot offer ${i + 1}: Save up to ${10 + i * 5}%!',
    };
  });

  void _addToCart(Map<String, dynamic> p) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Item added to the cart')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Our Products'), centerTitle: true),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 500));
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Featured PageView
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: featured.length,
                  controller: PageController(viewportFraction: 0.9),
                  itemBuilder: (ctx, i) {
                    final f = featured[i];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 12,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(f['imageUrl'], fit: BoxFit.cover),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.all(12),
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.black26, Colors.black45],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Text(
                                f['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // GridView of products
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: products.length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4,
                  ),
                  itemBuilder: (ctx, i) {
                    final p = products[i];
                    return ProductCard(product: p, onAdd: () => _addToCart(p));
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Hot Offers
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: const [
                    Text(
                      'Hot Offers',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),

              SizedBox(
                height: 320,
                child: ListView.builder(
                  itemCount: offers.length,
                  itemBuilder: (ctx, i) {
                    final offer = offers[i];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      child: SizedBox(
                        height: 90,
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(8),
                              ),
                              child: Image.network(
                                offer['image']!,
                                width: 120,
                                height: 90,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  offer['desc']!,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
