import 'package:flutter/material.dart';
import 'package:tugas_api/detailscreen.dart';
import 'package:tugas_api/models/usermodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = []; // Ubah nama variabel menjadi users

  @override
  void initState() {
    super.initState();
    // Memanggil metode callApi saat initState dipanggil
    _fetchUser();
  }

  Future<void> _fetchUser() async {
    // Memanggil metode callApi dari UserModel untuk mendapatkan data pengguna
    List<User> fetchedUsers = await User.callApi(); // Ubah nama variabel menjadi fetchedUsers
    // Mengubah state widget dengan data pengguna yang baru
    setState(() {
      users = fetchedUsers; // Ubah nama variabel menjadi users
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // Jika data pengguna belum diambil, tampilkan indikator loading
    if (users == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      // Jika data pengguna tersedia, tampilkan dalam bentuk grid view
      return GridView.count(
        crossAxisCount: 2, // Jumlah kolom dalam grid
        children: users.map((user) => _buildUserItem(user)).toList(), // Memetakan setiap objek User dalam list users menjadi widget _buildUserItem
      );
    }
  }

  Widget _buildUserItem(User user) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailUserScreen(user: user),
        ),
      );
    },
    child: Card(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.network(
        "https://randomuser.me/api/portraits/thumb/women/73.jpg",
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
      Text(
        'Username: ${user.id}',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(
        'Name: ${user.name}',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  ),
),

  );
}

}
