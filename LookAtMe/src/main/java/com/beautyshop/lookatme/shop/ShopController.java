package com.beautyshop.lookatme.shop;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.beautyshop.lookatme.Const;
import com.beautyshop.lookatme.SecurityUtils;
import com.beautyshop.lookatme.ViewRef;
import com.beautyshop.lookatme.comment.CommentService;
import com.beautyshop.lookatme.comment.model.CommentDMI;
import com.beautyshop.lookatme.shop.model.ShopDMI;
import com.beautyshop.lookatme.shop.model.ShopPARAM;
import com.beautyshop.lookatme.shop.model.ShopPicVO;

import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/shop")
@Slf4j
public class ShopController {

	@Autowired
	ShopService shopService;
	
	@Autowired
	CommentService commentService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model) {
		model.addAttribute("shopList", shopService.selShopList());
		model.addAttribute(Const.TITLE, "예뻐지기 위한 놀이터 LookAtMe");
		model.addAttribute(Const.VIEW, "shop/shopList");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value = "/regMod", method = RequestMethod.GET)
	public String shopRegMod(Model model, ShopPARAM param) {
		if(param.getI_shop() != 0) {
			List<ShopPicVO> shopPicList = shopService.selShopPicList(param);
			model.addAttribute("shopInfo", shopService.selShop(param));
			model.addAttribute("shopPicList", shopPicList);
		}
		model.addAttribute("categoryList", shopService.selCategoryList());
		model.addAttribute(Const.TITLE, "등록");
		model.addAttribute(Const.VIEW, "shop/shopRegMod");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value="/regMod", method = RequestMethod.POST)
	public String shopRegMod(ShopPARAM param, RedirectAttributes ra, MultipartHttpServletRequest mReq) {
		int i_shop = shopService.regModShop(param, mReq);
		ra.addAttribute("i_shop", i_shop);
		return "redirect:/shop/detail";
	}
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String shopDetail(Model model, ShopPARAM param, HttpServletRequest req) {
		
		ShopDMI shopDetail = shopService.selShop(param);
		List<ShopPicVO> shopPicList = shopService.selShopPicList(param);
		List<CommentDMI> commentList = commentService.selCommentList(param);
		
		model.addAttribute(Const.TITLE, "상세보기");
		model.addAttribute(Const.VIEW, "shop/shopDetail");
		
		model.addAttribute("shopDetail", shopDetail);
		model.addAttribute("shopPicList", shopPicList);
		model.addAttribute("commentList", commentList);
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value = "/delShop", method = RequestMethod.GET)
	public String delShop(ShopPARAM param, HttpServletRequest req) {
		param.setI_user(SecurityUtils.getLoginUserPk(req));
		shopService.delShop(param);
		return "redirect:/";
	}
	
	@RequestMapping(value="/ajaxDelShopPic", method = RequestMethod.GET)
	@ResponseBody
	public int ajaxDelShopPic(ShopPARAM param, HttpServletRequest req) {
		param.setI_user(SecurityUtils.getLoginUserPk(req));
		return shopService.ajaxDelShopPic(param);
	}
	
	@RequestMapping(value="/ajaxSelShopPic", method = RequestMethod.GET)
	@ResponseBody
	public List<ShopPicVO> ajaxSelShopPic(ShopPARAM param, HttpServletRequest req) {
		param.setI_user(SecurityUtils.getLoginUserPk(req));
		return shopService.selShopPicList(param);
	}
}
