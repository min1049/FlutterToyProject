import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShadowedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0, // Set card's elevation to 0 to remove default shadow
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'Shadowed Card',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}