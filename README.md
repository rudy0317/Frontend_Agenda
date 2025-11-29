
# Agenda Cyberpunk 🚀

A modern Flutter application for managing your agenda with a sleek cyberpunk-themed UI. This project demonstrates clean architecture principles, API integration, and state management in Flutter.

## 📋 Features

- ✨ **Cyberpunk UI Theme**: Dark mode with vibrant neon colors (magenta and cyan)
- 📝 **Create Agenda**: Add new agenda items with title and description
- 📋 **View Agenda**: Display all agenda items in a beautiful list
- ✏️ **Edit Agenda**: Modify existing agenda entries
- 🗑️ **Delete Agenda**: Remove agenda items
- 🌐 **API Integration**: RESTful API communication using Dio
- 🎨 **Custom Fonts**: Google Fonts (Orbitron) for cyberpunk aesthetic
- 📱 **Multi-Platform**: Supports Android, iOS, Web, Windows, macOS, and Linux

## 🏗️ Project Structure

```
lib/
├── main.dart              # Application entry point and theme configuration
├── agenda.dart            # Agenda model with JSON serialization
├── agenda_service.dart    # API service for CRUD operations
├── agenda_list.dart       # Main list view displaying all agenda items
├── agenda_form.dart       # Form for creating/editing agenda items
```

### File Descriptions

- **main.dart**: Sets up the MaterialApp with custom cyberpunk theme using Material Design 3
- **agenda.dart**: Defines the `Agenda` class with `fromJson()` and `toJson()` methods for API integration
- **agenda_service.dart**: Handles all HTTP requests to the backend API using Dio
- **agenda_list.dart**: Displays agenda items in a scrollable list with edit/delete options
- **agenda_form.dart**: Form interface for adding or editing agenda entries

## 🛠️ Tech Stack

- **Flutter**: 3.9.2+
- **Dart**: Latest version
- **Dependencies**:
  - `dio: ^5.7.0` - HTTP client for API requests
  - `google_fonts: ^6.2.1` - Google Fonts integration
  - `cupertino_icons: ^1.0.8` - iOS-style icons

## 🎨 Design Highlights

### Color Scheme
- **Primary**: `#FF00FF` (Magenta)
- **Secondary**: `#00E5FF` (Cyan)
- **Background**: `#050010` (Deep Purple)
- **Surface**: `#0B0018` (Dark Purple)

### Typography
- Font Family: **Orbitron** (Google Fonts)
- Bold headings for cyberpunk aesthetic
- Consistent text styling across the app

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.9.2 or higher
- Dart SDK
- Git

### Installation

1. **Clone the repository**
	```bash
	git clone https://github.com/rudy0317/Frontend_Agenda.git
	cd agenda_flutter
	```

2. **Install dependencies**
	```bash
	flutter pub get
	```

3. **Run the application**
	```bash
	# For Android/iOS
	flutter run

	# For Web
	flutter run -d chrome

	# For Windows
	flutter run -d windows
	```

## 📡 API Integration

The app communicates with a backend API for CRUD operations on agenda items.

### Agenda Model
```dart
class Agenda {
  final int? id;
  final String judul;      // Title
  final String keterangan; // Description
}
```

### API Endpoints

The `AgendaService` class handles:
- **GET** - Fetch all agenda items
- **POST** - Create new agenda
- **PUT/PATCH** - Update existing agenda
- **DELETE** - Remove agenda item

## 🎯 Key Features Explained

### 1. Cyberpunk Theme
The app uses a dark theme with vibrant neon colors and custom Material Design 3 styling for an immersive cyberpunk experience.

### 2. API Service Layer
All API calls are managed through `AgendaService`, providing a clean separation between UI and business logic.

### 3. Form Validation
The agenda form includes validation for required fields before submission.

### 4. Responsive Design
The UI adapts to different screen sizes and orientations.

## 📝 Usage

1. **Create Agenda**: Click the floating action button to add a new agenda item
2. **View Details**: Tap on an agenda to view its full details
3. **Edit**: Use the edit button to modify an existing agenda
4. **Delete**: Use the delete button to remove an agenda from the list

## 🔧 Development

### Folder Structure
- `android/` - Android native code
- `ios/` - iOS native code
- `lib/` - Dart source code
- `test/` - Unit and widget tests
- `web/` - Web platform files
- `windows/` - Windows platform files
- `macos/` - macOS platform files
- `linux/` - Linux platform files

### Building for Production

```bash
# Android
flutter build apk

# iOS
flutter build ios

# Web
flutter build web

# Windows
flutter build windows
```

## 📚 Learning Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Language](https://dart.dev/)
- [Material Design 3](https://m3.material.io/)
- [Dio Package](https://pub.dev/packages/dio)

## 👨‍💻 Author

**Rudy** - [GitHub](https://github.com/rudy0317)

## 📄 License

This project is open source and available under the MIT License.

## 🤝 Contributing

Contributions are welcome! Feel free to submit issues and pull requests to help improve the project.

## 📞 Support

For support, please open an issue in the GitHub repository.

---

**Happy Coding! 🚀✨**

