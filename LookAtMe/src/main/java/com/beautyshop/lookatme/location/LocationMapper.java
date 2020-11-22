package com.beautyshop.lookatme.location;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.beautyshop.lookatme.location.model.LocationDMI;
import com.beautyshop.lookatme.location.model.LocationVO;

@Mapper
public interface LocationMapper {
	List<LocationDMI> selLocation();

	List<LocationDMI> selLocationCategory(LocationVO param);
}
