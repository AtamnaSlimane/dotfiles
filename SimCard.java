package project;

public class SimCard {
    private final String phoneNumber; // Unique phone number assigned to this SIM card
    private double credit; // Amount of credit available for calls
    private boolean isActive; // Whether the SIM card is active or not

    public SimCard(String phoneNumber, double initialCredit) {
        this.phoneNumber = phoneNumber;
        this.credit = initialCredit;
        this.isActive = false; // Default state is inactive
    }

    public void activate() {
        // Activate the SIM card
        this.isActive = true;
    }

    public boolean hasSufficientCredit(double requiredAmount) {
        // Check if there is enough credit for a specific action
        return credit >= requiredAmount;
    }

    public boolean deductCredit(double amount) {
        // Deduct the specified amount of credit if sufficient
        if (hasSufficientCredit(amount)) {
            credit -= amount;
            return true;
        }
        return false;
    }

    public String getPhoneNumber() {
        // Retrieve the phone number associated with this SIM card
        return phoneNumber;
    }

    public boolean isActive() {
        // Check if the SIM card is currently active
        return isActive;
    }

    public double getCredit() {
        // Get the remaining credit on the SIM card
        return credit;
    }
}
