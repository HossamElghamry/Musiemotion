<p align="center"><img src="assets/images/Logo.png" width="150"/><h1 align="center"> <strong>Musiemotion</strong></h1></p>

<div align="center">
  <strong>-- 😃 An Emotion-Based Music Recommendation System 😔 --</strong>
</div>


<p>- Play Store (Android): https://play.google.com/store/apps/details?id=com.flarize.musiemotion&hl=en </p>
- iOS version coming soon!

# 📱 Front-End

## Using Flutter <img src="assets/images/flutter.png" width="17"/> , Provider and BLoC Pattern

[✔️] **Five** Different Emotion Options - **Happy <img src="assets/images/Happy.png" width="15"/> | Neutral <img src="assets/images/Neutral.png" width="15"/> | Meh <img src="assets/images/Meh.png" width="15"/> | Down <img src="assets/images/Down.png" width="15"/> | Frustrated <img src="assets/images/Frustrated.png" width="15"/>**

[✔️] **Feeling Lucky** 🍀 Option for a Lucky Recommendation

[✔️] Song Recommendation Data Retrieval using **HTTP** 🌐 and the Dedicated [Back-End API](https://github.com/HossamElghamry/Musiemotion/blob/master/README.md#Back-End)

[✔️] **Spotify OAuth Access Token** 🔐 Authentication using **Client Credentials Flow** for **Album Art** 🖼️ Retrieval

[✔️] **Spotify Redirection** 🎧 to Listen to the Desired Recommendation

[✔️] Clean **BLoC** Architecture Implementation

[✔️] Full Utilization of **Provider**

[✔️] **Network Connectivity**🌐 Checking

[✔️] Easy-to-Follow **User Interface**

# 🖧 Back-End

## Using Python Flask <img src="assets/images/flask.png" width="35"/>, Heroku <img src="assets/images/heroku.png" width="20"/> and K-Means Clustering

Spotify Dataset Link: https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks

[✔️] Data preprocessing and segmentation using **Python**

[✔️] Emotion Classification and Labeling using **K-Means Clustering**

[✔️] API Deployment using **Flask** and **Heroku** @ https://musiemotion.herokuapp.com/(Emotion)/(NumberOfRecommendationsNeeded)

[✔️] Data Representation in JSON format

# 🔧 Building Requirements

- Initiating **Enviroment Variables**

  - Create a _.env_ file in the root directory of your Flutter project
  - The _.env_ should include your Spotify for Developers App's **Client ID** and **Client Secret** in the following format:

        CLIENTID=<Your Client ID>
        CLIENTSECRET=<Your Client Secret>

### 🛑 **Disclaimers**

- No data is collected from the user nor the developer. The .env should be included in the .gitignore file when commiting
- The first data retrieval process will take up to one minute for the Heroku enviroment to initialize
- The normal recommendation retrieval process should not take more than 1 second

# 🗃️ To-Do List

[🔮] Recommendation List Sorting Based on Different Parameters (Popularity, Duration, etc...)

[🔮] More Emotions

[🔮] Error Handeling

# 🖻 Screenshots

<img src="screenshots/1.jpg" width="250"/> <img src="screenshots/2.jpg" width="250"/> <img src="screenshots/3.jpg" width="250"/> <img src="screenshots/4.jpg" width="250" height="400"/> <img src="screenshots/5.jpg" width="250"/>
