# Ashburn Data Valley

Ashburn Data Valley is a Flutter app that helps people in Ashburn, Virginia understand the data centers in their area. It shows where the facilities are, how they use electricity and water, what they bring to the community, and how internet traffic moves through them. The About dialog in the app says the goal is to help people understand the topic, not to take a side.

## What the app does

### Home screen

- A hero card titled "A Global Digital Hub" and four topic cards: **Data Centers**, **How It Works**, **Energy**, and **Community**.
- A "Did you know?" card with one of three facts, chosen at random each time the home screen opens. Its "Search for jobs" link opens an Indeed search for "data center" in Ashburn, VA in your browser.
- Five buttons: **View all data centers on map**, **Future data centers**, **Simulation**, **Make your own data center**, and **Sources**.
- An info button in the top bar opens the About dialog.

### Screens

- **Exploring Ashburn** (Data Centers card): quick facts about Ashburn and Loudoun County's "Data Center Alley", a list of planned projects with the status shown in the app, and a button to the full directory.
- **All Data Centers**: a searchable list of 108 facilities loaded from `assets/ashburn_data_centers.csv`. Search matches name, operator, address, and details. Tapping an entry shows its operator, address, and details. A button opens the public Ashburn listing on datacentermap.com.
- **How the Internet Works** (How It Works card): follows a request from your device through local networks and data centers to its destination, in four steps.
- **Power & Resources** (Energy card): explains how data centers depend on power, cooling, and network infrastructure. It includes a chart of electricity capacity connected (Dominion Energy), a chart of water use (Loudoun Water), and cards on noise and air pollution.
- **Community Impact** (Community card): covers jobs and workforce, benefits, and tradeoffs and risks, with the figures and sources stated in the app.
- **Data on Map**: a map of data centers within 25 km of Ashburn. It uses OpenStreetMap tiles, and the facility locations come from the OpenStreetMap database. The map falls back to the 15 built-in campuses if live data can't be loaded. Tapping a facility shows its details, along with the current temperature and air quality at that location. A refresh button reloads the data. Results are cached for 10 minutes.
- **Future Data Centers**: a map of six potential development sites, each with an estimated traffic range and peak hours. The app labels these as illustrative future development areas, not approved projects, and the traffic numbers as an illustrative planning estimate, not a traffic study.
- **Noise Simulation**: pick a distance from 0.05 to 2 miles from a facility and play a looping three-second sound. The app estimates the sound level from distance, using 85 dBA at 50 feet and dropping about 20 dB for each tenfold increase in distance. The sound is generated in the app, not recorded.
- **Make Your Own Data Center**: move sliders for capacity (10 to 200 MW), water use, pollution level, and cooling to see estimated electricity, homes powered, daily water use, and daily CO2 emissions. See [How the builder estimates work](#how-the-builder-estimates-work).
- **Sources**: lists where the app's data comes from. See [Data sources](#data-sources).

## How to use the app

1. Open the app and read the four topic cards on the home screen.
2. Use **All Data Centers** to search for a facility by name, operator, or address.
3. Use **Data on Map** to see facilities near Ashburn on a map. Tap a marker for details.
4. Use **Future Data Centers** and **Noise Simulation** to explore possible growth and how sound changes with distance.
5. Use **Make Your Own Data Center** to test how facility size, cooling, water use, and pollution change the estimates.
6. Check **Sources** before relying on any figure.

The map, weather, and air quality features need an internet connection. The built-in data still works without one.

## Getting started

Requirements:

- The Flutter SDK. The project requires Dart `^3.12.2` (see `pubspec.yaml`).
- An Android or iOS device or emulator, or another Flutter target.

Run the app:

```
flutter pub get
flutter run
```

Build a debug Android APK:

```
flutter build apk --debug
```

## Project structure

| Path | Purpose |
| --- | --- |
| `lib/main.dart` | Entry point. Starts `AshburnImpactApp`. |
| `lib/screens/home_screen.dart` | Home screen and all other screens and widgets. |
| `lib/data/datacenters_data.dart` | 15 built-in Ashburn-area data center campuses with approximate coordinates, operator, capacity, and cooling. |
| `assets/ashburn_data_centers.csv` | 108 facilities (name, address, operator, details) for the All Data Centers list. |
| `assets/ashburn_data_valley_icon.png` | Master app icon. |
| `test/widget_test.dart` | Widget tests. |

## How it was developed

- Built with Flutter and Dart, using Material 3 and a blue theme seeded from `#145DA0`.
- Packages used in the code:
  - `flutter_map` and `latlong2`: the interactive maps.
  - `http`: requests to the Overpass API (OpenStreetMap data) and to Open-Meteo (weather and air quality).
  - `url_launcher`: opens the jobs search and the public directory in the browser.
  - `audioplayers`: plays the noise simulation.
- Data comes from three places: the built-in list in `lib/data/datacenters_data.dart`, the CSV in `assets/`, and live OpenStreetMap and Open-Meteo responses. The app's Sources screen describes these.
- The app icon was made from a supplied logo and applied to the Android launcher (including an adaptive icon) and the iOS app icon set. The display name is "Ashburn Data Valley".

### How the builder estimates work

The **Make Your Own Data Center** screen uses fixed constants:

- Electricity per day (MWh) = capacity (MW) × cooling multiplier × 24
- Homes powered = capacity (MW) × 750
- Daily water use (gallons) = capacity (MW) × 12,000 × water multiplier
- Daily emissions (lbs CO2) = electricity (MWh) × 850 × pollution multiplier

The multipliers range from 0.5x to 2x for water and pollution, and from 0.7x to 1.5x for cooling.

## Data sources

The app's Sources screen lists:

- **OpenStreetMap**: data center locations and facility tags on the Data on Map screen.
- **Open-Meteo**: temperature and air quality (AQI, PM2.5, PM10) for facilities.
- **Loudoun County Government & Economic Development**: public information on data center growth, zoning, and "Data Center Alley" figures.
- **Industry and news reporting**: typical power draw, water use, land footprint, and noise levels used across the app.

Other sources named inside the app: LSARS (data centers in Loudoun County), Loudoun Water, and Dominion Energy.

The app states that its figures are approximate and meant for education.

## Testing

Run the widget tests with:

```
flutter test
```

`test/widget_test.dart` has four tests. Two currently fail:

- "Data centers opens the Ashburn details page" looks for the text `108 data centers from the CSV`, which the screen doesn't show.
- "community impact page includes community benefit contributors" looks for `Community benefit contributors` after tapping the COMMUNITY card, and that text isn't found there.

## Limitations

- Figures are approximate and for education only. See the Sources screen.
- The Future Data Centers sites and traffic numbers are illustrative, not approved projects or traffic studies.
- The builder uses fixed estimates, not measured data for any specific facility.
- Live map results depend on OpenStreetMap. When live data is missing, the map shows the 15 built-in campuses instead.

## Author

Created by Rohan Konduru.