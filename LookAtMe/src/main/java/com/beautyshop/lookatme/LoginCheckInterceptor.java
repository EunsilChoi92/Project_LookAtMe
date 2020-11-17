package com.beautyshop.lookatme;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		String uri = request.getRequestURI();
		System.out.println("uri : " + uri);
		String[] uriArr = uri.split("/");

		System.out.println("uriArr.length : " + uriArr.length);
		if (uri.equals("/")) {
			return super.preHandle(request, response, handler);
		} else if (uriArr[1].equals("res")) { // 리소스 (js, css, img)
			return true;
		}

		System.out.println("인터셉터!!");

		boolean isLogout = SecurityUtils.isLogout(request);

		switch (uriArr[1]) {
		case ViewRef.URI_COMMENT: // comment
			if (isLogout) { // 로그아웃 상태
				response.sendRedirect("/user/login");
				return false;
			}
			
		case ViewRef.URI_USER: // user
			switch (uriArr[2]) {
			case "login": case "join":
				if (!isLogout) { // 로그인 되어 있는 상태
					response.sendRedirect("/shop/main");
					return false;
				}
			}
			
		case ViewRef.URI_SHOP: // shop
			switch (uriArr[2]) {
			case "regMod":
				if (isLogout) { // 로그아웃 상태
					response.sendRedirect("/user/login");
					return false;
				}
			}
		}	
		
		return true;
	}

}
