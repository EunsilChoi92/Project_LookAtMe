package com.beautyshop.lookatme.location;

import java.util.List;

import com.beautyshop.lookatme.location.model.LocationDMI;
import com.beautyshop.lookatme.shop.model.ShopPARAM;

public class LocationUtils {
	public static List<LocationDMI> locationList;
	
	// addr로 cd_sido, cd_sigungu, rest_addr 나누기
	public static ShopPARAM splitAddr(ShopPARAM param) {
		String addr = param.getAddr();
		String[] addrArr = addr.split(" ");
		for(String a : addrArr) {
			System.out.println(a);
		}
		String sido = addrArr[0];
		int cd_sido = changeAddrToInt(sido, 0);
		
		String sigungu = addrArr[1];
		int cd_sigungu = changeAddrToInt(sigungu, 1);
		
		String rest_addr = "";
		
		for(int i=2; i<addrArr.length; i++) {
			rest_addr += (i < addrArr.length ? addrArr[i] + " " : addrArr[i]);
		}
		
		param.setCd_sido(cd_sido);
		param.setCd_sigungu(cd_sigungu);
		param.setRest_addr(rest_addr);
		
		return param;
	}
	
	// locationList를 활용해서 sido(0)나 sigungu(1)를 숫자로 바꿈
	public static int changeAddrToInt(String splittedAddr, int i) {
		System.out.println("changeAddrToInt 시작------");
		System.out.println("잘린 단어 : " + splittedAddr);
		
		int result = 0;
		for(LocationDMI vo : locationList) {
			if(i == 0) {
				if(splittedAddr.equals(vo.getVal())) {
					result = vo.getCd_sido();
					break;
				}
			} else {
				if(splittedAddr.equals(vo.getSigungu())) {
					result = vo.getCd_sigungu();
					break;
				}
			}
		}
		return result;
	}
}
