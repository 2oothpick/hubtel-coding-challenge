import 'package:flutter/material.dart';
import 'dart:async'; // For simulating a delay

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transaction History',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TransactionHistoryPage(),
    );
  }
}

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({Key? key}) : super(key: key);

  @override
  _TransactionHistoryPageState createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  // Simulate network or data load delay
  void _simulateLoading() async {
    await Future.delayed(
        const Duration(seconds: 3)); // Simulating a 3-second load time
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loading spinner
          : _buildMainContent(), // Show main content after loading
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildMainContent() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              // Search bar and filter icon
              _buildSearchBar(),
              const SizedBox(height: 16),

              // History and Transaction Summary Tabs
              _buildTabHeader(),

              const SizedBox(height: 16),

              // Date label for the transactions
              const Text(
                'May 24, 2022',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),

              // Transaction Cards
              _buildTransactionCard(
                'Emmanuel Rockson Kwabena Uncle Ebo',
                '024 123 4567',
                'GHS 500',
                'Successful',
                Colors.greenAccent,
                true,
              ),
              const SizedBox(height: 10),
              _buildTransactionCard(
                'Absa Bank',
                '024 123 4567',
                'GHS 500',
                'Failed',
                Colors.redAccent,
                false,
              ),
              const SizedBox(height: 20),

              // Send New button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('SEND NEW'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    primary: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Search',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Icon(Icons.filter_list, color: Colors.grey),
      ],
    );
  }

  Widget _buildTabHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildTabButton('History', true),
        _buildTabButton('Transaction Summary', false),
      ],
    );
  }

  Widget _buildTabButton(String title, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }

  Widget _buildTransactionCard(String name, String phone, String amount,
      String status, Color statusColor, bool isFavorite) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.orange[200],
              child: Text(name[0],
                  style: const TextStyle(fontSize: 24, color: Colors.white)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(phone),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Personal',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Icon(Icons.circle,
                            size: 5, color: Colors.grey[600]),
                      ),
                      Text(
                        'Cool your heart wai',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      status == 'Successful'
                          ? Icons.check_circle
                          : Icons.cancel,
                      color: statusColor,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      status,
                      style: TextStyle(color: statusColor, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                if (isFavorite)
                  Icon(Icons.star, color: Colors.yellow[700], size: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.send),
          label: 'Send',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'Scheduled',
        ),
      ],
      selectedItemColor: Colors.teal,
    );
  }
}
