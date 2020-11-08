package com.beautyshop.lookatme.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.beautyshop.lookatme.comment.model.CommentDMI;
import com.beautyshop.lookatme.comment.model.CommentVO;
import com.beautyshop.lookatme.shop.model.ShopPARAM;

@Mapper
public interface CommentMapper {

	List<CommentDMI> selCommentList(ShopPARAM param);
	CommentDMI selComment(CommentVO param);
	
	int insComment(CommentVO param);
	int updComment(CommentVO param);
	int delComment(ShopPARAM param);


}
