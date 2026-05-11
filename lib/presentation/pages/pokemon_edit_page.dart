import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/pokemon_card.dart';
import '../viewmodels/pokemon_viewmodel.dart';

class PokemonEditPage extends StatefulWidget {
  final PokemonCardEntity pokemon;
  final PokemonViewModel viewModel;

  const PokemonEditPage({
    super.key,
    required this.pokemon,
    required this.viewModel,
  });

  @override
  State<PokemonEditPage> createState() => _PokemonEditPageState();
}

class _PokemonEditPageState extends State<PokemonEditPage> {
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _secondTypeController;
  late String _imagePath;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.pokemon.name);
    _typeController = TextEditingController(text: widget.pokemon.type);
    _secondTypeController = TextEditingController(text: widget.pokemon.secondType);
    _imagePath = widget.pokemon.imageUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _secondTypeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      final updatedPokemon = PokemonCardEntity(
        id: widget.pokemon.id,
        name: _nameController.text,
        type: _typeController.text,
        secondType: _secondTypeController.text,
        imageUrl: _imagePath,
      );
      widget.viewModel.addCard(updatedPokemon);
      Navigator.of(context).pop(updatedPokemon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Editar ${widget.pokemon.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _save,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Introdueix un nom' : null,
              ),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(labelText: 'Tipus 1'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Introdueix un tipus' : null,
              ),
              TextFormField(
                controller: _secondTypeController,
                decoration: const InputDecoration(labelText: 'Tipus 2'),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: _pickImage,
                child: Image.file(
                  File(_imagePath),
                  height: 200,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 100),
                ),
              ),
              TextButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.photo_library),
                label: const Text('Canviar imatge'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}