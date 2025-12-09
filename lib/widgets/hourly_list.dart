import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:skycast/constants/theme/app_theme.dart';
import 'package:skycast/constants/utils/helper_function.dart';
import 'package:skycast/providers/weather_provider.dart';

class HourlyList extends StatelessWidget {
  const HourlyList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();
    final dataList = provider.hourlyDataList;
    return ListView.builder(
      scrollDirection: .horizontal,
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final data = dataList[index];
        final format = DateFormat("yyyy-MM-dd HH:mm:ss");
        DateTime dateTime = format.parse(data.dtTxt);
        String timeOnly = DateFormat("h a").format(dateTime);
        return Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 2),
          decoration: BoxDecoration(
            color: AppTheme.veryLightBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: .spaceAround,
            children: [
              Text(timeOnly),
              // icon will be displayed according to data
              Icon(Icons.cloud),
              Text('${kelvinToCelcius(data.main.temp)}°'),
            ],
          ),
        );
      },
    );
  }
}
