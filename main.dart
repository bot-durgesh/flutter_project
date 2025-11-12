import 'package:flutter/material.dart';

void main() {
  runApp(const BlinkitApp());
}

class BlinkitApp extends StatelessWidget {
  const BlinkitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blinkit',
      theme: ThemeData(
        primaryColor: const Color(0xFFE8F5E9),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        fontFamily: 'Inter',
        badgeTheme: const BadgeThemeData(
          backgroundColor: Color(0xFFE23744),
          textColor: Colors.white,
        ),
      ),
      home: const NavigationPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

final List<Map<String, dynamic>> categories = [
  {'name': 'Vegetables & Fruits', 'icon': '🥬', 'color': Color(0xFFF8E8EE)},
  {'name': 'Dairy & Breakfast', 'icon': '🥛', 'color': Color(0xFFFFF9E6)},
  {'name': 'Munchies', 'icon': '🍿', 'color': Color(0xFFE8F5E9)},
  {'name': 'Cold Drinks', 'icon': '🥤', 'color': Color(0xFFE3F2FD)},
  {'name': 'Instant & Frozen', 'icon': '🍕', 'color': Color(0xFFFCE4EC)},
  {'name': 'Tea & Coffee', 'icon': '☕', 'color': Color(0xFFEDE7F6)},
  {'name': 'Bakery & Biscuits', 'icon': '🍪', 'color': Color(0xFFFFF3E0)},
  {'name': 'Sweet Tooth', 'icon': '🍫', 'color': Color(0xFFF3E5F5)},
];

final List<Map<String, dynamic>> products = [
  {
    'name': 'Tomato',
    'weight': '500 g',
    'price': 18,
    'originalPrice': 25,
    'image': 'https://placehold.co/200x200/FF6347/FFFFFF?text=🍅'
  },
  {
    'name': 'Amul Gold Milk',
    'weight': '500 ml',
    'price': 31,
    'originalPrice': null,
    'image': 'https://placehold.co/200x200/4A90E2/FFFFFF?text=🥛'
  },
  {
    'name': 'Harvest Gold Bread',
    'weight': '400 g',
    'price': 42,
    'originalPrice': 50,
    'image': 'https://placehold.co/200x200/D2691E/FFFFFF?text=🍞'
  },
  {
    'name': 'Lay\'s Chips',
    'weight': '90 g',
    'price': 20,
    'originalPrice': null,
    'image': 'https://placehold.co/200x200/FFD700/FFFFFF?text=🥔'
  },
  {
    'name': 'Shimla Apple',
    'weight': '4 pcs',
    'price': 185,
    'originalPrice': 210,
    'image': 'https://placehold.co/200x200/DC143C/FFFFFF?text=🍎'
  },
  {
    'name': 'Fresh Paneer',
    'weight': '200 g',
    'price': 80,
    'originalPrice': null,
    'image': 'https://placehold.co/200x200/F5DEB3/FFFFFF?text=🧀'
  },
  {
    'name': 'Britannia Cookies',
    'weight': '120 g',
    'price': 30,
    'originalPrice': 35,
    'image': 'https://placehold.co/200x200/8B4513/FFFFFF?text=🍪'
  },
  {
    'name': 'Coca Cola',
    'weight': '750 ml',
    'price': 40,
    'originalPrice': null,
    'image': 'https://placehold.co/200x200/E32636/FFFFFF?text=🥤'
  },
];

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  final Map<String, int> _cartQuantities = {};
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _displayedProducts = [];

  @override
  void initState() {
    super.initState();
    _displayedProducts = List.from(products);
    _searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _displayedProducts = List.from(products);
      } else {
        _displayedProducts = products.where((p) {
          return p['name'].toLowerCase().contains(query);
        }).toList();
      }
    });
  }

  void _updateCart(String productName, int quantity) {
    setState(() {
      if (quantity <= 0) {
        _cartQuantities.remove(productName);
      } else {
        _cartQuantities[productName] = quantity;
      }
    });
  }

  int _calculateTotalCartItems() {
    int total = 0;
    _cartQuantities.forEach((key, value) {
      total += value;
    });
    return total;
  }

  int _calculateTotalPrice() {
    int total = 0;
    _cartQuantities.forEach((productName, quantity) {
      final product = products.firstWhere((p) => p['name'] == productName);
      total += (product['price'] as int) * quantity;
    });
    return total;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return _buildHomePageContent();
      case 2:
        return _buildCartPageContent();
      case 1:
        return const Center(
            child: Text('Categories',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
      case 3:
        return const Center(
            child: Text('Account',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
      default:
        return _buildHomePageContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final int totalCartItems = _calculateTotalCartItems();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 120,
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Center(
            child: Text(
              'blinkit',
              style: TextStyle(
                color: Color(0xFF0C831F),
                fontWeight: FontWeight.bold,
                fontSize: 28,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFF0F0F0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Delivery in ',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Text(
                '8 minutes',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down,
                  color: Colors.black87, size: 18),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_outline, color: Colors.black87),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            color: Colors.grey[200],
            height: 1,
          ),
        ),
      ),
      body: _buildPage(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            const BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined),
              activeIcon: Icon(Icons.grid_view),
              label: 'Categories',
            ),
            BottomNavigationBarItem(
              icon: Badge(
                label: Text('$totalCartItems'),
                isLabelVisible: totalCartItems > 0,
                child: const Icon(Icons.shopping_bag_outlined),
              ),
              activeIcon: Badge(
                label: Text('$totalCartItems'),
                isLabelVisible: totalCartItems > 0,
                child: const Icon(Icons.shopping_bag),
              ),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              activeIcon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: const Color(0xFF0C831F),
          unselectedItemColor: Colors.grey[600],
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildHomePageContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          _buildOfferBanner(),
          _buildSectionTitle('Shop by category'),
          _buildCategoryGrid(),
          _buildSectionTitle(
              _searchController.text.isEmpty ? 'Best sellers' : 'Search Results'),
          _buildProductGrid(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search for products...',
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
          prefixIcon: const Icon(Icons.search, color: Colors.grey, size: 22),
          filled: true,
          fillColor: const Color(0xFFF0F0F0),
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
        ),
      ),
    );
  }

  Widget _buildOfferBanner() {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0C831F), Color(0xFF0FA72F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'GET 50% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'On your first order',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Shop Now',
                    style: TextStyle(
                      color: Color(0xFF0C831F),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return SizedBox(
      height: 110,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            width: 100,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            child: Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: category['color'],
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category['icon'],
                      style: const TextStyle(fontSize: 36),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      category['name'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    if (_displayedProducts.isEmpty && _searchController.text.isNotEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: [
              Icon(Icons.search_off, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text('No products found',
                  style: TextStyle(fontSize: 18, color: Colors.grey)),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12.0,
          crossAxisSpacing: 12.0,
          childAspectRatio: 0.68,
        ),
        itemCount: _displayedProducts.length,
        itemBuilder: (context, index) {
          final product = _displayedProducts[index];
          return _buildProductCard(product);
        },
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product) {
    final String productName = product['name'];
    final int quantity = _cartQuantities[productName] ?? 0;
    final int? originalPrice = product['originalPrice'];

    return Card(
      elevation: 0,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://api.codetabs.com/v1/proxy?quest=${product['image']}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[100],
                      child: const Center(
                          child: Icon(Icons.image_not_supported, size: 40)),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product['name'],
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              product['weight'],
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '₹${product['price']}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                if (originalPrice != null) ...[
                  const SizedBox(width: 6),
                  Text(
                    '₹$originalPrice',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 8),
            _buildAddButton(productName, quantity),
          ],
        ),
      ),
    );
  }

  Widget _buildCartPageContent() {
    final List<Map<String, dynamic>> cartItems =
        products.where((p) => (_cartQuantities[p['name']] ?? 0) > 0).toList();

    if (cartItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 100, color: Colors.grey[300]),
            const SizedBox(height: 20),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add items to get started',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    final int totalPrice = _calculateTotalPrice();

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final product = cartItems[index];
              final productName = product['name'];
              final quantity = _cartQuantities[productName]!;
              final price = product['price'] as int;

              return Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.grey[200]!, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://api.codetabs.com/v1/proxy?quest=${product['image']}',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              productName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              product['weight'],
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '₹${price * quantity}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0C831F),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _buildAddButton(productName, quantity),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -3),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '₹$totalPrice',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0C831F),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildAddButton(String productName, int quantity) {
    if (quantity == 0) {
      return SizedBox(
        height: 36,
        child: ElevatedButton(
          onPressed: () => _updateCart(productName, 1),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0C831F),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            elevation: 0,
          ),
          child: const Text(
            'ADD',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: 36,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF0C831F), width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => _updateCart(productName, quantity - 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: const Icon(
                  Icons.remove,
                  color: Color(0xFF0C831F),
                  size: 18,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '$quantity',
                style: const TextStyle(
                  color: Color(0xFF0C831F),
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            InkWell(
              onTap: () => _updateCart(productName, quantity + 1),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: const Icon(
                  Icons.add,
                  color: Color(0xFF0C831F),
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
