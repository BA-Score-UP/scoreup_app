# ScoreUP Flutter APP

## Main libraries used

## Folder structure

```tree
lib/
├─── models/
├─── pages/
├─── services/
├─── styles/
├─── utils/
└─── widgets/
main.dart
pubspec.yaml
```

* models/ - contains the data models used in the app.
* pages/ - contains the pages of the app.
* services/ - contains the services used to interact with external data sources, fetching and processing data.
* styles/ - contains constant styles.
* utils/ - contains methods that are used throughout the app.
* widgets/ - contains reusable widgets that can be used across multiple screens.
* main.dart - the entry point of the app, containing the main() function. This is where routes are set and app-level settings such as themes and locale are defined.
* pubspec.yaml - contains metadata about the project and the required dependencies.

## Running

⚠️ Don't clone in a folder with spaces ⚠️

1. Clone the repository: ```git clone https://github.com/BA-Score-UP/scoreup-app.git```
2. Install flutter dependencies: ```flutter pub get```
3. Install windows debug dependencies: ```flutter create --platforms=windows .```
4. Run the app in development mode: ```flutter run -d windows```
