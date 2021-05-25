package com.globomantics.globoscript.dao;

import com.globomantics.globoscript.domain.UserLocation;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class InMemoryLocationDataStore implements LocationDataStore {
    Map<String, UserLocation> locations = new HashMap<>();

    @Override
    public List<UserLocation> getUserLocations() {
        return List.copyOf(locations.values());
    }

    @Override
    public void updateUserLocation(UserLocation location) {
        locations.put(location.getUsername(), location);
    }

    @Override
    public void logoffUserLocation(String uid) {
        locations.remove(uid);
    }
}
