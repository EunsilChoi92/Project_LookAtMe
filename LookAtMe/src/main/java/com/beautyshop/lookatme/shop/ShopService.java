package com.beautyshop.lookatme.shop;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.beautyshop.lookatme.Const;
import com.beautyshop.lookatme.FileUtils;
import com.beautyshop.lookatme.comment.CommentMapper;
import com.beautyshop.lookatme.comment.model.CommentVO;
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
	
	@Autowired
	private CommentMapper commentMapper;
	
	
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

	public int regModShop(ShopPARAM param, MultipartHttpServletRequest mReq) {
		int i_shop = 0;
		
		// 글 수정
		if(param.getI_shop() != 0) {
			shopMapper.updShop(param);
			i_shop =  param.getI_shop();
		}
		
		// 글 등록
		else {
			shopMapper.insShop(param);
			i_shop = shopMapper.selMaxI_shop(param);
		}
		
		List<MultipartFile> fileList = mReq.getFiles("shop_pic");
		String path = Const.realPath + "/resources/img/shop/" + i_shop + "/";
		
		List<ShopPicVO> list = new ArrayList<ShopPicVO>();
		
		for(int i=0; i<fileList.size(); i++) {
			ShopPicVO vo = new ShopPicVO();
			
			vo.setI_shop(i_shop);
			
			MultipartFile mf = fileList.get(i);
			
			if(mf.isEmpty()) {
				continue;
			}
			
			String originFileNm = mf.getOriginalFilename();
			String ext = FileUtils.getExt(originFileNm);
			String saveFileNm = UUID.randomUUID() + ext;

			System.out.println(path);
			System.out.println(saveFileNm);
			
			try {
				mf.transferTo(new File(path + saveFileNm));
				vo.setShop_pic(saveFileNm);
			} catch(Exception e) {
				e.printStackTrace();
			} 
			
			list.add(vo);
			shopMapper.insShopPic(vo);
		}
		
		return i_shop;
	}

	public int delShop(ShopPARAM param) {
		String path = Const.realPath + "/resources/img/shop/" + param.getI_shop();
		FileUtils.delFile(path);
		
		shopMapper.delShopPic(param);
		commentMapper.delComment(param);
		shopMapper.delShop(param);

		return 0;
	}

	public int ajaxDelShopPic(ShopPARAM param) {
		return shopMapper.delShopPic(param);
	}
	
	


	
}
