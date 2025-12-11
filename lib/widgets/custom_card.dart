import 'package:flutter/material.dart';
import 'package:skycast/constants/theme/app_theme.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.temp,
    required this.weatherType,
    required this.iconPath,
  });
  // icon path
  final String iconPath;
  // current temperature
  final String temp;
  // current weather label
  final String weatherType;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: screenWidth * 0.94,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.veryLightBlue,
        boxShadow: AppTheme.cardShadow,
      ),
      child: Column(
        mainAxisAlignment: .center,
        children: [
          Image.network(
            "https://openweathermap.org/img/wn/$iconPath@2x.png",
            height: 70,
          ),
          Text('$temp°', style: Theme.of(context).textTheme.displaySmall),
          Text(weatherType, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
