# QuizQuest!

A Flutter quiz app with user authentication, leveraging the Open Trivia DB API to fetch questions, and using Firebase for storing user data, managing leaderboards, and tracking quiz statistics.

## Screenshots

### Authentication Screens

<div style="display: flex; justify-content: space-between;">
  <img src="assets/screenshots/Welcome%20Screen.png" alt="Welcome Screen" width="200" height="400"/>
  <img src="assets/screenshots/SignIn%20Screen.png" alt="SignIn Screen" width="200" height="400"/>
  <img src="assets/screenshots/Forgot%20Password%20Screen.png" alt="Forgot Password Screen" width="200" height="400"/>
  <img src="assets/screenshots/SignUp%20Screen.png" alt="SignUp Screen" width="200" height="400"/>
  <img src="assets/screenshots/Email%20Verification%20Screen.png" alt="Email Verification Screen" width="200" height="400"/>
</div>

### Quiz Screens

<div style="display: flex; justify-content: space-between;">
  <img src="assets/screenshots/Home%20Screen.png" alt="Home Screen" width="200" height="400"/>
  <img src="assets/screenshots/Quiz%20Category%20Screen.png" alt="Quiz Category Screen" width="200" height="400"/>
  <img src="assets/screenshots/Quiz%20Configuration%20Screen.png" alt="Quiz Configuration Screen" width="200" height="400"/>
  <img src="assets/screenshots/Quiz%20Question%20Screen.png" alt="Quiz Question Screen" width="200" height="400"/>
  <img src="assets/screenshots/Result%20Screen.png" alt="Result Screen" width="200" height="400"/>
  <img src="assets/screenshots/Details%20Screen.png" alt="Details Screen" width="200" height="400"/>
</div>

### Drawer Screens

<div style="display: flex; justify-content: space-between;">
  <img src="assets/screenshots/Drawer%20Screen.png" alt="Drawer Screen" width="200" height="400"/>
  <img src="assets/screenshots/Statistics%20Screen.png" alt="Statistics Screen" width="200" height="400"/>
  <img src="assets/screenshots/Leaderboard%20Screen.png" alt="Leaderboard Screen" width="200" height="400"/>
</div>


## Project Overview

The Quiz App includes the following features:

  1. **User Authentication:** Features comprehensive user authentication, including sign-in, sign-up, password reset, and email verification.

  2. **Quiz Questions:** Utilizes the Open Trivia DB API to fetch quiz questions, ensuring a diverse pool across multiple categories and difficulty levels.

  3. **Firebase Integration:** Stores user data, quiz results, and leaderboard information in Firebase, ensuring real-time updates and secure data management.

  4. **Leaderboards and Statistics:** Maintains leaderboards to track top performers. Provides users with detailed statistics on their quiz performances, allowing them to monitor progress over time.


## How to Clone QuizQuest!

To clone the QuizQuest project to your local machine, follow these steps:

1. **Open Terminal or Command Prompt**

2. **Navigate to Your Desired Directory**

   ```sh
   cd path/to/your/directory

3. **Clone the Repository**

   ```sh
   git clone https://github.com/abhaypanwar00/QuizQuest.git

4. **Navigate into the Project Directory**

   ```sh
   cd QuizQuest

## Setup Instructions

To run this project, you need to set up your own Firebase configuration. Follow these steps:

1. Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
2. Download the `google-services.json` file for Android and the `GoogleService-Info.plist` file for iOS from the Firebase Console.
3. Place `google-services.json` in the `android/app/` directory and `GoogleService-Info.plist` in the `ios/Runner/` directory.
4. Install Dependencies

   ```sh
   flutter pub get

5. Run the App

   ```sh
   flutter run

**NOTE:** You can also use the Firebase CLI for managing your Firebase project. For more details, check out the [Firebase Cli Documentation](https://firebase.google.com/docs/flutter/setup?platform=ios)
