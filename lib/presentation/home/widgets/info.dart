 import 'package:flutter/material.dart';

void showCompanyInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Company Info'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Company: Geeksynergy Technologies Pvt Ltd'),
              SizedBox(height: 8.0),
              Text('Address: Sanjayanagar, Bengaluru-56'),
              SizedBox(height: 8.0),
              Text('Phone: XXXXXXXXX09'),
              SizedBox(height: 8.0),
              Text('Email: XXXXXX@gmail.com'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
