package com.beautyshop.lookatme.shop;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.beautyshop.lookatme.Const;
import com.beautyshop.lookatme.ViewRef;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	ShopService shopService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) {
		model.addAttribute(Const.TITLE, "예뻐지기 위한 놀이터 LookAtMe");
		model.addAttribute(Const.VIEW, "shop/shopList");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value = "/regMod", method = RequestMethod.GET)
	public String shopRegMod(Model model) {
		model.addAttribute(Const.TITLE, "등록");
		model.addAttribute(Const.VIEW, "shop/shopRegMod");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String shopDetail(Model model) {
		model.addAttribute(Const.TITLE, "상세보기");
		model.addAttribute(Const.VIEW, "shop/shopDetail");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	
	
	
}
