package com.beautyshop.lookatme.location;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.beautyshop.lookatme.location.model.LocationDMI;

@Mapper
public interface LocationMapper {
	List<LocationDMI> selLocation();
}
