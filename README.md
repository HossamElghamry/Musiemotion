<h1 align="center">Musiemotion</h1>

<div align="center">
  <strong>-- An Emotion-Based Music Recommendation Application --</strong>
</div>

# Front-End

## Using Flutter, Provider and BLoC Pattern

[✓] **Five** Different Emotion Options - **Happy | Neutral | Meh | Sad | Frustrated**

[✓] Song Recommendation Data Retrieval using **HTTP** and the Dedicated [Back-End API](https://github.com/HossamElghamry/Musiemotion/blob/master/README.md#Back-End)

[✓] **Spotify OAuth Access Token** Authentication using **Client Credentials Flow** for **Album Art** Retrieval

[✓] **Spotify Redirection** to Listen to the Desired Recommendation

[✓] Clean **BLoC** Architecture Implementation

[✓] Full Utilization of **Provider**

[✓] Easy-to-Follow **User Interface**

# Back-End

## Using Python Flask, Heroku and K-Means Clustering

Spotify Dataset Link: https://www.kaggle.com/yamaerenay/spotify-dataset-19212020-160k-tracks

[✓] Data preprocessing and segmentation using **Python**

[✓] Emotion Classification and Labeling using **K-Means Clustering**

[✓] API Deployment using **Flask** and **Heroku** @ https://musiemotion.herokuapp.com/(Emotion)/(NumberOfRecommendationsNeeded)

[✓] Data Representation in JSON format

# Building Requirements

- Initiating **Enviroment Variables**

  - Create a _.env_ file in the root directory of your Flutter project
  - The _.env_ should include your Spotify for Developers App's **Client ID** and **Client Secret** in the following format:

        CLIENTID=<Your Client ID>
        CLIENTSECRET=<Your Client Secret>

### **Disclaimers**

- No data is collected from the user nor the developer. The .env should be included in the .gitignore file when commiting
- The first data retrieval process will take up to one minute for the Heroku enviroment to initialize
- The normal retrieval process should not take more than 2 seconds

# Screenshots

<img src="screenshots/1.jpg" width="250"/> <img src="screenshots/2.jpg" width="250"/> <img src="screenshots/3.jpg" width="250" height="400"/>
