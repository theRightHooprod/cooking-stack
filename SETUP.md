# Setup Cooking Stack for local development
In this guide I'll show you how to setup Cooking Stack for local development.

## Download the repository
---
To download the repository you can use the following command:

```
git clone https://github.com/theRightHooprod/cooking-stack.git
```

## Flutter installation
---
To install flutter you can follow the official guide [here](https://flutter.dev/docs/get-started/install)


## Firebase CLI installation for dart and flutter connection with firestore.
---
To achieve the connection of an application created with the dart language and the flutter framework, it is necessary to install the firebase client which will help facilitate the process of registering cross-platform code and make use of both the non-relational database cloud firestore.

For the project in question made use of the package manager tool npm, which is included in the installation of nodejs as a server. To install the CLI it is required to execute the following command:

```
npm install -g firebase-tools
```

Subsequently, the FlutterFire CLI tool is required, for which the following command must be executed using the dart package manager

```
dart pub global activate flutterfire_cli
```

Once the installation of the firebase cli and the activation of the dart package is done, it is necessary to execute the following command in order to log in and give permission to the tool so that it can configure the firebase application according to the existing projects in the console.

```
firebase login
```

Subsequently, in the project folder it is necessary to execute the following command in order to configure the application with the firebase project. It is necessary to emphasize that the project in its development was called "Cooking Stack" referring to the application

```
flutterfire configure --project=cooking_stack
```

This automatically registers the application with the firebase service and adds `lib/firebase_options.dart` where the necessary keys for the connection to the firebase service are registered.

## Firebase project creation
---

To create a firebase project you can follow the official guide [here](https://firebase.google.com/docs/web/setup)

Then, you need to create a Firestore databas. You can follow the official guide [here](https://firebase.google.com/docs/firestore/quickstart)

Afterr that, you will need to start Firebase Autehtication. You can follow the official guide [here](https://firebase.google.com/docs/auth/web/start)

## Set App Accounts
---
You will need to create 3 accounts for the app to work properly. You can do it in the Authentication tab in the Firebase console. After that you will need to set the account UUID in the app on [lib/common/global_variables.dart](lib/common/global_variables.dart)

```
static String accountAkinator(String uid) {
    if (uid == 'UUID for admin') {
      return 'admin';
    } else if (uid == 'UUID for kitchen') {
      return 'kitchen';
    } else {
      return '/';
    }
  }
```

## Compile the app
---
To compile the app you will need to run the following command:

```
flutter run
```

## WhatsApp API keys
---
To set the WhatsApp API key you will need to compile the app for any platform and then you will be able to set the keys in the app as an administrator.

## Poduction build
---
To build the app for production you will need to modify isProd on GlobalVar class on [lib/common/global_variables.dart](lib/common/global_variables.dart) and then run the following command:

```
flutter build apk
```

If you want to connect to local emulators change back isProd to false and run the following command:

```
firebase emulators:start
```