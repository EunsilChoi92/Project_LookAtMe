package com.beautyshop.lookatme;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.beautyshop.lookatme.shop.ShopMapper;

public class ShopInterceptor extends HandlerInterceptorAdapter{
	
	@Autowired
	private ShopMapper mapper;
	
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		String uri = request.getRequestURI();
		String[] uriArr = uri.split("/");
		
		String[] checkKeywords = {"del", "Del", "upd", "Upd"};
		for(String keyword: checkKeywords) {
			if(uriArr[2].contains(keyword)) {
				int i_shop = CommonUtils.getIntParameter("i_shop", request);
				if(i_shop == 0) {
					return false;
				}
				
				int i_user = SecurityUtils.getLoginUserPk(request);
				
				boolean result = _authSuccess(i_shop, i_user);
				System.out.println("==== auth result : " + result);
				return result;
			}
		}
		System.out.println("==== auth result : true!!~~!~!~ ");
		return true;
	}
	
	private boolean _authSuccess(int i_shop, int i_user) {		
		return i_user == mapper.selShopChkUser(i_shop);
	}
}
