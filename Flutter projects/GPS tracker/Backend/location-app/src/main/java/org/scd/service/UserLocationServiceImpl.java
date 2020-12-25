package org.scd.service;

import org.scd.config.exception.BusinessException;
import org.scd.model.UserLocation;
import org.scd.model.dto.UserLocationDTO;
import org.scd.model.dto.UserLocationFilterDTO;
import org.scd.repository.UserLocationRepository;
import org.scd.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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

    public UserLocation getLocationById(int id) {
        return userLocationRepository.getById(Long.valueOf(id));
    }

    public List<UserLocation> getLocationsByUserId(Long userId) {
        return userLocationRepository.getByUserId(userId);
    }

    public List<UserLocation> getLocationsByUserIdAndDate(UserLocationFilterDTO userLocationFilterDTO) throws BusinessException {
        if (userLocationFilterDTO.getStartDate().compareTo(userLocationFilterDTO.getEndDate()) > 0)
            throw new BusinessException(403, "start date can't be greater than end date");
        return userLocationRepository.customQuery(userLocationFilterDTO.getUserId(),userLocationFilterDTO.getStartDate(),userLocationFilterDTO.getEndDate());
    }
}