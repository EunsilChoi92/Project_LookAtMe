package com.beautyshop.lookatme.shop;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.beautyshop.lookatme.comment.model.CommentVO;
import com.beautyshop.lookatme.shop.model.ShopDMI;
import com.beautyshop.lookatme.shop.model.ShopPARAM;
import com.beautyshop.lookatme.shop.model.ShopPicVO;

@Mapper
public interface ShopMapper {
	List<ShopDMI> selShopList(ShopPARAM param);
	ShopDMI selShop(ShopPARAM param);
	int selMaxI_shop(ShopPARAM param);
	List<ShopDMI> selShopFavoriteList(ShopPARAM param);

	List<ShopPicVO> selShopPicList(ShopPARAM param);
	int selShopChkUser(int i_shop);
	
	int insShop(ShopPARAM param);
	int insShopPic(ShopPicVO param);
	int insShopLike(ShopPARAM param);

	int updShop(ShopPARAM param);

	int delShop(ShopPARAM param);
	int delShopPic(ShopPARAM param);
	int delShopLike(ShopPARAM param);
	


}
