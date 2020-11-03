package org.scd.repository;

import org.scd.model.UserLocation;
import org.springframework.data.repository.CrudRepository;

public interface UserLocationRepository extends CrudRepository<UserLocation,Long> {
}
