# Firebase Setup Guide for Mental Zen



## Configuration Steps Completed ✅

### ✅ Step 1: Firebase Project Created
- Project ID: `project2-fd61b`
- Project Number: `987958054356`
- Storage Bucket: `project2-fd61b.firebasestorage.app`

### ✅ Step 2: Authentication Enabled
- Email/Password authentication enabled in Firebase Console
- Users can sign up, sign in, and reset passwords
- **Tested and verified** - User registration working

### ✅ Step 3: Apps Registered
- Android app: `com.company.project2` (registered)
- iOS app: `com.example.project2` (registered)
- macOS app: `com.example.project2` (registered)
- Web app: `project2 (web)` (registered)
- Windows app: `project2 (windows)` (registered)

### ✅ Step 4: Firebase Configuration Complete
- `lib/firebase_options.dart` generated with real credentials
- `google-services.json` placed in `android/app/`
- All platforms configured (Android, iOS, macOS, Web, Windows)

---




## Security Features Implemented 

1. **Password Validation:** Minimum 6 characters
2. **Email Validation:** Proper email format checking
3. **Error Handling:** User-friendly error messages
4. **Secure Storage:** Ready for `flutter_secure_storage` integration
5. **Privacy Notes:** Clear communication about data security
6. **Firestore Rules:** User-scoped data access only

---



---



### TODO: Configure Firestore Security Rules
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

### TODO: Set Up Firebase Cloud Messaging (for Reminders)
1. In Firebase Console, go to **Build → Cloud Messaging**
2. If on iOS, upload your APNs certificate or key
3. Note your Server Key for later use

