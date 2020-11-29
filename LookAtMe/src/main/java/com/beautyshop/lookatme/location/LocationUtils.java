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
		int cd_sido = changeAddrToInt(addrArr, 0);
		
		String sigungu;
		int cd_sigungu;
		if(cd_sido != 8) {
			sigungu = addrArr[1];
			cd_sigungu = changeAddrToInt(addrArr, 1);
		} else {
			cd_sigungu = 1;
		}
		
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
	public static int changeAddrToInt(String[] addrArr, int i) {
		int result = 0;
		for(LocationDMI vo : locationList) {
			
			if(i == 0) {
				if(addrArr[0].equals(vo.getVal())) {
					result = vo.getCd_sido();
					break;
				}
			} else {
				if(addrArr[0].equals(vo.getVal()) && addrArr[1].equals(vo.getSigungu())) {
					result = vo.getCd_sigungu();
					break;
				}
			}
			
		}
		return result;
	}
}
