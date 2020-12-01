package com.beautyshop.lookatme.comment;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.beautyshop.lookatme.SecurityUtils;
import com.beautyshop.lookatme.comment.model.CommentDMI;
import com.beautyshop.lookatme.comment.model.CommentPARAM;

@Controller
@RequestMapping("/comment")
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	@RequestMapping("/ajaxSelCommentList")
	@ResponseBody
	public List<CommentDMI> ajaxSelCommentList(CommentPARAM param) {
		return commentService.selCommentList(param);
	}
	
	@RequestMapping("/ajaxSelComment")
	@ResponseBody
	public CommentDMI ajaxSelComment(CommentPARAM param) {
		return commentService.ajaxSelComment(param);
	}
	
	@RequestMapping(value = "/regModComment", method = RequestMethod.POST)
	public String regModComment(Model model, CommentPARAM param, HttpSession hs) {
		param.setI_user(SecurityUtils.getLoginUserPk(hs));
		int result = commentService.regModComment(param);
		model.addAttribute("i_shop", param.getI_shop());
		return "redirect:/shop/detail";
	}
	
	@RequestMapping("/ajaxDelComment")
	@ResponseBody
	public int ajaxDelComment(CommentPARAM param, HttpSession hs) {
		param.setI_user(SecurityUtils.getLoginUserPk(hs));
		System.out.println(param.getI_shop());
		System.out.println(param.getI_comment());
		System.out.println(param.getI_user());
		return commentService.ajaxDelComment(param);
	}
}
