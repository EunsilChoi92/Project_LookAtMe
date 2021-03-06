package com.beautyshop.lookatme.shop.model;

import java.util.List;

public class ShopDMI extends ShopVO {
	private double north_east;
	private double south_west;
	private String cd_category_name;
	private String nm;
	private String profile_img;
	private int cnt_favorite;
	private int is_favorite;
	private String shop_pic;
	private List<ShopPicVO> shopPicList;
	private String sido;
	private String sigungu;
	private String addr;
	private double scoreAvg;
	
	public double getNorth_east() {
		return north_east;
	}
	public void setNorth_east(double north_east) {
		this.north_east = north_east;
	}
	public double getSouth_west() {
		return south_west;
	}
	public void setSouth_west(double south_west) {
		this.south_west = south_west;
	}
	public String getCd_category_name() {
		return cd_category_name;
	}
	public void setCd_category_name(String cd_category_name) {
		this.cd_category_name = cd_category_name;
	}
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public String getProfile_img() {
		return profile_img;
	}
	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}
	public int getCnt_favorite() {
		return cnt_favorite;
	}
	public void setCnt_favorite(int cnt_favorite) {
		this.cnt_favorite = cnt_favorite;
	}
	public int getIs_favorite() {
		return is_favorite;
	}
	public void setIs_favorite(int is_favorite) {
		this.is_favorite = is_favorite;
	}
	public String getShop_pic() {
		return shop_pic;
	}
	public void setShop_pic(String shop_pic) {
		this.shop_pic = shop_pic;
	}
	public List<ShopPicVO> getShopPicList() {
		return shopPicList;
	}
	public void setShopPicList(List<ShopPicVO> shopPicList) {
		this.shopPicList = shopPicList;
	}
	public String getSido() {
		return sido;
	}
	public void setSido(String sido) {
		this.sido = sido;
	}
	public String getSigungu() {
		return sigungu;
	}
	public void setSigungu(String sigungu) {
		this.sigungu = sigungu;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public double getScoreAvg() {
		return scoreAvg;
	}
	public void setScoreAvg(double scoreAvg) {
		this.scoreAvg = scoreAvg;
	}
	
	
}
