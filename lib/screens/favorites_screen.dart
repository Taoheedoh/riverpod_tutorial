import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/screens/detail_screen.dart';
import 'package:riverpod_tutorial/src/providers/color_list_provider.dart';
import 'package:riverpod_tutorial/src/providers/favourite_colors_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Tutorial', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      body: Consumer(
        builder: (context, ref, _) {
          final provider = ref.read(colorListProvider.notifier);
          final colors = ref.watch(favoriteColorsProvider);
          if (colors.isEmpty) {
            return Center(child: Text("No Favorites"),);
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
