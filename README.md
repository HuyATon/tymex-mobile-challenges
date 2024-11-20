# tymex-mobile-challenges
## 1. About App's Structure

- iOS Target: 17.0

- This app follows MVVM architectures

### Features

- Convert currency using provided API
- Basic stats figure to visualize data
- Local storing: save most rencent data when fetch successfully. When user can not access internet, they can still able to use this app if local data is available.

### Folder Structure
- Models: related data Models

- Views: application's screens

- ViewModels: application's viewmodels

- Services: services that help app to handle networking tasks, file I/O

- Enums: enums used in this app

- UIComponents: UI Components that frequently used


## 2. Steps To Build And Run

- Make sure that iOS target and iOS Simulator are valid 

- Replace API Keys if mine is invalid or out of available challenges

- Replace base currency to which you prefers

## 3. Notes And Challenges

Notes
- You can easily replace the `API Key` & `Base Currency` to your own one in constructor of FetchService class in `Tymex Currency Converter/Services/FetchService.swift`

- 
Challenges
- I believe that this app would be more wonderful if it has a additional feature like having a figure for time-series changes in exchange rates for each currencies. At first, I did plan to add this feature but the API is not available for free subscription.

## 4. Demonstration Video