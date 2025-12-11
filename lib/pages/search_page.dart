import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skycast/constants/app_constants.dart';
import 'package:skycast/constants/theme/app_theme.dart';
import 'package:skycast/providers/weather_provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // search function
  void _searchCity({required String query}) async {
    if (query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 2),
          content: Text('Please enter the city name'),
        ),
      );
      return;
    }
    final provider = context.read<WeatherProvider>();
    await provider.fetchCurrentWeather(cityName: query);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 233, 235, 239),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Image.asset(ImageConstant.cloudySunnyImage, height: 16),
        ),
        title: Text('SkyCast'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .start,
              spacing: 12,
              children: [
                SizedBox(height: 10),
                // search input field
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Search City...',
                  ),
                  onSubmitted: (value) {
                    _searchCity(query: value);
                  },
                ),
                SizedBox(height: 10),

                // Search history section
                Text(
                  'Recent Searches',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                SizedBox(
                  height: 200,
                  child: _buildSearchHistoryList(context: context),
                ),

                // Suggested section
                Text(
                  'Suggested Cities',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),

                _buildNavigationTile(
                  placeTitle: 'Paris',
                  placeSubtitle: "France",
                  navigate: () {
                    // later we will implement
                    _searchCity(query: "France");
                  },
                ),
                _buildNavigationTile(
                  placeTitle: 'Sydney',
                  placeSubtitle: "Australia",
                  navigate: () {
                    _searchCity(query: "Australia");
                  },
                ),
                _buildNavigationTile(
                  placeTitle: 'Dubai',
                  placeSubtitle: "United Arab Emirates",
                  navigate: () {
                    _searchCity(query: "United Arab Emirates");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // search history list
  Widget _buildSearchHistoryList({required BuildContext context}) {
    final provider = context.read<WeatherProvider>();
    final historyData = provider.searchHistoryList;
    return ListView.builder(
      itemCount: historyData.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildNavigationTile(
            isSearching: true,
            placeTitle: historyData[index],
            navigate: () {
              _searchCity(query: historyData[index]);
            },
          ),
        );
      },
    );
  }

  // navigation tile
  Widget _buildNavigationTile({
    required String placeTitle,
    String? placeSubtitle,
    required void Function()? navigate,
    bool isSearching = false,
  }) {
    return GestureDetector(
      onTap: navigate,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        leading: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: AppTheme.lightBlue.withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(isSearching ? Icons.history : Icons.location_on_outlined),
        ),
        title: Text(placeTitle, style: Theme.of(context).textTheme.titleSmall),
        subtitle: isSearching
            ? null
            : Text(
                placeSubtitle!,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge!.copyWith(color: AppTheme.primaryBlue),
              ),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
      ),
    );
  }
}
