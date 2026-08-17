# Third Eye Task Manager

## Description
A Flutter task management application developed as part of the Third Eye training task. It allows users to view, add, edit, and delete tasks, with features like searching by name, filtering by status and priority, and persisting user login state.

## How to Run
1. Ensure you have Flutter installed.
2. Clone this repository.
3. Run `flutter pub get` to install dependencies.
4. Run `flutter run` to launch the application.

## Technologies Used
* **Framework:** Flutter / Dart
* **State Management:** BLoC / Cubit (chosen for clean separation of business logic and UI).
* **API:** RESTful API integration using MockAPI (supports GET, POST, PUT, DELETE).
* **Local Storage:** `shared_preferences` for persisting the login state.