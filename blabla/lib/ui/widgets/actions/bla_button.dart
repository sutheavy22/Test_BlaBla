import 'package:flutter/material.dart';

import '../../theme/theme.dart';

enum BlaButtonType { primary, secondary }

class BlaButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final BlaButtonType type;
  final IconData? icon;

  const BlaButton({
    super.key,
    required this.label,
    this.onPressed,
    this.type = BlaButtonType.primary,
    this.icon,
  });

  Color get background {
    if (onPressed == null) return BlaColors.disabled;
    return type == BlaButtonType.primary
        ? BlaColors.primary
        : BlaColors.backgroundAccent;
  }

  Color get textColor {
    return type == BlaButtonType.primary ? Colors.white : BlaColors.textNormal;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(BlaSpacings.radius),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) Icon(icon, color: textColor, size: 18),
            if (icon != null) const SizedBox(width: 8),
            Text(label, style: BlaTextStyles.button.copyWith(color: textColor)),
          ],
        ),
      ),
    );
  }
}
