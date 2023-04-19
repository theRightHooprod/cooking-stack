# Firebase CLI installation for dart and flutter connection with firestore.

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
