---
title: React Native Push Notifications
tags:
  - Android
  - iOS
  - react-native
categories:
  - App
comments: true
date: 2017-04-05 20:00:00
---

# What
It's an article about my own experience implementing Push Notification in react-native for both platforms. It contains the tools and libraries I picked and pitfalls I encountered. 

# Why
Push Notification looks simple, but actually it carries some complexities when putting it in use. There is quite a list of pitfalls for both platforms as well. 


# Understand the Concepts
If you are not new to software engineering, it shouldn't be a major hurdle to understand the design of push notification service. However, here are two articles I found from online that should be helpful to familiarize yourself with it. 

* [How do iOS Push Notifications work?](http://stackoverflow.com/questions/17262511/how-do-ios-push-notifications-work)
* [How Does Google Cloud Messaging Work?](http://support.airbop.com/kb/faq/how-does-google-cloud-messaging-work)

The fundamental concepts and system architecture are almost the same. So once you know one of them, you can easily understand the other one (融会贯通).

# To Implement

## Server Side
The easiest to find out how server side works is to setup amazon SNS. It can be used to test both GCM/FCM and APN. 

For GCM/FCM, you can also test via `postman`, or even `curl`. I didn't find an easy way to test APN with some simple tool so far. 

If you prefer DIY, and eventually to write your provider code to communicate with Google and Apple server directly. Here are two options written in NodeJS.

* https://github.com/node-apn/node-apn
* https://github.com/ToothlessGear/node-gcm


## App Side
First, we need pick some mature and stable libraries. Unfortunately, there isn't one. Here are the only two that has got some attention in the community. 

* https://github.com/zo0r/react-native-push-notification
* https://github.com/wix/react-native-notifications

I prefer the 2nd one, which is more active and has better completeness in features. 

If you have prior experience on implementing Push Notification for one of the platforms, you can also write your own react-native modules which give you more control. 

# Pitfalls

### 1. FCM vs GCM
FCM is the evolved version of GCM. Google has also move API key setup from API Console and put it in Firebase Console. So, if you are reading some old articles about how to setup GCM with Google, they are most likely out-of- date. However, once you get the API key from Firebase Console, the rest is pretty easy.

### 2. APN setup
This is the help page to Apple - [configure your notifications with Apple](https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/AddingCapabilities/AddingCapabilities.html#//apple_ref/doc/uid/TP40012582-CH26-SW6). 

In case you work for a company and you don't have the permission creating `Apple Push Notification service SSL`, you need to ask someone who has the permission, and send the certificate (in correct format, .p12) to you so you can test how server side works. 

### 3. Launching App from cold state and get the initial notification
**iOS**. Natively supported even in react-native `PushNotificationIOS`. Only problem is you cannot get the initial notification if App is launched from the icon. 

**Android**. `react-native-notifications` provides a similar implementation just like the iOS one. So far I haven't found any problem with it. Also, you cannot get the initial notification if launching App from the icon. 

### 4. Background vs Foreground Notification
**iOS**. Server side has to include `"content-available": 1` in the JSON message, otherwise your post-notification processing code won't be called in background e.g.
```JSON
{"aps":{"content-available":1}}
```

**Android**. Notification are even fired when app is in foreground by default. You probably want to write your own logic to block foreground firing. Here is what I did (with `react-native-notifications`): 
```Java
    @Override
    protected void postNotification(int id, Notification notification) {
        if (!mAppLifecycleFacade.isAppVisible()) {
            final NotificationManager notificationManager = (NotificationManager) mContext.getSystemService(Context.NOTIFICATION_SERVICE);
            notificationManager.notify(id, notification);
        }
    }
```

### 5. Badge Challenge
**Android**.  Badging is not a standard Android feature, but the major phone maker all did their own implementations, Samsung, HTC, Huawei, etc. There is a very good library in github -- [ShortcutBadger](https://github.com/leolin310148/ShortcutBadger). You need write a react-native module to call some APIs. 

**iOS**. It's quite a pain till the time I write this article. The badge is controlled by `"content-available": 1 ` when the App is cold (aka killed or not launched). If you write your own provider, you have the control. But if notification is from some SaaS service, you have to rely on whether they send it to you or not.  

### 6. What number to badge? 
At the time of this writing. We've decided to badge 1 to just attract user's attention that there is something new in the app. If you want some complex scenarios to work. You probably need to maintain the number at your server side, which is quite a challenge.


## Ending
Hope this article help answer some of your questions or confusions. 
