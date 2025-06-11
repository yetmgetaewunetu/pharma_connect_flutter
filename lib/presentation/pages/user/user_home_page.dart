import 'package:flutter/material.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/cart_page.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/join_us_page.dart';
import 'package:pharma_connect_flutter/presentation/pages/user/search_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pharma_connect_flutter/application/blocs/cart/cart_bloc.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({Key? key}) : super(key: key);

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = <Widget>[
      // User Home Page Content
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
            // TODO: Implement Nearby pharmacies list based on image 1
            SizedBox(
              height: 150, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 2, // Placeholder count
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: 150, // Adjust width as needed
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
                          Text('gssh'), // Placeholder
                          Text('2.8 km'), // Placeholder
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
            // TODO: Implement Most Searched Medicines list based on image 1
            SizedBox(
              height: 60, // Adjust height as needed
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Placeholder count
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(right: 16),
                    child: Container(
                      width: 150, // Increased width to allow more text
                      padding: const EdgeInsets.all(16),
                      alignment: Alignment.center,
                      child: Text('Paracetamol'), // Removed overflow handling
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Search Page Content (will be built in SearchPage file)
      const SearchPage(),
      // Cart Page Content (will be built in CartPage file)
      const CartPage(),
      // Join Us page content (will be built in JoinUsPage file)
      const JoinUsPage(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      BlocProvider.of<CartBloc>(context, listen: false)
          .add(const CartEvent.loadCart());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharma Connect'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // User profile icon
            onPressed: () {
              // TODO: Navigate to User Profile page
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
