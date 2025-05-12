import 'package:flutter/material.dart';

enum CategoryType {
  work,
  personal,
  study,
  health,
  other,
}

extension CategoryTypeExtension on CategoryType {
  String get label {
    switch (this) {
      case CategoryType.work:
        return 'Work';
      case CategoryType.personal:
        return 'Personal';
      case CategoryType.study:
        return 'Study';
      case CategoryType.health:
        return 'Health';
      case CategoryType.other:
        return 'Other';
    }
  }
}
class DropdownMenuItems extends StatefulWidget {
  const DropdownMenuItems({super.key});

  @override
  State<DropdownMenuItems> createState() => _DropdownMenuItemsState();}
  
  class _DropdownMenuItemsState extends State<DropdownMenuItems> {
    final TextEditingController _controller = TextEditingController();
    
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
    
  }

