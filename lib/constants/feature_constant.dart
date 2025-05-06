import 'package:hirup_aing/data/models/feature_item_model.dart';
import 'package:flutter/material.dart';
import 'package:hirup_aing/data/models/user_model.dart';

List<FeatureItemModel> featuresUser = [
  FeatureItemModel(
    icon: Icons.event_note,
    title: 'Aktivitas',
    color: Colors.blue,
    route: '',
  ),
];

List<FeatureItemModel> featuresAdmin = [
  FeatureItemModel(
    icon: Icons.dashboard,
    title: 'Dashboard',
    color: Colors.blue,
    route: '',
  ),
  FeatureItemModel(
    icon: Icons.people,
    title: 'Kelola User',
    color: Colors.green,
    route: '',
  ),
  FeatureItemModel(
    icon: Icons.event_note,
    title: 'Kelola Aktivitas',
    color: Colors.orange,
    route: '',
  ),
  FeatureItemModel(
    icon: Icons.groups,
    title: 'Kelola Kelompok',
    color: Colors.purple,
    route: '',
  ),
];

// Get feature list based on user role
List<FeatureItemModel> getFeatureList(UserRole role) {
  switch (role) {
    case UserRole.user:
      return featuresUser;
    case UserRole.admin:
      return featuresAdmin;
    }
}
