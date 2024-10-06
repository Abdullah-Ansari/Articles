# Articles

## Overview
This project implements an MVVM architecture for fetching and displaying articles from API. It consists of a Network Service, Repository, ViewModel, and View components, ensuring a clean separation of concerns and making the codebase easy to maintain and test.

## Screenshots
<div style="display: flex; justify-content: space-around;">
    <img src="https://github.com/user-attachments/assets/0f904756-aa1b-420e-b68c-75d4cf745bba" height="400" alt="Articles Dark" style="margin: 0 10px;">
    <img src="https://github.com/user-attachments/assets/578c18eb-6c33-4ca7-945f-644eeee326f8" height="400" alt="Articles Light" style="margin: 0 10px;">
    <img src="https://github.com/user-attachments/assets/2933d14c-487b-41da-b60e-b966ad22a347" height="400" alt="Articles Details Dark" style="margin: 0 10px;">
    <img src="https://github.com/user-attachments/assets/f6b8a0bc-4ccb-4bd0-a628-a1e187b022d4" height="400" alt="Articles Details Light" style="margin: 0 10px;">
</div>

## Features
* Fetches articles from the New York Times API.
* Displays articles in a list format.
* Implements search functionality to filter articles.
* Handles loading states and error messages gracefully.

## Architecture
The project follows the MVVM design pattern, which consists of the following components:
* **Model**: Represents the data structure (e.g., Article, ArticlesResponse).
* **View**: The SwiftUI views that present data to the user (e.g., ArticlesListView, ArticleRowView).
* **ViewModel**: Contains the business logic and acts as an intermediary between the Model and View (e.g., ArticlesViewModel).
* **Repository**: Manages data operations and abstracts the data source (e.g., ArticleRepository).
* **Network Service**: Handles API calls and network requests (e.g., NetworkService).

## Usage
1. Launch the application.
2. The main screen will display a list of articles fetched from the New York Times API.
3. Use the search bar to filter articles based on their titles or abstracts.
4. Tap on an article to view its details.
5. There is also full link of the article at the bottom of the article details.

## Unit Tests
The project includes unit tests for critical components:
* **Network Service**: Tests to ensure correct handling of API responses.
* **Repository**: Tests to verify data fetching logic.
* **ViewModel**: Tests to ensure proper state management and logic execution.
### To run the tests:
1. Open Xcode.
2. Select Product > Test or use the shortcut Command + U.

## Contributing
Contributions are welcome! Please follow these steps:
1. Fork the repository.
2. Create a new branch (git checkout -b feature/YourFeature).
3. Make your changes and commit them (git commit -m 'Add some feature').
4. Push to the branch (git push origin feature/YourFeature).
5. Create a new Pull Request.









