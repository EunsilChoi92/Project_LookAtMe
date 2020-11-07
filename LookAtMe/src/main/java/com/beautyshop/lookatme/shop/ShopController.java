package com.beautyshop.lookatme.shop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.beautyshop.lookatme.Const;
import com.beautyshop.lookatme.SecurityUtils;
import com.beautyshop.lookatme.ViewRef;
import com.beautyshop.lookatme.model.CodeVO;
import com.beautyshop.lookatme.shop.model.ShopDMI;
import com.beautyshop.lookatme.shop.model.ShopPARAM;
import com.beautyshop.lookatme.shop.model.ShopPicVO;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	ShopService shopService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) {
		model.addAttribute("shopList", shopService.selShopList());
		model.addAttribute(Const.TITLE, "예뻐지기 위한 놀이터 LookAtMe");
		model.addAttribute(Const.VIEW, "shop/shopList");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value = "/regMod", method = RequestMethod.GET)
	public String shopRegMod(Model model) {
		model.addAttribute("categoryList", shopService.selCategoryList());
		model.addAttribute(Const.TITLE, "등록");
		model.addAttribute(Const.VIEW, "shop/shopRegMod");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value="/regMod", method = RequestMethod.POST)
	public String shopRegMod(ShopPARAM param, HttpSession hs) {
		shopService.insShop(param);
		System.out.println("누구 ?  : " + param.getI_user());
		System.out.println("샵이름 ? : " + param.getShop());
		return "redirect:/shop/main";
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String shopDetail(Model model, ShopPARAM param, HttpServletRequest req) {
		int i_user = SecurityUtils.getLoginUserPk(req);
		param.setI_user(i_user);
		
		ShopDMI shopDetail = shopService.selShop(param);
		List<ShopPicVO> shopPicList = shopService.selShopPicList(param);
		
		model.addAttribute(Const.TITLE, "상세보기");
		model.addAttribute(Const.VIEW, "shop/shopDetail");
		
		model.addAttribute("shopDetail", shopDetail);
		model.addAttribute("shopPicList", shopPicList);
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	
	
	
}
