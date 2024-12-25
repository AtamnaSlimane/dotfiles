package project;

import java.util.Optional;
public class Phone {
    private double x;  // Current x-coordinate of the phone
    private double y;  // Current y-coordinate of the phone
    private double batteryLevel;  // Battery level of the phone
    private SimCard simCard;  // SIM card inserted into the phone
    private boolean isInCall;  // Indicates whether the phone is currently in a call
    private Antenna connectedAntenna;  // The antenna to which the phone is connected during the call

    // Constructor to initialize the phone with location and battery level
    public Phone(double x, double y, double batteryLevel) {
        this.x = x;
        this.y = y;
        this.batteryLevel = batteryLevel;
        this.isInCall = false;  // Initially, the phone is not in a call
    }

    // Method to insert a SIM card into the phone
    public void insertSim(SimCard simCard) {
        this.simCard = simCard;
    }

    // Method to set the phone's location
    public void setLocation(double x, double y) {
        this.x = x;
        this.y = y;
    }

    // Method to check if the phone has sufficient battery to make a call
    private boolean hasSufficientBattery() {
        return batteryLevel > 10;  // Returns true if battery is above 10%
    }

    // Method to check if the phone can make a call based on various conditions
    public String canMakeCall(Network network) {
        if (!hasSufficientBattery()) {
            return "Insufficient battery";  // Return error if the battery is low
        }
        if (simCard == null || !simCard.isActive()) {
            return "No active SIM card";  // Return error if the SIM card is not active
        }
        if (!simCard.hasSufficientCredit(1)) {
            return "Insufficient credit";  // Return error if there is insufficient credit
        }
        if (isInCall) {
            return "Already in a call";  // Return error if the phone is already in a call
        }

        // Try to find the nearest available antenna for the call
        Optional<Antenna> nearestAntenna = network.findNearestAvailableAntenna(x, y);
        if (nearestAntenna.isEmpty()) {
            return "No available antenna in range";  // Return error if no antenna is in range
        }

        return null; // null means the phone can make the call (no error)
    }

    // Method to check if the phone can receive a call
    public String canReceiveCall(Network network) {
        if (!hasSufficientBattery()) {
            return "Insufficient battery";  // Return error if the battery is low
        }
        if (isInCall) {
            return "Already in a call";  // Return error if the phone is already in a call
        }

        // Try to find the nearest available antenna to receive the call
        Optional<Antenna> nearestAntenna = network.findNearestAvailableAntenna(x, y);
        if (nearestAntenna.isEmpty()) {
            return "No available antenna in range";  // Return error if no antenna is in range
        }

        return null; // null means the phone can receive the call (no error)
    }

    // Method to start a call if possible
    public String startCall(Network network) {
        String callError = canMakeCall(network);
        if (callError != null) {
            return callError;  // Return any errors that occurred while checking if the call can be made
        }

        // Try to find the nearest available antenna and initiate the call
        Optional<Antenna> nearestAntenna = network.findNearestAvailableAntenna(x, y);
        if (nearestAntenna.isPresent() && nearestAntenna.get().incrementActiveCalls()) {
            isInCall = true;
            connectedAntenna = nearestAntenna.get();  // Set the connected antenna for the call
            return "Call started successfully";  // Return success message
        }
        return "Failed to connect to antenna";  // Return failure message if the antenna cannot accept the call
    }

    // Method to end the ongoing call
    public void endCall() {
        if (isInCall && connectedAntenna != null) {
            connectedAntenna.decrementActiveCalls();  // Decrease the number of active calls on the antenna
            isInCall = false;
            connectedAntenna = null;  // Disconnect from the antenna
        }
    }

    // Method to update the phone's location during an ongoing call
    public String updateLocationDuringCall(double newX, double newY, Network network) {
        double oldX = this.x;
        double oldY = this.y;
        this.x = newX;
        this.y = newY;

        if (isInCall) {
            // Check if the new location is still within the range of the connected antenna
            if (!connectedAntenna.isInRange(newX, newY)) {
                // If not, find a new antenna in the new location
                Optional<Antenna> newAntenna = network.findNearestAvailableAntenna(newX, newY);
                if (newAntenna.isEmpty()) {
                    endCall();  // End the call if no antenna is found
                    return "Call disconnected: Out of network coverage";  // Return message if out of coverage
                }

                // Move to the new antenna
                connectedAntenna.decrementActiveCalls();
                if (newAntenna.get().incrementActiveCalls()) {
                    connectedAntenna = newAntenna.get();  // Switch to the new antenna
                    return "Call continues: Switched to new antenna";  // Return message if the call continues
                } else {
                    endCall();  // End the call if the new antenna cannot accept the call
                    return "Call disconnected: Handover failed";  // Return message if handover fails
                }
            }
        }
        return "Location updated successfully";  // Return success message if location is updated without issues
    }
}
