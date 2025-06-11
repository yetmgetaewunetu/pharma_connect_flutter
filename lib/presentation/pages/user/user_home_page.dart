import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/cart_page.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/join_us_page.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/search_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserHomePage extends ConsumerStatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends ConsumerState<UserHomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      // Home Page Content
      SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Find medicines',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
                decoration: InputDecoration(
                  hintText: 'Search for Medicine',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1; // Navigate to Search tab
                  });
                }),
            const SizedBox(height: 24),
            const Text(
              'Nearby pharmacies',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Theme.of(context).primaryColor),
                              SizedBox(width: 4),
                              Expanded(
                                child: Text('Pharma Connect',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text('gssh'),
                          Text('2.8 km'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Most Searched Medicines',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Text('Paracetamol'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Search Page Content
      const SearchPage(),
      // Cart Page Content
      const CartPage(),
      // Join Us page content
      const JoinUsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharma Connect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
        ],
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_add),
            label: 'Join Us',
          ),
        ],
      ),
    );
  }
}
