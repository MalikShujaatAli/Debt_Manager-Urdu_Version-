# Debt Manager App

## Overview

This GitHub repository contains the source code for a simple yet functional debt management application built with Flutter. The Debt Manager app, named "Qarz Manager," allows users to keep track of debts, specifying whether they owe money to someone or someone owes money to them. It features persistent storage using shared preferences and includes basic functionalities such as adding, viewing, and deleting debts, as well as reordering the list of debts.

## Features

### Application Structure

- **Main Entry Point**:
  - The application starts with the `main` function, which runs the `DebtManagerApp`.

- **DebtManagerApp Class**:
  - A stateless widget that sets up the MaterialApp with a title and theme, and points to the home page of the app (`DebtManagerHomePage`).

### Debt Management

- **DebtItem Class**:
  - A data model representing a single debt item with the following attributes:
    - `name`: The name of the person associated with the debt.
    - `amount`: The amount of money involved in the debt.
    - `isOwedByUser`: A boolean indicating whether the user owes the money (`true`) or the money is owed to the user (`false`).

- **DebtManagerHomePage Class**:
  - A stateful widget that serves as the main interface for managing debts.
  - **State Management**:
    - **Text Editing Controllers**: For managing input fields for the debt name and amount.
    - **Debts List**: A list to keep track of all debt items.
    - **Checkbox State**: To indicate if the debt is owed by the user.
  - **Persistent Storage**: 
    - Utilizes `shared_preferences` to save and load debt data across app sessions.
  - **UI Elements**:
    - Input fields for debt name and amount.
    - A checkbox to specify if the debt is owed by the user.
    - Buttons for adding debts and reordering the debt list using a `ReorderableListView`.
    - Each debt item in the list includes a delete button.
    - A footer displaying the developer's name, which links to their Instagram profile.

### Key Functionalities

- **Adding Debts**:
  - Users can enter the name and amount of the debt, specify if it's owed by the user, and add it to the list.
  - Validation ensures that both fields are filled, and the amount is a positive number.

- **Deleting Debts**:
  - Users can remove a debt item from the list by pressing the delete button next to each item.

- **Reordering Debts**:
  - The app supports drag-and-drop reordering of the debt list to prioritize or organize debts as desired.

- **Incremental Changes**:
  - Updates to the debt list are automatically saved to shared preferences, ensuring persistence across app restarts.

- **Launch External URL**:
  - The footer contains a link to the developer's Instagram profile, which opens in the default browser.

## Usage

To run this Flutter application, follow these steps:

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/your-username/debt-manager-app.git
    cd debt-manager-app
    ```

2. **Install Dependencies**:
    ```sh
    flutter pub get
    ```

3. **Run the App**:
    ```sh
    flutter run
    ```

4. **Interacting with the App**:
    - **Add Debt**: Fill in the name and amount fields, check if the debt is owed by the user, and press the "Dakhla" button.
    - **View and Manage Debts**: See the list of debts, reorder them by dragging, and delete items as needed.
    - **Visit Developer's Profile**: Tap on the "Made by Shujaat" footer to open the linked Instagram profile.

## Example Interaction

1. **Launch the App**:
    - The app opens to the main debt management screen.
2. **Add a New Debt**:
    - Enter "Ali" in the name field.
    - Enter "500" in the amount field.
    - Check the checkbox to indicate the debt is owed by the user.
    - Press "Dakhla" to add the debt to the list.
3. **Reorder and Delete Debts**:
    - Drag an item to reorder the list.
    - Press the delete icon next to an item to remove it.
4. **Footer Interaction**:
    - Tap on "Made by Shujaat" to visit the developer's Instagram profile.

## Contributing

Contributions are welcome! To contribute:

1. **Fork the Repository**.
2. **Create a Feature Branch**.
3. **Commit Your Changes**.
4. **Push to Your Branch**.
5. **Create a Pull Request**.

## License

This project is licensed under the MIT License. See the `LICENSE` file for more details.

---

This app is a simple yet effective tool for managing personal debts, with a clean interface and persistent storage, making it easy to keep track of who owes what. Happy managing!
