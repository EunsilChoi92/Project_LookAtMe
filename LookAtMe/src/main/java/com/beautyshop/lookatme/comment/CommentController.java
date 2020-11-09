package com.beautyshop.lookatme.comment;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beautyshop.lookatme.SecurityUtils;
import com.beautyshop.lookatme.comment.model.CommentDMI;
import com.beautyshop.lookatme.comment.model.CommentVO;
import com.beautyshop.lookatme.shop.model.ShopPARAM;

@Controller
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	@RequestMapping("/ajaxSelComment")
	@ResponseBody
	public CommentDMI ajaxSelComment(CommentVO param) {
		return commentService.ajaxSelComment(param);
	}
	
	@RequestMapping("/regModComment")
	public String regModComment(Model model, CommentVO param, HttpSession hs) {
		param.setI_user(SecurityUtils.getLoginUserPk(hs));
		commentService.regModComment(param);
		
		model.addAttribute("i_shop", param.getI_shop());
		return "redirect:/shop/detail";
	}
	
	@RequestMapping("/ajaxDelComment")
	@ResponseBody
	public int ajaxDelComment(ShopPARAM param, HttpSession hs) {
		param.setI_user(SecurityUtils.getLoginUserPk(hs));
		System.out.println(param.getI_shop());
		System.out.println(param.getI_comment());
		System.out.println(param.getI_user());
		return commentService.ajaxDelComment(param);
	}
}
