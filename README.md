# 📱 Flutter Social Feed App

A modern **social feed application** built using Flutter.  
This app allows users to log in, view and interact with posts, like and comment on feeds, and create new posts with AI-generated captions using a mock API.

---

## 🚀 App Overview

This project demonstrates a **social media-style feed** where users can:

- Log in with their credentials
- View a list of posts (feeds)
- Like or unlike posts in real time
- Add and view comments for each post
- Create and upload new posts
- Generate AI-powered captions for images using an API integration

---

## ✨ Features Implemented

✅ **Login Screen**

- Simple and attractive UI
- Password show/hide toggle

✅ **Feed Screen**

- Displays all user posts
- Shows likes and comments count
- Real-time like/unlike updates
- Beautifully designed feed cards with images and captions

✅ **Comments Bottom Sheet**

- Displays all comments on a post
- Allows adding new comments
- Auto-refreshes after new comment

✅ **Create Post**

- Upload image and write caption
- AI caption generation using a mock API
- Firebase storage and Firestore integration

✅ **State Management**

- Implemented using **BLoC Pattern (flutter_bloc)** for scalability and maintainability

---

## 🧰 Libraries Used

| Package                    | Purpose                          |
| -------------------------- | -------------------------------- |
| **flutter_bloc**           | State management                 |
| **cloud_firestore**        | Firestore database               |
| **firebase_storage**       | Image upload                     |
| **flutter_secure_storage** | Secure Local Data Storage        |
| **cached_network_image**   | Efficient image caching          |
| **lottie**                 | Smooth Animation                 |
| **get_it**                 | Dependency Injection             |
| **font_awesome_flutter**   | Icons                            |
| **timeago**                | To get accurate time ago         |
| **http**                   | API calls for caption generation |
| **image_picker**           | Select images from gallery       |
| **flutter_dotenv**         | Environment variable management  |

---

## ⚙️ How to Run the App

# 1️⃣ Clone the repository

git https://github.com/Shubham-109/socialfeedplus_shubham.git
cd socialfeedplus_shubham

# 2️⃣ Install dependencies

flutter pub get

# 3️⃣ (Optional) Set up Firebase

flutterfire configure

# 4️⃣ Run the app

flutter run

# ✅ Flutter version used

Flutter 3.32.4 • Dart 3.8.1

# 🤖 AI Caption Generation API

This app uses the Image Caption Generator API from RapidAPI to generate creative captions for uploaded images.

EndPoint - https://image-caption-generator2.p.rapidapi.com/v2/captions

How It Works:

1. The app uploads an image to Firebase Storage.

2. It sends the image URL to the API endpoint above.

3. The API responds with multiple AI-generated captions.

4. The user can select or edit one before posting.
