package com.globomantics.globoscript.dao;

import com.globomantics.globoscript.domain.UserLocation;

import java.util.List;

public interface LocationDataStore {
    List<UserLocation> getUserLocations();
    void updateUserLocation(UserLocation location);
    void logoffUserLocation(String uid);
}
