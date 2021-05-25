package com.globomantics.globoscript.controller;

import com.globomantics.globoscript.dao.LocationDataStore;
import com.globomantics.globoscript.domain.UserLocation;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("userLocation")
@CrossOrigin
public class LocationServer {

    final LocationDataStore dao;

    public LocationServer(LocationDataStore dao) {
        this.dao = dao;
    }

    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public List<UserLocation> courses() {
        return dao.getUserLocations();
    }

    @PutMapping(consumes = MediaType.APPLICATION_JSON_VALUE)
    public void lessons(@RequestBody UserLocation location) {
        dao.updateUserLocation(location);
    }

    @DeleteMapping("{uid}")
    public void lessons(@PathVariable String uid) {
        dao.logoffUserLocation(uid);
    }

}