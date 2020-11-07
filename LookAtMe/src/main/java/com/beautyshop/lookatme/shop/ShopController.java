package com.beautyshop.lookatme.shop;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.beautyshop.lookatme.Const;
import com.beautyshop.lookatme.ViewRef;

@Controller
@RequestMapping("/shop")
public class ShopController {

	// @Autowired
	
	@RequestMapping("/main")
	public String main(Model model) {
		model.addAttribute(Const.TITLE, "예뻐지기 위한 놀이터 LookAtMe");
		model.addAttribute(Const.VIEW, "shop/shopList");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	
}
