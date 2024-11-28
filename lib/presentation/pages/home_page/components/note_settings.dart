import 'package:flutter/material.dart';

class NoteSettings extends StatelessWidget {
  final VoidCallback onEditTap;
  final VoidCallback onDeleteTap;

  const NoteSettings({
    super.key,
    required this.onEditTap,
    required this.onDeleteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildOption(context, 'Edit', onEditTap),
        _buildOption(context, 'Delete', onDeleteTap),
      ],
    );
  }

  Widget _buildOption(BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop(); // Close the popover
        onTap();
      },
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
