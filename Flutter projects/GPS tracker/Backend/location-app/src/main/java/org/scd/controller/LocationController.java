package org.scd.controller;

import org.scd.model.dto.UserLocationDTO;
import org.scd.service.UserLocationServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController()
public class LocationController {
    private final UserLocationServiceImpl userLocationServiceImpl;

    @Autowired
    public LocationController(UserLocationServiceImpl userLocationServiceImpl) {
        this.userLocationServiceImpl = userLocationServiceImpl;
    }

    @PostMapping(path="/locations")
    public ResponseEntity<UserLocationDTO> addPosition(@RequestBody final UserLocationDTO userLocationDTO) {
        return ResponseEntity.ok(userLocationServiceImpl.addLocation(userLocationDTO));
    }
}