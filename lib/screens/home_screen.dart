import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_tutorial/src/providers/color_list_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
