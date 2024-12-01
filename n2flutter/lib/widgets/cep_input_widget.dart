import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class CepInputWidget extends StatelessWidget {
  final MaskedTextController controller;

  const CepInputWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'CEP',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      maxLength: 10,
    );
  }
}