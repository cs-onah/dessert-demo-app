import 'package:flutter/material.dart';

class BaseStateWidget extends StatelessWidget {
  final dynamic message;

  /// if not [isEmpty], then isError
  final bool isEmpty;
  const BaseStateWidget({super.key, this.message, this.isEmpty = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Row(), // stretches column horizontally
        Icon(
          isEmpty ? Icons.search_off : Icons.wifi_tethering_error,
          size: 200,
          color: Colors.grey[700],
        ),
        const SizedBox(height: 20),
        Text(
          message?.toString() ?? "Nothing to see here",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
