package com.beautyshop.lookatme.comment;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.beautyshop.lookatme.comment.model.CommentDMI;
import com.beautyshop.lookatme.comment.model.CommentPARAM;
import com.beautyshop.lookatme.comment.model.CommentVO;
import com.beautyshop.lookatme.shop.model.ShopPARAM;

@Mapper
public interface CommentMapper {

	List<CommentDMI> selCommentList(CommentPARAM param);
	CommentDMI selComment(CommentPARAM param);
	
	int insComment(CommentPARAM param);
	int updComment(CommentPARAM param);
	int delComment(CommentPARAM param);


}
