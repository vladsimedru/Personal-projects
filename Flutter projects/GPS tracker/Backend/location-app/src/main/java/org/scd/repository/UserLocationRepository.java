package org.scd.repository;

import org.scd.model.UserLocation;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import java.util.Date;
import java.util.List;

public interface UserLocationRepository extends CrudRepository<UserLocation,Long> {
    UserLocation getById(final Long id);

    List<UserLocation> getByUserId(final Long userId);

    @Query(value="SELECT * FROM user_location WHERE user_id=?1 AND date>=?2 AND date<=?3",nativeQuery = true)
    List<UserLocation> customQuery(final Long userId,final Date startDate,final Date endDate);

    void deleteById(final Long id);
}
