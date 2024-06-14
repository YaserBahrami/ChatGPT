
# OpenAI Sample Project

This project simulates a chat interaction similar to those with OpenAI's conversational AI models.


## Features

- Message Display: Messages are displayed in a UITableView with custom cells (MessageCell) to distinguish between user and system messages.
- User Input: User can input text using a UITextField located at the bottom of the screen.
- Suggestion Collection: A UICollectionView displays suggested questions (sampleQuestions) horizontally below the text field for user convenience.


## Tech Stack

**Swift:** The programming language used to develop the iOS application.

**Combine:** A reactive programming framework for Swift, providing a declarative way to handle asynchronous operations and events.

**MVVM:** An architectural pattern that separates the concerns of data presentation, business logic, and data modeling.

<img src="/GPT360/Resources/MVVM.png" alt="Screenshot 1" width="500" />

- Model: 
    - Represents the data and business logic of the application
    - Encapsulates the data and behavior that the application operates on.
    - Notifies observers about changes in the data.
- View: 
  - Represents the user interface and its visual elements.
  - Displays the data to the user.
  - Passes user input to the ViewModel.
- ViewModel
    - Acts as a mediator between the Model and the View.
    - Contains the presentation logic, transforming the data from the Model into a form suitable for the View.
    - Reacts to user input from the View, updating the Model and triggering UI updates.


**SnapKit** A Swift DSL (Domain-Specific Language) for Autolayout, making it easier to define constraints programmatically.

**Dependency Injection**


## Usage

1- Launch the application on your iOS device or simulator.

2- Sending Messages: Type a message in the text field and tap the send button or press return on the keyboard to send it.

3- Deleting Messages: Tap the delete button in the navigation bar to clear all messages displayed in the UITableView.




## Requirements
- **Xcode:** [Download Xcode](https://developer.apple.com/xcode/)
- **API Key:** To use this application, you'll need to obtain your own OpenAI API key.

## Run Locally

Clone the repository:
```bash
  git clone https://github.com/YaserBahrami/ChatGPT.git
```
Navigate to the project directory:
```bash
  cd GPT360
```
Install dependencies using Cocoapods:
```bash
  pod install
```
Open the project in Xcode:
```bash
  open GPT360.xcodeproj
```
Replace your OpenAI API Key


## Screenshots

<div style="display: flex; justify-content: space-between;">
    <img src="/GPT360/Resources/screen1.png" alt="Screenshot 1" width="200" />
    <img src="/GPT360/Resources/screen2.png" alt="Screenshot 2" width="200" />
</div>


## Demo

...

## License

This project is licensed under the [MIT](https://choosealicense.com/licenses/mit/) license


