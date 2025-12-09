import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/constants/app_constants.dart';
import 'package:skycast/constants/theme/app_theme.dart';
import 'package:skycast/constants/utils/helper_function.dart';
import 'package:skycast/providers/weather_provider.dart';
import 'package:skycast/widgets/custom_card.dart';
import 'package:skycast/widgets/hourly_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final currentData = provider.currentWeather;
    return Scaffold(
      backgroundColor: AppTheme.lightBlue.withValues(alpha: 0.99),
      appBar: AppBar(
        title: Row(
          spacing: 4,
          children: [Icon(Icons.location_on_outlined), Text(currentData!.name)],
        ),
        actions: [
          // navigation to search page not implemented
          Icon(Icons.search),
          SizedBox(width: 16),
          Icon(Icons.menu),
          SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: .start,
            spacing: 10,
            children: [
              CustomCard(
                temp: kelvinToCelcius(currentData.main.temp),
                weatherType: currentData.weather[0].main,
              ),
              SizedBox(height: 10),
              Row(
                spacing: 8,
                children: [
                  _buildInfoCard(
                    context: context,
                    iconPath: ImageConstant.humidityImage,
                    infoLabel: "Humidity",
                    value: "${currentData.main.humidity}%",
                  ),
                  _buildInfoCard(
                    context: context,
                    iconPath: ImageConstant.windImage,
                    infoLabel: "Wind",
                    value: "${currentData.wind.speed} km/h",
                  ),
                ],
              ),

              Row(
                spacing: 8,
                children: [
                  _buildInfoCard(
                    context: context,
                    iconPath: ImageConstant.visibilityImage,
                    infoLabel: "Visibility",
                    // later we will implement if 5000 then 5km
                    // will displayed
                    value: "${currentData.visibility} km",
                  ),
                  _buildInfoCard(
                    context: context,
                    iconPath: ImageConstant.temperatureImage,
                    infoLabel: "Feels like",
                    value: "${kelvinToCelcius(currentData.main.feelsLike)}°",
                  ),
                ],
              ),

              Text('Hourly Forecast'),
              Expanded(child: HourlyList()),
            ],
          ),
        ),
      ),
    );
  }

  // info card
  Widget _buildInfoCard({
    required BuildContext context,
    required String iconPath,
    required String infoLabel,
    required String value,
  }) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Container(
      width: screenWidth * 0.44,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppTheme.veryLightBlue,
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: 10,
        children: [
          Row(
            spacing: 10,
            children: [
              Image.asset(iconPath, height: 20),
              Text(infoLabel, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          Text(value, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}
