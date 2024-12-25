package project;

public class Antenna {
    private final double x; // X-coordinate of the antenna's location
    private final double y; // Y-coordinate of the antenna's location
    private final double coverageRadius; // Radius within which the antenna provides signal
    private final int capacity; // Maximum number of simultaneous calls the antenna can handle
    private int activeCalls; // Number of currently active calls on this antenna

    public Antenna(double x, double y, double coverageRadius, int capacity) {
        this.x = x;
        this.y = y;
        this.coverageRadius = coverageRadius;
        this.capacity = capacity;
        this.activeCalls = 0; // Initialize with no active calls
    }

    public boolean isInRange(double phoneX, double phoneY) {
        // Check if a phone at (phoneX, phoneY) is within the antenna's coverage radius
        double distance = calculateDistance(phoneX, phoneY, this.x, this.y);
        return distance <= coverageRadius;
    }

    private double calculateDistance(double x1, double y1, double x2, double y2) {
        // Calculate Euclidean distance between two points (x1, y1) and (x2, y2)
        return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
    }

    public boolean incrementActiveCalls() {
        // Increment active calls if capacity is not exceeded
        if (canAcceptNewCall()) {
            activeCalls++;
            return true;
        }
        return false;
    }

    public void decrementActiveCalls() {
        // Decrement the number of active calls if greater than zero
        if (activeCalls > 0) {
            activeCalls--;
        }
    }

    public boolean canAcceptNewCall() {
        // Check if the antenna can handle more calls
        return activeCalls < capacity;
    }

    public boolean overlapsWith(Antenna other) {
        // Determine if the coverage of this antenna overlaps with another antenna
        double maxDistance = this.coverageRadius + other.coverageRadius;
        double actualDistance = calculateDistance(this.x, this.y, other.x, other.y);
        return actualDistance <= maxDistance;
    }

    public double getDistanceTo(double phoneX, double phoneY) {
        // Get the distance from the antenna to a phone's location
        return calculateDistance(phoneX, phoneY, this.x, this.y);
    }
}
