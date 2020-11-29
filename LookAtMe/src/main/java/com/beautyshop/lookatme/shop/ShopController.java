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
import com.beautyshop.lookatme.location.LocationService;
import com.beautyshop.lookatme.location.model.LocationVO;
import com.beautyshop.lookatme.shop.model.ShopDMI;
import com.beautyshop.lookatme.shop.model.ShopPARAM;
import com.beautyshop.lookatme.shop.model.ShopPicVO;

@Controller
@RequestMapping("/shop")
public class ShopController {

	@Autowired
	ShopService shopService;
	
	@Autowired
	CommentService commentService;
	
	@Autowired
	LocationService locationService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(Model model, ShopPARAM param) {
		model.addAttribute("shopList", shopService.selShopList(param));
		model.addAttribute("locationCategory", locationService.selLocationCategory(new LocationVO()));
		model.addAttribute("categoryList", shopService.selCategoryList());
		model.addAttribute(Const.TITLE, "");
		model.addAttribute(Const.VIEW, "shop/shopList");
		
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public String main(ShopPARAM param, RedirectAttributes ra) {
		ra.addAttribute("cd_sido", param.getCd_sido());
		ra.addAttribute("cd_sigungu", param.getCd_sigungu());
		ra.addAttribute("cd_category", param.getCd_category());
		return "redirect:/shop/main";
	}
	
	@RequestMapping(value = "/regMod", method = RequestMethod.GET)
	public String shopRegMod(Model model, ShopPARAM param) {
		if(param.getI_shop() != 0) {
			List<ShopPicVO> shopPicList = shopService.selShopPicList(param);
			ShopDMI shopInfo = shopService.selShop(param);
			String addr = String.format("%s %s %s"
					, shopInfo.getSido(), shopInfo.getSigungu()
					, shopInfo.getRest_addr());
			shopInfo.setAddr(addr);
			model.addAttribute("shopInfo", shopInfo);
			model.addAttribute("shopPicList", shopPicList);
		}
		model.addAttribute("categoryList", shopService.selCategoryList());
		model.addAttribute(Const.TITLE, " 글등록");
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
		param.setI_user(SecurityUtils.getLoginUserPk(req));
	
		ShopDMI shopDetail = shopService.selShop(param);
		List<ShopPicVO> shopPicList = shopService.selShopPicList(param);
		List<CommentDMI> commentList = commentService.selCommentList(param);
		
		model.addAttribute(Const.TITLE, " 상세보기");
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
	
	@RequestMapping(value="/ajaxLikeShop", method = RequestMethod.GET)
	@ResponseBody
	public int ajaxLikeShop(ShopPARAM param, HttpServletRequest req) {
		param.setI_user(SecurityUtils.getLoginUserPk(req));
		return shopService.ajaxLikeShop(param);
	}
	
	@RequestMapping(value="/favoriteList", method=RequestMethod.GET)
	public String likeLikst(Model model, ShopPARAM param, HttpServletRequest req) {
		model.addAttribute(Const.TITLE, " 관심 목록 리스트");
		model.addAttribute(Const.VIEW, "shop/shopFavoriteList");
		
		param.setI_user(SecurityUtils.getLoginUserPk(req));
		List<ShopDMI> favoriteList = shopService.selShopFavoriteList(param);
		model.addAttribute("favoriteList", favoriteList);
		return ViewRef.TEMP_DEFAULT;
	}
}
