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
import com.beautyshop.lookatme.comment.model.CommentDMI;
import com.beautyshop.lookatme.comment.model.CommentPARAM;
import com.beautyshop.lookatme.location.LocationUtils;
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
   
   
   public List<ShopDMI> selShopList(ShopPARAM param) {
	  if(param.getSearchTxt() == null) {
		  param.setSearchTxt("");
	  }
	   
      List<ShopDMI> shopList = shopMapper.selShopList(param);
      for(ShopDMI vo : shopList) {
         // 전체 주소 가져오기
         String addr = String.format("%s %s %s %s %s"
               , vo.getSido(), vo.getSigungu()
               , vo.getRest_addr(), vo.getExtra_addr()
               , vo.getDetail_addr());
         vo.setAddr(addr);
         
         // 평균 별점 가져오기
         double scoreAvg = getScoreAvg(vo);
         vo.setScoreAvg(scoreAvg);
         
      }
      return shopList;
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
      ShopDMI shopDMI = shopMapper.selShop(param);
      String addr = String.format("%s %s %s %s %s"
            , shopDMI.getSido(), shopDMI.getSigungu()
            , shopDMI.getRest_addr(), shopDMI.getExtra_addr()
            , shopDMI.getDetail_addr());
      shopDMI.setAddr(addr);
      shopDMI.setScoreAvg(getScoreAvg(shopDMI));
      return shopDMI;
   }

   public int regModShop(ShopPARAM param, MultipartHttpServletRequest mReq) {
      int i_shop = 0;
      
      ShopPARAM realParam = LocationUtils.splitAddr(param);
      
      // 글 수정
      if(realParam.getI_shop() != 0) {
         shopMapper.updShop(realParam);
         i_shop = realParam.getI_shop();
      }
      
      // 글 등록
      else {
         shopMapper.insShop(realParam);
         i_shop = shopMapper.selMaxI_shop(realParam);
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
      
      CommentPARAM commentParam = new CommentPARAM();
	  commentParam.setI_shop(param.getI_shop());
	  commentParam.setI_user(param.getI_user());
      
      shopMapper.delShopPic(param);
      commentMapper.delComment(commentParam);
      shopMapper.delShopLike(param);
      shopMapper.delShop(param);

      return 0;
   }

   public int ajaxDelShopPic(ShopPARAM param) {
      return shopMapper.delShopPic(param);
   }

   public int ajaxLikeShop(ShopPARAM param) {
      switch(param.getProc_type()) {
      case "del":
         return shopMapper.delShopLike(param);
      case "ins":
         return shopMapper.insShopLike(param);
      }
      return 0;
   }

   public List<ShopDMI> selShopFavoriteList(ShopPARAM param) {
      List<ShopDMI> favoriteList = shopMapper.selShopFavoriteList(param);
      
      for(ShopDMI vo : favoriteList) {
         List<ShopPicVO> shopPicList = new ArrayList<ShopPicVO>();
         ShopPARAM param2 = new ShopPARAM();
         
         param2.setI_shop(vo.getI_shop());
         
         shopPicList = selShopPicList(param2);
         vo.setShopPicList(shopPicList);
         
         String addr = String.format("%s %s %s %s %s"
               , vo.getSido(), vo.getSigungu()
               , vo.getRest_addr(), vo.getExtra_addr()
               , vo.getDetail_addr());
         vo.setAddr(addr);
      }
      
      return favoriteList;
   }
   

   
   
   private double getScoreAvg(ShopDMI param) {
	  CommentPARAM commentParam = new CommentPARAM();
	  commentParam.setI_shop(param.getI_shop());
      
      List<CommentDMI> commentList = commentMapper.selCommentList(commentParam);
      double scoreAvg = 0;
      double sum = 0;
      
      if(commentList.size() != 0) {
         for(CommentDMI vo : commentList) {
            sum += vo.getScore();
         }
         
         scoreAvg = sum / commentList.size();
      }
      
      return Math.round(scoreAvg * 100) / 100.0;
   }
   
}