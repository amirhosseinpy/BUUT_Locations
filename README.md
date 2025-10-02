# BUUT Locations

A Swift iOS application for managing and displaying location information with coordinates, built using UIKit and following clean architecture principles.

## Features

- Display locations in a table view
- View location details including name, and coordinates
- Clean architecture with VIP pattern
- Programmatic UI (no storyboards)
- Async/await for network operations
- Swift 6 compatible

## Architecture

The project follows a VIP clean architecture pattern with clear separation of concerns:

### Modules Structure
```
BUUT_Locations/
├── App/
│   ├── AppDelegate.swift
│   └── SceneDelegate.swift
├── Modules/
│   └── LocationsList/
│     ├── LocationsListCoordinator.swift
│     ├── LocationsListInteractor.swift
│     ├── LocationsListPresenter.swift
│     └── Views/
│           ├── LocationsListViewController.swift
|           ├── LocationsListView.swift
|           └── LocationTableViewCell.swift
│     ├── Models/
│           ├── LocationModel.swift
│           ├── LocationsModel.swift
│           ├── LocationViewModel.swift
└── SupportingFiles/
    └── Info.plist
```

### Components

#### Model
- **LocationModel**: Core data model containing location information (name, latitude, longitude)
- **LocationViewModel**: View model that formats location data for display

#### View Layer
- **LocationsListViewController**: Main view controller handling UI updates and user interactions
- **LocationsListView**: Custom UIView containing the table view
- **LocationTableViewCell**: Custom table view cell for displaying location information

#### Interactor
- **LocationsListInteractor**: Business logic layer handling data fetching and processing

#### Presenter
- **LocationsListPresenter**: Formats data from the interactor for the view layer

#### Coordinator
- **LocationsListCoordinator**: Navigation logic and module setup

## Key Classes

### LocationModel
```swift
struct LocationModel {
    let name: String?
    let latitude: Double
    let longitude: Double
}
```

### LocationsListViewController
- Manages the table view display
- Implements `UITableViewDataSource` and `UITableViewDelegate`
- Updates UI when receiving location data

### LocationTableViewCell
- Custom cell displaying:
  - Location name
  - Coordinates (latitude, longitude)

## Requirements

- iOS 16.6+
- Xcode 16.0+
- Swift 6.0+

## Installation

1. Clone the repository
2. Open `BUUT_Locations.xcodeproj` in Xcode
3. Build and run the project

## Usage

The app launches with a navigation controller displaying the locations list. The view controller automatically fetches location data on load through the interactor pattern.

## Architecture Benefits

- **Separation of Concerns**: Each component has a single responsibility
- **Testability**: Business logic is isolated from UI
- **Scalability**: Easy to add new features without affecting existing code
- **Maintainability**: Clear structure makes code easy to understand and modify

## Future Enhancements

- Add map view for visual location display
- Implement location search functionality
- Add location details screen
- Include Core Data for offline storage
- Add location sharing capabilities
- Implement user location tracking
- Implement more robust base network layer
- Consider large list of locations

## License

This project is available under the MIT license.

## Author

Created by Amirhossein Validabadi on 30/09/2025
