# Hanging App

This is a simple Swift MongoDB Realm App for iOS 

The Realm App Id is 

```
REALM_APP_ID = "hangingapp-lxnaw"
```

The MongoDB Realm App was configured 

* Cluster: HangingApp
* Partition Key: _partition of type String
* Database: HangingAppDB

With a Simple Email/Password authentication

* Automatically Confirm Users
* Run a Password Reset Function
* ResetFunc

There is one user called john@doe.com with a password "mongodb"

Run & Build the app and press "Press to Hang"

The application will never come back from Realm.asyncOpen() in RealmManager.swift