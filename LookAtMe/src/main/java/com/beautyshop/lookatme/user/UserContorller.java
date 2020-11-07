package com.beautyshop.lookatme.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.beautyshop.lookatme.Const;
import com.beautyshop.lookatme.ViewRef;


@Controller
@RequestMapping("/user")
public class UserContorller {

	@Autowired
	UserService userService;
	
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model) {
		model.addAttribute(Const.TITLE, "로그인");
		model.addAttribute(Const.VIEW, "user/login");
		return ViewRef.TEMP_DEFAULT;
	}
	
	@RequestMapping(value="/join", method = RequestMethod.GET)
	// required에 절대 true를 주면 안 됨 - err 값이 없으면 error가 남(default : true)
	// name과 매개변수명이 같은 경우 value="err" 생략하고 int err만 적어도 됨
	// null 값을 넣을 수 있도록 매개변수 type을 Integer로 바꾸거나 defaultValue="0"으로 설정
	public String join(Model model, @RequestParam(defaultValue="0") int err) {
		System.out.println("err : " + err);
		
		if(err > 0) {
			model.addAttribute("msg", "에러가 발생했습니다.");
		}
		model.addAttribute(Const.TITLE, "회원가입");
		model.addAttribute(Const.VIEW, "user/join");
		return ViewRef.TEMP_DEFAULT;
	}
}
