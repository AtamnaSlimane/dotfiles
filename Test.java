package project;

public class Test {
    public static void main(String[] args) {
        // Create network and antennas
        Network network = new Network();
        Antenna antenna1 = new Antenna(0, 0, 100, 2); // capacity 2 calls
        Antenna antenna2 = new Antenna(50, 50, 100, 1); // capacity 1 call
        network.addAntenna(antenna1);
        network.addAntenna(antenna2);

        // Create phones and SIM cards
        SimCard simCard1 = new SimCard("1234567890", 20);
        simCard1.activate();
        SimCard simCard2 = new SimCard("0987654321", 10);
        simCard2.activate();

        Phone phone1 = new Phone(10, 10, 50);  // Phone 1 in range of antenna1
        Phone phone2 = new Phone(60, 60, 50);  // Phone 2 in range of antenna2

        // Insert SIM cards
        phone1.insertSim(simCard1);
        phone2.insertSim(simCard2);

        // Test case 1: Phone 1 making a call
        System.out.println("Phone 1 trying to make a call: " + phone1.startCall(network));

        // Test case 2: Phone 2 trying to make a call with insufficient credit
        System.out.println("Phone 2 trying to make a call (insufficient credit): " + phone2.startCall(network));

        // Test case 3: Phone 1 trying to make a call with low battery
        phone1 = new Phone(10, 10, 5);  // low battery
        phone1.insertSim(simCard1);
        System.out.println("Phone 1 trying to make a call (low battery): " + phone1.startCall(network));

        // Test case 4: Phone 1 trying to receive a call
        phone1 = new Phone(10, 10, 50);  // enough battery
        phone1.insertSim(simCard1);
        System.out.println("Phone 1 trying to receive a call: " + phone1.canReceiveCall(network));

        // Test case 5: Phone 1 moving out of range during a call
        phone1 = new Phone(10, 10, 50);  // Phone 1 within range initially
        phone1.insertSim(simCard1);
        phone1.startCall(network);
        System.out.println("Phone 1 moves out of range: " + phone1.updateLocationDuringCall(200, 200, network));

        // Test case 6: Phone 2 trying to make a call when antenna is at full capacity
        phone2 = new Phone(60, 60, 50);  // Phone 2 in range of antenna2 (capacity 1)
        phone2.insertSim(simCard2);
        phone2.startCall(network);
        Phone phone3 = new Phone(65, 65, 50);  // Another phone trying to use the same antenna
        SimCard simCard3 = new SimCard("1112223333", 20);
        simCard3.activate();
        phone3.insertSim(simCard3);
        System.out.println("Phone 3 trying to make a call when antenna is full: " + phone3.startCall(network));

        // Test case 7: Phone 1 successfully receiving a call while on the move
        phone1 = new Phone(10, 10, 50);
        phone1.insertSim(simCard1);
        System.out.println("Phone 1 trying to receive a call: " + phone1.canReceiveCall(network));
        phone1.updateLocationDuringCall(30, 30, network);  // Move to new location within range
        System.out.println("Phone 1 moves to a new location within range: " + phone1.updateLocationDuringCall(30, 30, network));

        // Test case 8: Phone 1 moving out of range during a call
        phone1 = new Phone(10, 10, 50);
        phone1.insertSim(simCard1);
        phone1.startCall(network);
        System.out.println("Phone 1 starts call: " + phone1.startCall(network));
        phone1.updateLocationDuringCall(200, 200, network);  // Move out of range
        System.out.println("Phone 1 moves out of range during call: " + phone1.updateLocationDuringCall(200, 200, network));
    }
}

