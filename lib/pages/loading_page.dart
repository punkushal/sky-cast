import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/constants/app_constants.dart';
import 'package:skycast/constants/theme/app_theme.dart';
import 'package:skycast/pages/home_page.dart';
import 'package:skycast/providers/weather_provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  // to track navigation
  bool _hasNavigated = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchCurrentData();
    });
  }

  Future<void> _fetchCurrentData() async {
    final provider = context.read<WeatherProvider>();
    await provider.fetchCurrentWeather(cityName: 'Butwal');
    await provider.fetchHourlyForecast(cityName: 'Butwal');
    if (mounted && !_hasNavigated) {
      _hasNavigated = true;
      if (provider.currentWeather != null && provider.errorMessage.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Text(provider.errorMessage),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppTheme.splashGradient),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            Spacer(),
            Image.asset(ImageConstant.cloudySunnyImage, height: 80),
            Text(
              'Sky Cast',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: AppTheme.backgroundColor,
              ),
            ),
            Spacer(),
            // loading text + loading indicator
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 110),
              child: Consumer<WeatherProvider>(
                builder: (context, provider, child) {
                  return Column(
                    spacing: 4,
                    children: [
                      Text(
                        'Fetching your weather...',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppTheme.backgroundColor,
                        ),
                      ),
                      LinearProgressIndicator(
                        minHeight: 6,
                        value: provider.loadingProgress,
                        backgroundColor: const Color.fromARGB(
                          238,
                          157,
                          117,
                          244,
                        ).withValues(alpha: 0.6),
                        valueColor: AlwaysStoppedAnimation(
                          AppTheme.backgroundColor,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      Text(
                        '${(provider.loadingProgress * 100).toInt()}%',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppTheme.backgroundColor,
                        ),
                      ),

                      SizedBox(height: 120),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
