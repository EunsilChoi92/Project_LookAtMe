package com.beautyshop.lookatme.shop;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.beautyshop.lookatme.shop.model.ShopDMI;
import com.beautyshop.lookatme.shop.model.ShopPARAM;
import com.beautyshop.lookatme.shop.model.ShopPicVO;

@Mapper
public interface ShopMapper {
	List<ShopDMI> selShopList();
	List<ShopPicVO> selShopPicList(ShopPARAM param);

	ShopDMI selShop(ShopPARAM param);
	
	int insShop(ShopPARAM param);



}
