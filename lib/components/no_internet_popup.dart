import 'package:flutter/material.dart';

class NoInternetPopup {
  /// Display a popup at the top of the screen that auto-hides
  static void show(BuildContext context) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 0, // Directly at the top of the screen
          left: 0,
          right: 0,
          child: SafeArea(
            child: Material(
              color: Colors.transparent,
              child: Container(
                height: 20, // Reduced height for a smaller banner
                color: Colors.redAccent
                    .withOpacity(0.5), // Transparent red background
                alignment: Alignment.center,
                child: const Text(
                  'No Internet Connection',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14, // Smaller font size for compact appearance
                  ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        );
      },
    );

    // Add the overlay entry
    overlay.insert(overlayEntry);

    // Remove the popup after 1 second
    Future.delayed(const Duration(seconds: 1)).then((_) {
      overlayEntry.remove();
    });
  }
}
