// lib/presentation/screens/closet/add_item_screen.dart

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/models/clothing_item.dart';
import '../../providers/database_provider.dart';

const _categoryEmojis = {
  'Tops': '👕',
  'Bottoms': '👖',
  'Shoes': '👟',
  'Bags': '👜',
  'Accessories': '📿',
  'Outerwear': '🧥',
};

class AddItemScreen extends ConsumerStatefulWidget {
  const AddItemScreen({super.key});
  @override
  ConsumerState<AddItemScreen> createState() => _AddItemScreenState();
}

class _AddItemScreenState extends ConsumerState<AddItemScreen> {
  final _nameCtrl = TextEditingController();
  final _notesCtrl = TextEditingController();
  String _category = 'Tops';
  String _season = 'All';
  String _color = 'White';
  String? _imagePath;
  bool _saving = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.gallery);
    if (img != null) setState(() => _imagePath = img.path);
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Введи название вещи'),
            backgroundColor: Colors.redAccent),
      );
      return;
    }
    setState(() => _saving = true);
    final item = ClothingItem(
      id: const Uuid().v4(),
      name: _nameCtrl.text.trim(),
      category: _category,
      color: _color,
      season: _season,
      imagePath: _imagePath,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      emoji: _categoryEmojis[_category] ?? '👕',
    );
    await ref.read(clothingRepositoryProvider).addItem(item);
    if (mounted) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Item saved! ✨'),
            backgroundColor: Color(0xFF8B7BA8)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Add New Item'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo picker
            Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EBF5),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: const Color(0xFFB8A9C9).withAlpha((0.4 * 255).round())),
                  ),
                  child: _imagePath != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(File(_imagePath!),
                              fit: BoxFit.cover))
                      : const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_photo_alternate_outlined,
                                color: Color(0xFFB8A9C9), size: 36),
                            SizedBox(height: 8),
                            Text('Add Photo',
                                style: TextStyle(
                                    color: Color(0xFFB8A9C9),
                                    fontSize: 13)),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _label('Name'),
            _field(
                hint: 'e.g. White Linen Shirt',
                controller: _nameCtrl),
            const SizedBox(height: 16),

            _label('Category'),
            _dropdown(
              value: _category,
              items: _categoryEmojis.keys.toList(),
              onChanged: (v) =>
                  setState(() => _category = v ?? _category),
            ),
            const SizedBox(height: 16),

            _label('Season'),
            _dropdown(
              value: _season,
              items: ['All', 'Spring', 'Summer', 'Fall', 'Winter'],
              onChanged: (v) => setState(() => _season = v ?? _season),
            ),
            const SizedBox(height: 16),

            _label('Color'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                'White', 'Black', 'Beige', 'Blue', 'Pink',
                'Green', 'Red', 'Yellow', 'Purple', 'Brown'
              ]
                  .map((c) => GestureDetector(
                        onTap: () => setState(() => _color = c),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: _color == c
                                ? const Color(0xFFB8A9C9)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: _color == c
                                    ? const Color(0xFFB8A9C9)
                                    : Colors.grey.shade200),
                          ),
                          child: Text(c,
                              style: TextStyle(
                                  color: _color == c
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 13)),
                        ),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),

            _label('Notes (optional)'),
            _field(
                hint: 'Any notes...',
                controller: _notesCtrl,
                maxLines: 3),
            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saving ? null : _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB8A9C9),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                            color: Colors.white, strokeWidth: 2))
                    : const Text('Save Item',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 14)),
      );

  Widget _field({
    required String hint,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade200)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFB8A9C9))),
      ),
    );
  }

  Widget _dropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: DropdownButton<String>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        items: items
            .map((i) => DropdownMenuItem(value: i, child: Text(i)))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

