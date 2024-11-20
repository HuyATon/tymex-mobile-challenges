# tymex-mobile-challenges
## 1. About App's Structure

- iOS Target: `17.0`

- This app follows MVVM architecture

### Features

- Converting Currencies: convert currency using provided API

- Stats: Basic stats figure to visualize data

- Local storing: save most rencent data when fetch successfully. If user can not access internet, they can still able to use this app if local data is available.

- Dark Mode

- Reload: user can reload to get the lastest records from server.

### Folder Structure

- `Models`: related data models

- `Views`: app's screens

- `ViewModels`: app's viewmodels

- `Services`: services that help app to handle networking tasks, file I/O

- `Enums`: enums used in this app

- `UIComponents`: UI Components that frequently used

- `Tymex Currency ConverterTests`: unit tests


## 2. Steps To Build And Run

- Make sure that iOS target and iOS Simulator are valid 

- Replace API Keys if mine is invalid or out of available calls

- Replace base currency to which you prefers

## 3. Notes And Challenges

**Notes**
- You can easily replace the `API Key` & `Base Currency` to your own one in constructor of FetchService class in `Tymex Currency Converter/Services/FetchService.swift`

**Challenges**
- I believe that this app would be more wonderful if it has a additional feature like having a figure for time-series changes in exchange rates for each currencies. At first, I did plan to add this feature but the API is not available for free subscription.

## 4. Demonstration Video
