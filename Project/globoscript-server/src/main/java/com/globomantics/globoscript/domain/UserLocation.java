package com.globomantics.globoscript.domain;

public class UserLocation {
    String username;
    double longitude;
    double latitude;

    public UserLocation(String username, double longitude, double latitude) {
        this.username = username;
        this.longitude = longitude;
        this.latitude = latitude;
    }

    public String getUsername() {
        return username;
    }

    public double getLongitude() {
        return longitude;
    }

    public double getLatitude() {
        return latitude;
    }
}
