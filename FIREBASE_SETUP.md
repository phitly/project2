# Firebase Setup Guide for Mental Zen

## Current Status ✅
The Flutter app structure with Firebase authentication is now ready! Here's what has been implemented:

### Completed Features:
1. **Firebase Dependencies** - Added to `pubspec.yaml`
2. **Authentication Service** - Complete auth logic with email/password
3. **User Model** - Data structure for user information
4. **Auth Provider** - State management for authentication
5. **Login Screen** - Secure sign-in interface with privacy notes
6. **Sign Up Screen** - Account creation with validation
7. **Forgot Password Screen** - Password reset functionality
8. **Auth Wrapper** - Automatic navigation based on auth state
9. **Home Screen** - Placeholder for the main app (ready for mood tracking features)

### File Structure Created:
```
lib/
├── main.dart                          # App entry point with Firebase initialization
├── firebase_options.dart              # Firebase configuration (placeholder)
├── models/
│   └── user_model.dart               # User data model
├── services/
│   ├── auth_service.dart             # Firebase authentication logic
│   └── auth_provider.dart            # State management for auth
├── screens/
│   ├── auth_wrapper.dart             # Auth state routing
│   ├── home_screen.dart              # Main app screen (placeholder)
│   └── auth/
│       ├── login_screen.dart         # Sign in interface
│       ├── signup_screen.dart        # Account creation
│       └── forgot_password_screen.dart # Password reset
└── widgets/                           # Ready for custom widgets
```

---

## Next Steps: Configure Your Firebase Project 🔥

### Step 1: Create a Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or select an existing one
3. Follow the setup wizard
4. Enable Google Analytics (optional)

### Step 2: Enable Authentication
1. In Firebase Console, go to **Build → Authentication**
2. Click "Get Started"
3. Go to **Sign-in method** tab
4. Enable **Email/Password** authentication
5. Click "Save"

### Step 3: Register Your Apps

#### For iOS:
1. Click "Add app" → iOS
2. Bundle ID: Check `ios/Runner.xcodeproj/project.pbxproj` for bundle identifier
3. Download `GoogleService-Info.plist`
4. Place it in `ios/Runner/` directory

#### For Android:
1. Click "Add app" → Android
2. Package name: Check `android/app/build.gradle` for applicationId
3. Download `google-services.json`
4. Place it in `android/app/` directory

#### For Web:
1. Click "Add app" → Web
2. Register app with a nickname
3. Copy the config (you'll use it in Step 4)

### Step 4: Generate Firebase Configuration
Run this command in your project directory:
```bash
flutterfire configure
```

This will:
- Detect your Firebase project
- Generate `lib/firebase_options.dart` with real credentials
- Configure all platforms (iOS, Android, Web)

**Important:** The current `firebase_options.dart` is a placeholder and must be replaced!

### Step 5: Set Up Firestore Database
1. In Firebase Console, go to **Build → Firestore Database**
2. Click "Create database"
3. Start in **production mode** (we'll add rules next)
4. Choose a location closest to your users
5. Click "Enable"

### Step 6: Configure Firestore Security Rules
Replace the default rules with these (in Firebase Console → Firestore → Rules):

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users collection - users can only read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Moods collection - users can only access their own moods
    match /moods/{moodId} {
      allow read, write: if request.auth != null && 
                           request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && 
                      request.auth.uid == request.resource.data.userId;
    }
    
    // Journal entries - users can only access their own entries
    match /entries/{entryId} {
      allow read, write: if request.auth != null && 
                           request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && 
                      request.auth.uid == request.resource.data.userId;
    }
    
    // Mindfulness sessions - users can only access their own sessions
    match /sessions/{sessionId} {
      allow read, write: if request.auth != null && 
                           request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && 
                      request.auth.uid == request.resource.data.userId;
    }
    
    // Reminders - users can only access their own reminders
    match /reminders/{reminderId} {
      allow read, write: if request.auth != null && 
                           request.auth.uid == resource.data.userId;
      allow create: if request.auth != null && 
                      request.auth.uid == request.resource.data.userId;
    }
  }
}
```

### Step 7: Set Up Firebase Cloud Messaging (for Reminders)
1. In Firebase Console, go to **Build → Cloud Messaging**
2. If on iOS, upload your APNs certificate or key
3. Note your Server Key for later use

---

## Testing the App 🧪

### Run the App:
```bash
flutter run
```

### Test Flow:
1. **Sign Up:** Create a new account with email/password
2. **Sign In:** Log in with your credentials
3. **Forgot Password:** Test the password reset flow
4. **Sign Out:** Logout from the home screen

### Expected Behavior:
- ✅ Sign up creates a user in Firebase Authentication
- ✅ User data is stored in Firestore `users` collection
- ✅ Login navigates to home screen
- ✅ Logout returns to login screen
- ✅ Password reset sends an email
- ✅ All errors are handled gracefully

---

## Security Features Implemented ✨

1. **Password Validation:** Minimum 6 characters
2. **Email Validation:** Proper email format checking
3. **Error Handling:** User-friendly error messages
4. **Secure Storage:** Ready for `flutter_secure_storage` integration
5. **Privacy Notes:** Clear communication about data security
6. **Firestore Rules:** User-scoped data access only

---

## Next Development Steps 📋

After Firebase is configured, you can build:

1. **Mood Tracking** - Daily mood capture with 5 emotion options
2. **Journal Entries** - Rich text editor with media attachments
3. **Insights Dashboard** - Charts and analytics
4. **Mindfulness Library** - Guided sessions and affirmations
5. **Reminders System** - Push notifications using FCM
6. **Settings & Profile** - User preferences and account management

---

## Troubleshooting 🔧

### "Firebase not configured" error:
- Make sure you ran `flutterfire configure`
- Check that `firebase_options.dart` has real credentials (not "YOUR_API_KEY")

### Build errors on iOS:
- Run `cd ios && pod install && cd ..`
- Make sure `GoogleService-Info.plist` is in `ios/Runner/`

### Build errors on Android:
- Make sure `google-services.json` is in `android/app/`
- Check that google-services plugin is in `android/build.gradle`

### Auth not working:
- Verify Email/Password is enabled in Firebase Console
- Check Firestore security rules are published
- Look at Firebase Console → Authentication for registered users

---

## Resources 📚

- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
- [Firebase Auth Documentation](https://firebase.google.com/docs/auth)
- [Firestore Documentation](https://firebase.google.com/docs/firestore)

---

**Ready to configure Firebase!** Run `flutterfire configure` when you're set up with a Firebase project. 🚀
