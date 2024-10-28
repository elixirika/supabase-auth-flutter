
# Flutter Authentication with Supabase

This is a Flutter application that integrates user authentication using Supabase. It leverages the Flutter Auth UI package, which contains pre-built widgets for authenticating users.

## Features

- **Pre-Built Authentication Widgets**: Easily integrate user authentication into your Flutter app with ready-to-use UI components.
- **Supabase Integration**: Seamlessly connect to Supabase for backend services.
- **Easy to Understand**: This project is designed to be beginner-friendly, following the official documentation from [Supabase](https://supabase.com/docs/guides/auth/auth-helpers/flutter-auth-ui).
- **Unstyled**: The application is intentionally left unstyled, allowing you to customize the UI to match your project's aesthetic.

## Getting Started

### Prerequisites

- Flutter SDK
- Dart
- A Supabase account and project 
- Docker (optional. If you haven't set this up, you may check and [learn how to configure and deploy Supabase with Docker](https://supabase.com/docs/guides/self-hosting/docker) here.

  
### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/elixirika/taskboard-supabase-flutter.git
   ```

2. Navigate to the project directory:
   ```bash
   cd taskboard-supabase-flutter
   ```

3. Install the dependencies:
   ```bash
   flutter pub get
   ```

4. Configure your Supabase credentials by creating a `.env` file in the root of the project with the following contents:
   ```plaintext
   SUPABASE_URL=your_supabase_url
   SUPABASE_ANON_KEY=your_supabase_anon_key
   ```

5. Run the application:
   ```bash
   flutter run
   ```

## Usage

Once the application is running, you can utilize the authentication features provided by the Supabase Auth UI package. Customize the UI components as needed to fit your application.


```**Thanks for exploring this project! Dive in and happy coding!!**```
