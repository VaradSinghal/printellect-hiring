# Printellect Test - E-commerce Flutter App

A premium, feature-rich E-commerce application built with Flutter and Firebase, featuring real-time data synchronization, user authentication, and a modern UI/UX design.

## Screenshots

<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="https://drive.google.com/uc?export=view&id=1Hxo40aG75msgVjwKiDFyd3SC6IZjWEiy" width="200" /><br />
        <b>Login Screen</b>
      </td>
      <td align="center">
        <img src="https://drive.google.com/uc?export=view&id=1pFdhNh-Cqd0wk_4isI4fdbxxDUna6SPq" width="200" /><br />
        <b>Home Screen</b>
      </td>
      <td align="center">
        <img src="https://drive.google.com/uc?export=view&id=1_iwrS0TQXzQs742uPhmngARRyHW7kCeP" width="200" /><br />
        <b>Cart Screen</b>
      </td>
    </tr>
  </table>
</div>

## Key Features

- **Authentication**: Secure user login and registration system.
- **Product Catalog**: Dynamic product listing with real-time updates from Firestore.
- **Product Details**: Comprehensive product information including descriptions and high-quality images.
- **Shopping Cart**: Efficient cart management system (Add, Remove, Update Quantity).
- **Smooth Navigation**: Intuitive flow and premium transitions between screens.
- **Data Persistence**: Offline support and state management for a seamless experience.

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **Backend/Database**: [Firebase Firestore](https://firebase.google.com/products/firestore)
- **Authentication**: [Firebase Auth](https://firebase.google.com/products/auth)
- **State Management**: [Provider](https://pub.dev/packages/provider)
- **Typography & Icons**: Google Fonts & Cupertino Icons
- **Image Handling**: Cached Network Image

## Project Structure

```text
lib/
├── models/         # Data models (Product, Cart)
├── providers/      # Business logic & state management
├── screens/        # UI screens (Home, Login, Product, Cart)
├── services/       # External service integrations
└── main.dart       # App entry point
```

## Getting Started

### Prerequisites

- Flutter SDK (latest version recommended)
- Firebase project setup

### Installation

1. **Clone the repository**:
   ```bash
   git clone <repository-url>
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
   - Ensure `firebase_options.dart` is correctly configured in `lib/`.

4. **Run the app**:
   ```bash
   flutter run
   ```

---

## Roadmap / To-Do

- [ ] Implement shimmering effect for smoother loading states.
- [ ] Add backend-side sorting and filtering for products.
- [ ] Implement user profile and order history.
