<h1 align="center">
 BiSU İOS Developer Challenge
</h1>

# BreakingUSNews
News application where user can read breaking news from USA and add to favorites. Developed with VIP Design Architecture.

## Features
- News application where user can read breaking news from USA and add to favorites. Developed with VIP Design Architecture.

- Animated splash screen using Lottie library.

- Rest Api operations are done using Alamofire library.

- With the SDWebImage library, images are cached and images are easier to load.

- News is added to favorites and kept in Core Data database.

- With RxCocoa, the current number of favorite news is displayed to the user.

- When the news is added to favorites, a firebase analytics event is sent as a news title and a toast message is shown to the user with the ToastPresenter library.

- Detail screen has scroll view feature.
With WebKit, you can go to the source of the news.

- When the trash button is clicked on the Favorites screen, the Presentation Controller opens the confirmation screen. Deletion is done from Core Data.
News added to favorites are listed at the top.

## Third Party Libraries:
- Alamofire
- SDWebImage
- RxCocoa
- FirebaseAnalytics
- ToastPresenter
- Lottie

## Database 
- Core Data

## Design Architecture
- VIP

## Installation:
1. Get your News API key
2. Insert your keys into Requester.swift file
3. Run pod install command in terminal.
4. Run app

## Screens 
 <table>
  <tr>
    <td>Splash Screen </td>
    <td>News List</td>
    <td>News Detail</td>
  </tr>
  
  <tr>
    <td><img src="https://user-images.githubusercontent.com/61903359/216702834-d4aa6ddf-22bc-4335-bfcf-fd9c772bd8af.png" width=230 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/61903359/216702906-fce0ea78-54a6-4e24-b6c6-abc26c2e9a16.png" width=230 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/61903359/216703103-5c371700-3e09-429e-9625-6113578f63ec.png" width=230 height=480></td>

  </tr>
 </table>

 <table>
  <tr>
    <td>Favorites List </td>
    <td>Favorites Detail</td>
    <td>Delete Screen</td>
 
  </tr>
  <tr>
    <td><img src="https://user-images.githubusercontent.com/61903359/216703748-2bb06a90-12b8-409f-9e78-d6c30361b146.png" width=230 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/61903359/216703813-6903ffd3-f0bd-410a-9781-a308398a0234.png" width=230 height=480></td>
    <td><img src="https://user-images.githubusercontent.com/61903359/216703828-576c795d-a1a7-49ca-9e55-9c306c9fa7c8.png" width=230 height=480></td>

  </tr>
 </table>

## Video
https://user-images.githubusercontent.com/61903359/216704175-71701fa7-4477-4f8f-af3b-3c9d8a12c1bd.mov
