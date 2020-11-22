package com.beautyshop.lookatme.location;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beautyshop.lookatme.location.model.LocationDMI;
import com.beautyshop.lookatme.location.model.LocationVO;

@Controller
@RequestMapping("/location")
public class LocationController {
	@Autowired
	LocationService locationService;
	
	@RequestMapping("/ajaxSelSigungu")
	@ResponseBody
	public List<LocationDMI> ajaxSelSigungu(LocationVO param) {
		List<LocationDMI> locationList = locationService.selLocationCategory(param);
		return locationList;
	}
}
