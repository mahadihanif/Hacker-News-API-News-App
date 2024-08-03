import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
class UrlShow extends StatelessWidget {
  final String url;
  const UrlShow({super.key, required this.url});
  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return const Text('Url not found');
    } else
    final  urlString = Uri.parse(url);
      return Container(
        child: Text('link')
      );
  }
}
