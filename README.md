# My Walks
The My Walks app is the perfect tool for those who enjoy an active lifestyle and want to keep track of their walks. With the app you can easily track your routes, save them and share them with friends. The app offers a user-friendly interface that allows you to quickly start recording your walk and stop it after you finish your walk. In addition, you can view your saved routes in a special tab.

## Technology stack  
The application uses the following technology stack:  
- **CoreLocation:** To track the user's location.
- **MapKit:** For drawing on the map and displaying routes taken.
- **SwiftData:** To save data, including routes taken.
- **SwiftUI:** For writing the application interface.
- **WidgetKit:** To create widgets that display on the home screen of devices.
- **ActivityKit:** To create dynamic and interactive widgets known as Live Activities that appear on the lock screen and in Dynamic Island.

# Application Appearance
MyWalks app comes with several key features that provide a convenient and comprehensive user experience.
1. **Tracking the user's location:** The application allows you to track the user's location while walking, which is important for accurately measuring the distance traveled and building a route.  
1. **Walk control buttons:** Start, pause and end walk buttons are available in the application interface. This allows the user to easily control the process of tracking their walk.
2. **Pop-up menu:** After completing a walk, a pop-up menu appears that offers to save the completed walk. This simplifies the process of storing data and ensures its availability for further analysis.
3. **Save Walk Form:** The user can fill out a form to save a walk by providing the necessary details such as title, description and other metadata.
4. **View and change walk form:** For each saved walk, a form is available that allows you to view and change data. This allows you to correct information and update records as needed.
5. **Settings Page:** The app has a settings page where the user can configure various settings such as units of measurement, location update frequency, and other preferences.
6. **Saved Walks View Page:** All saved walks are available for viewing on a separate page where the user can view the history of their walks and analyze statistics.
7. **Longest Walk Widget:** The app includes a widget that displays the user's longest walk, which motivates them to achieve new results.
8. **Live Activity:** For Live Activity-enabled devices, the app displays your distance traveled on the lock screen or in Dynamic Island, giving you quick access to up-to-date information without having to unlock your device.
  
## Start screen and Tracking road example
On the main screen of the application we see a map that displays our current geolocation. There are also three buttons on the screen: a list of walks, a button to start recording a walk, and a settings button.
  
When you click on the button to start recording a walk, the route of our walk begins to be displayed on the map. This allows us to track our path and see where we have gone.
<div align = "center">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/31519c48-ae8e-437f-912c-17d353a6f3f3">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/a3d93586-ec2d-485b-bcee-d2259dc8a0a9">
</div> 
  
## Saving walk proccess
These three images show the process of saving a walk in the application. When the user presses the center button, the app displays a pop-up window with two options: continue walking or stop recording.
  
If the user chooses to stop recording, another window appears asking them to save the walk. If the user does not want to save the walk, he can click the "No, thanks" button.
  
If the user decides to save the walk, they are prompted to fill out a form. In this form you must enter the name of the walk and, if desired, a description. The form also displays the starting and ending points of the walk, as well as the distance traveled.
<div align = "center">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/39dbd7c8-cd75-4609-bdc2-7d1ac7f9bc13">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/fc658847-6f80-480b-b152-e3c39d68a4db">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/c6b88667-8413-4d87-8b85-4088270b011a">
</div>
  
## Settings and Widget
The first image shows the app settings screen. Here the user can change the measurement system to metric or imperial, select the application language (only English is currently available) and enable the dark theme.
  
The second image shows the longest walk widget. It contains a screenshot of the map which shows the final path of the walk, as well as the distance and name of the walk.
<div align = "center">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/8e3d1247-3b9a-40db-9f34-031162c3abef">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/57d52c25-ba23-438e-81ed-0b83b1269646">
</div>
  
## Walks list and Walk details
The image shows a list of saved walks. The user can swipe left on a walk and delete it using swipe actions.
  
When you click on the walk you are interested in, a window with details opens. In this window, the user sees a map of the route, the name of the walk, the distance traveled, the starting and ending points, and a description of the walk. If the user wants to change information about a walk, they can click on the title or description and make the necessary changes. To save changes, you need to click on the "Update" button at the bottom of the window.
<div align = "center">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/ee5ec4a4-a85d-4eed-8e96-3c562981db2e">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/115afee4-3cba-4402-8292-2ccbd367a8a6">
</div>
  
## Live Activities
The first image shows a collapsed view of the dynamic island. It displays an icon of a walking person and the walking distance expressed in kilometers.
  
The second image shows the dynamic island expanded. The person icon and distance are also present here, but the font is larger.
  
The third image shows live activity that appears on the lock screen or notifications. It also includes a person icon and the distance expressed in kilometers.
<div align = "center">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/4ec47b93-148f-44ce-87e0-ba7566f0b834">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/3c7f9c67-92f5-475f-9e98-947ffe4dd8b4">
  <img width="250" alt="Снимок экрана 2024-07-27 в 22 14 50" src="https://github.com/user-attachments/assets/95c704e1-755f-47d3-97c8-260885ee64d3">
</div>
