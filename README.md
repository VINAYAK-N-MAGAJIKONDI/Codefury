
# Shield

#### Shield is an Android mobile application aimed in enhancing disaster preparedness and addressing issues.It alerts the users beforehand to be prepared for the upcoming disasters and also allows the users to contact organizations during Emergency situations.
#### It is user-friendly and keeps the us updated about what is going around us and how nice the weather is and educates us on how to deal with these calamities!


## Features
1. **Know the Weather:** Know the sunlight intensity, cloud movements, rainy situations, temperature and wind movements of the place you are at. Current location of yours will be kept updated 


2. **Current Happenings:** Explore the world wide news about climate changes, weather and natural disasters occurring.

3. **Educate yourself:** Get to know about how to be prepared for a natural disaster, learn about strategies for disaster response and learn the cause and effects of these with help of visual videos 

4. **Chat with AI:** Clear all your doubts and questions with the AI Chatbot. It is capable of processing both text and image messages and will respond you will information, recommendations and knowledge about Disaster Management.

5. **Contact during Emergency:** Whenever there is a need of help from government and Disaster Management Bodies, have a call with them in no time. All the contact numbers of such bodies are provided.

6. **Get Alerts:** The app will provide push notifications and alerts whenever there is a disaster to be occurred in the place we stay. With help of this, we can be prepared and evacuate the area before we are in danger!
## Screenshots

# App Screenshots
<div style="display: flex; flex-wrap: wrap;">
    <img src="https://github.com/user-attachments/assets/0745bc03-7f96-4a22-ab72-cccc99380d69" alt="Image 1" style="width: 200px; margin-right: 10px;">
    <img src="https://github.com/user-attachments/assets/12581c5a-cfb1-4967-a0b3-441b182eeff9" alt="Image 2" style="width: 200px; margin-right: 10px;">
    <img src="https://github.com/user-attachments/assets/c7ba9a96-a03b-447c-8b22-7196cbfe893c" alt="Image 3" style="width: 200px; margin-right: 10px;">
</div>

<div style="display: flex; flex-wrap: wrap;">
    <img src="https://github.com/user-attachments/assets/b3b96d08-53af-4b99-8cd5-1f69074e272c" alt="Image 4" style="width: 200px; margin-right: 10px;">
    <img src="https://github.com/user-attachments/assets/85555a3b-1033-4cb0-8521-9df05fdbbc10" alt="Image 5" style="width: 200px; margin-right: 10px;">
    <img src="https://github.com/user-attachments/assets/c06c2c76-b6ef-40dd-8d6b-df602e68c0a5" alt="Image 6" style="width: 200px; margin-right: 10px;">
    <img src="https://github.com/user-attachments/assets/25e7dca2-9a3d-4329-91df-74b111a87fac" alt="Image 7" style="width: 200px; margin-right: 10px;">
</div>




## Tech Stack

1. **Flutter:** The app is built using Flutter, Google's UI toolkit, to ensure a beautiful and responsive user interface that works seamlessly across various Android and IOS devices.

2. **Firebase:** Employed Firebase for server-side operations, including:
Authentication\
Realtime Database\
Cloud Storage

3. **Geolocation API:** Used the geolocation-based push notifications, ensuring users receive timely and location-specific alerts.

4. **Phone Authentication:** Firebase's phone authentication API is used for verifying users through their phone numbers.

5. **Gemini AI Chatbot:** Used the Gemini API to make users feel comfort by clearing their doubts and questions using it.

6. **Push Notification:** This feature was enabled to give alerts to users based on their location and climate.


## Demo

Insert gif or link to demo



## Installation

### Prerequisites

Before you begin, ensure you have met the following requirements:

- Flutter installed on your machine. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
- Dart SDK installed as part of Flutter.
- Firebase account and project setup. Follow the steps on [Firebase's official website](https://firebase.google.com/).
- Android Studio or VS Code installed with Flutter and Dart plugins.

### Step 1: Clone the Repository
 ```bash
git clone https://github.com/yourusername/shield.git
 ```


### Step 2: Install Dependencies

Run the following command to install all the necessary dependencies:

 ```bash
flutter pub get
 ```


### Step 3: Configure Firebase

1. *Add Firebase to Your Flutter App:*
   - Follow the instructions on [Firebase's official guide](https://firebase.google.com/docs/flutter/setup) to connect your Flutter app to Firebase.
   - Download the google-services.json file for Android and GoogleService-Info.plist for iOS and place them in the appropriate directories (android/app and ios/Runner respectively).

2. *Enable Firebase Services:*
   - Go to your Firebase console and enable the necessary services (e.g., Firestore, Firebase Authentication, Firebase Messaging, etc.).

### Step 4: Run the App

You can now run the app on an emulator or a physical device:

  ```bash
flutter run
 ```


## Deployment

### Android

1. *Build the APK:*
   - Run the following command to build the APK:
    ```bash
   flutter build apk --release
   ```
   
2. *Sign the APK:*
   - Follow the [official guide](https://flutter.dev/docs/deployment/android#signing-the-app) to sign the APK.

3. *Upload to Play Store:*
   - Follow the instructions on the [Google Play Console](https://play.google.com/console) to upload your APK

### iOS

1. *Build the iOS App:*
   - Run the following command to build the iOS app:
  ```bash
   flutter build ios --release
   ```
   
2. *Code Signing:*
   - Ensure that you have an Apple Developer account and follow the [official guide](https://flutter.dev/docs/deployment/ios) for code signing.
3. *Upload to App Store:*
   - Use Xcode or Application Loader to upload your app to the App Store.







