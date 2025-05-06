import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hirup_aing/constants/feature_constant.dart';
import 'package:hirup_aing/data/models/user_model.dart';
import 'package:hirup_aing/data/providers/auth_provider.dart';
import 'package:hirup_aing/screens/home/home_screen.dart';
import 'package:hirup_aing/screens/home/widgets/feature_grid_widget.dart';
import 'package:hirup_aing/widgets/gradien_layout_widget.dart';

class SemuaFiturScreen extends ConsumerWidget {
  const SemuaFiturScreen({super.key});
  static const routeName = '/semua-fitur';

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: GradienLayoutWidget(),
        title: const Text('Semua Fitur'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.push(HomeScreen.routeName),
        ),
      ),
      body: GradienLayoutWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Text(
                  'Fitur-fitur yang tersedia',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 20),
                FeatureGridWidget(
                  features: getFeatureList(
                    ref.read(authProvider).user?.role ?? UserRole.user,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
