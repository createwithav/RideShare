#include <iostream>
#include <vector>
#include <string>
#include <iomanip>
#include <algorithm>

class Ride {
protected:
    std::string rideID;
    std::string pickupLocation;
    std::string dropoffLocation;
    double distance;
    double fare;

public:
    Ride(const std::string& id, const std::string& pickup, const std::string& dropoff, double dist)
        : rideID(id), pickupLocation(pickup), dropoffLocation(dropoff), distance(dist), fare(0.0) {}

    virtual ~Ride() = default;

    virtual void calculateFare() = 0;

    virtual void rideDetails() const {
        std::cout << "  Ride ID: " << rideID << "\n"
                  << "  From: " << pickupLocation << "\n"
                  << "  To: " << dropoffLocation << "\n"
                  << "  Distance: " << distance << " miles\n"
                  << "  Fare: $" << std::fixed << std::setprecision(2) << fare << "\n";
    }

    double getFare() const { return fare; }
    std::string getID() const { return rideID; }
};

class StandardRide : public Ride {
private:
    static constexpr double RATE_PER_MILE = 1.50;

public:
    StandardRide(const std::string& id, const std::string& pickup, const std::string& dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    void calculateFare() override {
        fare = distance * RATE_PER_MILE;
    }

    void rideDetails() override {
        std::cout << "--- Standard Ride ---\n";
        Ride::rideDetails();
    }
};

class PremiumRide : public Ride {
private:
    static constexpr double RATE_PER_MILE = 3.00;
    static constexpr double MINIMUM_FARE = 10.0;

public:
    PremiumRide(const std::string& id, const std::string& pickup, const std::string& dropoff, double dist)
        : Ride(id, pickup, dropoff, dist) {}

    void calculateFare() override {
        fare = std::max(distance * RATE_PER_MILE, MINIMUM_FARE);
    }

    void rideDetails() override {
        std::cout << "--- Premium Ride ---\n";
        Ride::rideDetails();
        std::cout << "  (Includes premium service)\n";
    }
};

class Driver {
private:
    std::string driverID;
    std::string name;
    double rating;
    std::vector<Ride*> assignedRides;

public:
    Driver(const std::string& id, const std::string& n, double r)
        : driverID(id), name(n), rating(r) {}

    void addRide(Ride* ride) {
        assignedRides.push_back(ride);
    }

    void getDriverInfo() const {
        std::cout << "===========================\n"
                  << "Driver Info:\n"
                  << "Name: " << name << " (ID: " << driverID << ")\n"
                  << "Rating: " << rating << " / 5.0\n"
                  << "Completed Rides: " << assignedRides.size() << "\n";

        double totalEarnings = 0.0;
        for (const auto* r : assignedRides) {
            totalEarnings += r->getFare();
        }
        std::cout << "Total Earnings: $" << std::fixed << std::setprecision(2) << totalEarnings << "\n"
                  << "===========================\n";
    }
};

class Rider {
private:
    std::string riderID;
    std::string name;
    std::vector<Ride*> requestedRides;

public:
    Rider(const std::string& id, const std::string& n) : riderID(id), name(n) {}

    Ride* requestRide(Ride* ride) {
        requestedRides.push_back(ride);
        return ride;
    }

    void viewRides() const {
        std::cout << "===========================\n"
                  << "Rider History for: " << name << "\n"
                  << "Total Rides: " << requestedRides.size() << "\n"
                  << "---------------------------\n";
        for (const auto* r : requestedRides) {
            std::cout << "  - Ride ID: " << r->getID()
                      << ", Fare: $" << std::fixed << std::setprecision(2) << r->getFare() << "\n";
        }
        std::cout << "===========================\n";
    }
};

int main() {
    Driver driver1("D101", "James", 4.8);
    Rider rider1("R201", "Kate");

    StandardRide ride1("S1001", "123 Main St", "456 Oak Ave", 5.0);
    PremiumRide ride2("P1002", "789 Pine Ln", "321 Maple Dr", 12.0);
    StandardRide ride3("S1003", "321 Maple Dr", "123 Main St", 3.0);

    std::vector<Ride*> allRides = {&ride1, &ride2, &ride3};

    std::cout << "--- Processing All Rides Polymorphically ---\n" << std::endl;

    for (auto* r : allRides) {
        r->calculateFare();
        r->rideDetails();
        std::cout << "---------------------------\n";

        driver1.addRide(r);
        rider1.requestRide(r);
    }

    std::cout << "\n--- Final System State ---\n" << std::endl;
    driver1.getDriverInfo();
    rider1.viewRides();

    return 0;
}
