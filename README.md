# OOP Ride Sharing System in C++ and Smalltalk

A comparative implementation of a class-based ride-sharing system demonstrating core object-oriented programming principles. This project provides side-by-side implementations in C++ and Smalltalk, showcasing how OOP concepts are expressed differently across languages.

## Overview

The system models a basic ride-sharing platform with the following components:
- **Ride**: Base class for different ride types
- **StandardRide**: Standard fare calculation ($1.50 per mile)
- **PremiumRide**: Premium fare calculation ($3.00 per mile, $10.00 minimum)
- **Driver**: Manages assigned rides and tracks earnings
- **Rider**: Maintains ride history

## Core OOP Principles Demonstrated

### Encapsulation
Class data (e.g., a Driver's `assignedRides`) is kept private and accessible only through public methods (`addRide`).

### Inheritance
`StandardRide` and `PremiumRide` classes inherit functionality from the common `Ride` base/superclass.

### Polymorphism
The system processes heterogeneous collections of `Ride` objects, calling the correct `calculateFare()` and `rideDetails()` method for each object at runtime.

## Prerequisites

### C++ Implementation
- C++17 compatible compiler (g++, clang++, or MSVC)
- Standard C++ library support

### Smalltalk Implementation
- Smalltalk environment (Pharo, Squeak, or compatible)
- File browser access for loading code

## Setup and Execution

### C++ Implementation

#### Compilation
```bash
g++ -std=c++17 -o rideshare RideShare.cpp
```

**Windows (MSVC):**
```cmd
cl /EHsc /std:c++17 RideShare.cpp /Fe:rideshare.exe
```

**Alternative (clang++):**
```bash
clang++ -std=c++17 -o rideshare RideShare.cpp
```

#### Execution
```bash
./rideshare
```

**Windows:**
```cmd
rideshare.exe
```

#### Sample Output
```
--- Processing All Rides Polymorphically ---

--- Standard Ride ---
  Ride ID: S1001
  From: 123 Main St
  To: 456 Oak Ave
  Distance: 5 miles
  Fare: $7.50
---------------------------
--- Premium Ride ---
  Ride ID: P1002
  From: 789 Pine Ln
  To: 321 Maple Dr
  Distance: 12 miles
  Fare: $36.00
  (Includes premium service)
---------------------------
--- Standard Ride ---
  Ride ID: S1003
  From: 321 Maple Dr
  To: 123 Main St
  Distance: 3 miles
  Fare: $4.50
---------------------------

--- Final System State ---

===========================
Driver Info:
Name: James (ID: D101)
Rating: 4.8 / 5.0
Completed Rides: 3
Total Earnings: $48.00
===========================
===========================
Rider History for: Kate
Total Rides: 3
---------------------------
  - Ride ID: S1001, Fare: $7.50
  - Ride ID: P1002, Fare: $36.00
  - Ride ID: S1003, Fare: $4.50
===========================
```

### Smalltalk Implementation

#### Loading the Code

1. **Open your Smalltalk environment** (Pharo or Squeak)
2. **Load the file:**
   - Navigate to **File** → **File In...** (or use the file browser)
   - Select `RideShare.st`
   - The classes will be loaded into the `RideSharing` package

#### Running the Test Script

1. **Open a Workspace:**
   - In Pharo: **Tools** → **Workspace**
   - In Squeak: **Tools** → **Workspace**

2. **Paste the following code:**
```smalltalk
| driver1 rider1 ride1 ride2 ride3 allRides transcript |

transcript := Transcript.
transcript clear.
transcript show: '--- System Test Starting ---'; cr; cr.

"1. Create Drivers and Riders"
driver1 := Driver new initWithID: 'D101' name: 'James' rating: 4.8.
rider1 := Rider new initWithID: 'R201' name: 'Kate'.

"2. Create rides of different types"
ride1 := StandardRide new initializeWithID: 'S1001' pickup: '123 Main St' dropoff: '456 Oak Ave' distance: 5.0.
ride2 := PremiumRide new initializeWithID: 'P1002' pickup: '789 Pine Ln' dropoff: '321 Maple Dr' distance: 12.0.
ride3 := StandardRide new initializeWithID: 'S1003' pickup: '321 Maple Dr' dropoff: '123 Main St' distance: 3.0.

"3. --- POLYMORPHISM DEMONSTRATION ---"
allRides := OrderedCollection new.
allRides add: ride1.
allRides add: ride2.
allRides add: ride3.

transcript show: '--- Processing All Rides Polymorphically ---'; cr; cr.

allRides do: [ :aRide |
	aRide calculateFare.
	transcript show: (aRide rideDetails).
	transcript show: '---------------------------'; cr.
	
	driver1 addRide: aRide.
	rider1 requestRide: aRide.
].

"4. Display final information"
transcript cr; show: '--- Final System State ---'; cr; cr.
transcript show: (driver1 getDriverInfo).
transcript show: (rider1 viewRides).

transcript show: '--- System Test Complete ---'; cr.
```

3. **Execute the code:**
   - Select all text in the Workspace
   - Press **Alt+D** (Windows/Linux) or **Cmd+D** (Mac) to "Do it"
   - Or right-click and select **Do it**

4. **View the output:**
   - Open the **Transcript** window to see the results
   - In Pharo: **Tools** → **Transcript**
   - In Squeak: **Tools** → **Transcript**

#### Sample Output
```
--- System Test Starting ---

--- Processing All Rides Polymorphically ---

--- Standard Ride ---
  Ride ID: S1001
  From: 123 Main St
  To: 456 Oak Ave
  Distance: 5.0 miles
  Fare: $7.50
---------------------------
--- Premium Ride ---
  Ride ID: P1002
  From: 789 Pine Ln
  To: 321 Maple Dr
  Distance: 12.0 miles
  Fare: $36.00
  (Includes premium service)
---------------------------
--- Standard Ride ---
  Ride ID: S1003
  From: 321 Maple Dr
  To: 123 Main St
  Distance: 3.0 miles
  Fare: $4.50
---------------------------

--- Final System State ---

===========================
Driver Info:
Name: James (ID: D101)
Rating: 4.8 / 5.0
Completed Rides: 3
Total Earnings: $48.00
===========================
===========================
Rider History for: Kate
Total Rides: 3
---------------------------
  - Ride ID: S1001, Fare: $7.50
  - Ride ID: P1002, Fare: $36.00
  - Ride ID: S1003, Fare: $4.50
===========================
--- System Test Complete ---
```

## Code Optimizations

### C++ Optimizations
- **Const correctness**: Methods that don't modify state are marked `const`
- **Const references**: Constructor parameters use `const&` to avoid unnecessary copies
- **Modern C++**: Uses `= default` for destructors, `constexpr` for compile-time constants
- **STL algorithms**: Uses `std::max` for cleaner code
- **Initializer lists**: Vector initialization uses brace initialization
- **Auto type deduction**: Uses `auto*` for cleaner iterator declarations

### Smalltalk Optimizations
- **Idiomatic Smalltalk**: Follows standard Smalltalk conventions and patterns
- **Efficient collections**: Uses `OrderedCollection` for dynamic collections
- **Stream-based output**: Uses `streamContents:` for efficient string building

## Project Structure

```
Assignment 5/
├── Readme.md          # This file
├── RideShare.cpp      # C++ implementation
└── RideShare.st       # Smalltalk implementation
```

## Technical Details

### C++ Implementation
- **Standard**: C++17
- **Key Features**: Virtual functions, abstract base class, polymorphism via pointers
- **Memory Management**: Stack-allocated objects with pointer references

### Smalltalk Implementation
- **Environment**: Compatible with Pharo, Squeak, and similar Smalltalk environments
- **Key Features**: Message passing, dynamic dispatch, pure OOP paradigm
- **Package**: `RideSharing`

## Fare Calculation

- **StandardRide**: `$1.50 × distance`
- **PremiumRide**: `max($3.00 × distance, $10.00)`

## Author

Abhishek Vishwakarma
