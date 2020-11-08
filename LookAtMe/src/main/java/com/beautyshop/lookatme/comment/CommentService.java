package com.beautyshop.lookatme.comment;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.beautyshop.lookatme.comment.model.CommentDMI;
import com.beautyshop.lookatme.comment.model.CommentVO;
import com.beautyshop.lookatme.shop.model.ShopPARAM;

@Service
public class CommentService {
	
	@Autowired
	private CommentMapper commentMapper;

	public List<CommentDMI> selCommentList(ShopPARAM param) {
		return commentMapper.selCommentList(param);
	}

	public int regModComment(CommentVO param) {
		// 수정
		if(param.getI_comment() != 0) {
			return commentMapper.updComment(param);
		}
		return commentMapper.insComment(param);
	}

	public CommentDMI ajaxSelComment(CommentVO param) {
		return commentMapper.selComment(param);
	}

	public int ajaxDelComment(ShopPARAM param) {
		return commentMapper.delComment(param);
	}

}
