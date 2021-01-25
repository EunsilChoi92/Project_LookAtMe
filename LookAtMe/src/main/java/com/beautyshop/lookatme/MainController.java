package com.beautyshop.lookatme;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.beautyshop.lookatme.location.LocationService;
import com.beautyshop.lookatme.location.LocationUtils;
import com.beautyshop.lookatme.location.model.LocationDMI;

@Controller
public class MainController {
	
	@Autowired
	private LocationService locationService; 
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String main(HttpServletRequest request) {
		if(Const.realPath == null) {
			Const.realPath = request.getServletContext().getRealPath("");
		}
		if(LocationUtils.locationList == null) {
			LocationUtils.locationList = locationService.selLocation();
		}
		System.out.println("root");
		return "redirect:/shop/main";
	}

}
