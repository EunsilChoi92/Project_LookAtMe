package com.beautyshop.lookatme.shop;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beautyshop.lookatme.model.CodeVO;
import com.beautyshop.lookatme.model.CommonMapper;
import com.beautyshop.lookatme.shop.model.ShopDMI;
import com.beautyshop.lookatme.shop.model.ShopPARAM;
import com.beautyshop.lookatme.shop.model.ShopPicVO;

@Service
public class ShopService {
	
	@Autowired
	private ShopMapper shopMapper;
	
	@Autowired
	private CommonMapper commonMapper;
	
	
	public List<ShopDMI> selShopList() {
		return shopMapper.selShopList();
	}
	
	public List<CodeVO> selCategoryList() {
		CodeVO param = new CodeVO();
		param.setI_m(1);
		return commonMapper.selCodeList(param);
	}

	public List<ShopPicVO> selShopPicList(ShopPARAM param) {
		return shopMapper.selShopPicList(param);
	}
	
	public ShopDMI selShop(ShopPARAM param) {
		return shopMapper.selShop(param);
	}

	public int insShop(ShopPARAM param) {
		return shopMapper.insShop(param);
	}


	
}
