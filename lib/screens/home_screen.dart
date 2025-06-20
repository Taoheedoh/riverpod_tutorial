import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/screens/detail_screen.dart';
import 'package:riverpod_tutorial/screens/favorites_screen.dart';
import 'package:riverpod_tutorial/src/providers/color_list_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Tutorial', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => FavoritesScreen()));
            },
            icon: Icon(Icons.favorite_border),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      body: Consumer(
        builder: (context, ref, _) {
          final provider = ref.read(colorListProvider.notifier);
          final colors = ref.watch(colorListProvider);
          if (colors.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: () => provider.refresh(),
            child: ListView.builder(
              itemCount: colors.length,
              itemBuilder: (context, index) {
                final color = colors[index];

                return Card(
                  child: ListTile(
                    leading: Container(
                      color: color.color,
                      width: 32.0,
                      height: 32.0,
                    ),
                    title: Text(color.title),
                    trailing: IconButton(
                      onPressed: () {
                        provider.like(color.id, !color.isLiked);
                      },
                      icon: Icon(
                        color.isLiked ? Icons.favorite : Icons.favorite_border,
                      ),
                    ),

                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(hexcode: color.hexCode),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
