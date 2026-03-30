# TPC3: Acceptance Tests Development Log

## Goal
The objective of this assignment is to develop automated acceptance tests for the mobile app scenario defined in TPC2. I selected **User Story 1: Digital Prescription Creation**. 

The Acceptance Criteria are:
1. Verify that when all required fields are filled and submitted, the prescription is saved to the patient's profile.
2. Verify that saving the prescription automatically generates the corresponding schedule in the patient's and caregiver's views.

## Commands used
- `flutter create tpc3`: Initialized a clean Flutter project for TPC3 testing.
- `flutter test test/acceptance_test.dart`: Executed the headless acceptance tests on the terminal.

## Prompts & AI Gen Tools
- Used Antigravity (Gemini 3.1 Pro) agent to scaffold the minimal viable UI for the Prescription page (`lib/main.dart`) to have components to test against (Fields, SnackBar, ListView).
- Used the agent to layout and document the standard `flutter_test` (Widget Testing framework) flow for the UI.

## Critical Analysis
Creating tests using Flutter's built-in `flutter_test` testing framework (Widget tests) acts as a highly efficient automated acceptance testing method. Widget tests run headless so they are significantly faster and easier to set up than full emulator-dependent integration tests (`integration_test`), yet they provide real framework interactions (like measuring layout, pumping frames, and typing text).

By defining `Key` properties on the TextFormFields and the Submit button, the automated tests have a deterministic way to find elements on the screen without relying on brittle text matching. 
The test perfectly follows the user story's "Normal Operation" flow by feeding data into the fields, tapping save, waiting for the animations to settle (`tester.pumpAndSettle()`), and ensuring the resulting schedule appears in the mock view.

### Acceptance Test File Summary (`test/acceptance_test.dart`)
1. Build the widget tree (`MyApp`).
2. Insert text: Medication, Dosage, Schedule.
3. Tap the "Save Prescription" button.
4. Verify the success state: A SnackBar appears stating the prescription was saved.
5. Verify the data state: A list item is securely added displaying the entered Mock schedule.

The results run successfully from the terminal, fulfilling the TPC3 assignment objective!
