package project;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
public class Network {
    private final List<Antenna> antennas;  // List of antennas in the network

    // Constructor to initialize the network with an empty list of antennas
    public Network() {
        this.antennas = new ArrayList<>();
    }

    // Method to add a new antenna to the network
    public boolean addAntenna(Antenna newAntenna) {
        if (antennas.isEmpty()) {
            antennas.add(newAntenna);  // Add the first antenna if the list is empty
            return true;
        }

        // Check if the new antenna overlaps with any existing antennas in the network
        for (Antenna antenna : antennas) {
            if (newAntenna.overlapsWith(antenna)) {
                antennas.add(newAntenna);  // Add the new antenna if it overlaps
                return true;
            }
        }
        return false;  // Return false if no overlap is found
    }

    // Method to find the nearest available antenna to a given location (x, y)
    public Optional<Antenna> findNearestAvailableAntenna(double x, double y) {
        Antenna nearestAntenna = null;
        double minDistance = Double.MAX_VALUE;

        // Iterate through all antennas to find the nearest one within range
        for (Antenna antenna : antennas) {
            if (antenna.isInRange(x, y) && antenna.canAcceptNewCall()) {
                double distance = antenna.getDistanceTo(x, y);
                if (distance < minDistance) {
                    minDistance = distance;
                    nearestAntenna = antenna;  // Set the nearest antenna
                }
            }
        }

        return Optional.ofNullable(nearestAntenna);  // Return the nearest available antenna, or empty if none found
    }
}
