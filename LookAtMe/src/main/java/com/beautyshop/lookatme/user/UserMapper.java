package com.beautyshop.lookatme.user;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.beautyshop.lookatme.user.model.UserDMI;
import com.beautyshop.lookatme.user.model.UserPARAM;



@Mapper
public interface UserMapper {
	public int insUser(UserPARAM param);
	public UserDMI selUser(UserPARAM param);
	public int updUser(UserPARAM param);
	
	
	//public int insFavorite(UserPARAM param);

	
	//public UserDMI selUser(UserPARAM param);
	//public List<UserDMI> selFavoriteList(UserPARAM param);
	
	//public int delFavorite(UserPARAM param);
	
	
}
