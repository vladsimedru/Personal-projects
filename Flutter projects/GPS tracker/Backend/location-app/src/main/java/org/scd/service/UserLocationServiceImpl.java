package org.scd.service;

import org.scd.model.UserLocation;
import org.scd.model.dto.UserLocationDTO;
import org.scd.repository.UserLocationRepository;
import org.scd.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserLocationServiceImpl implements UserLocationService{

    @Autowired
    private UserLocationRepository userLocationRepository;

    @Autowired
    private UserRepository userRepository;


    @Override
    public UserLocationDTO addLocation(UserLocationDTO userLocationDTO) {
        userLocationRepository.save(new UserLocation(userLocationDTO.getLatitude(),userLocationDTO.getLongitude(),userLocationDTO.getDate(),userRepository.findByEmail(userLocationDTO.getEmail())));
        return null;
    }
}