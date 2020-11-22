package com.beautyshop.lookatme.location;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beautyshop.lookatme.location.model.LocationDMI;

@Service
public class LocationService {
	
	@Autowired
	private LocationMapper locationMapper;
	
	public List<LocationDMI> selLocation() {
		return locationMapper.selLocation();
	}
}
