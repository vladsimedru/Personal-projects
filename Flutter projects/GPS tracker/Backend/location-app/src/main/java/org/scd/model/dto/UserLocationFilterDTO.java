package org.scd.model.dto;

import java.text.DateFormat;
import java.time.LocalDate;
import java.util.Date;

public class UserLocationFilterDTO {
    Long userId;

    Date startDate;

    Date endDate;

    public UserLocationFilterDTO() {
    }

    public UserLocationFilterDTO(Long userId) {
        this.userId = userId;
    }

    public UserLocationFilterDTO(Long userId, Date startDate, Date endDate) {
        this.userId = userId;
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
