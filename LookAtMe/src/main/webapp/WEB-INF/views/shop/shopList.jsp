<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="/res/css/shopList.css?ver=1">
<div id="msgSection">
	<div>
		예뻐지기 위한 놀이터, loOKatme
	</div>
</div>
<div id="listContainer">
	<div id="searchDiv">
		<form id="searchFrm" action="/shop/main" method="post" onsubmit="return chkSearchFrm()">
			<select name="cd_sido" onchange="onChangeCategory()">
				<option value="0">지역을 선택해주세요</option>
				<c:forEach items="${locationCategory }" var="sido">
					<option value="${sido.cd_sido}">${sido.val }</option>
				</c:forEach>
			</select>
			<select name="cd_sigungu">
				<option value="0">시군구를 선택해주세요</option>
			</select>
			<button>검색</button>
		</form>
	</div>
	<div id="listFlex">
	<c:forEach items="${shopList}" var="item">
		<div class="shopContainer cursor" onmouseover="hoverShopConatainer(${item.i_shop})" onmouseout="hoverShopConatainer(${item.i_shop})" onclick="location.href='/shop/detail?i_shop=${item.i_shop}'">
			<img id="shopContainerImg${item.i_shop }" src="/res/img/shop/${item.i_shop}/${item.shop_pic}">
			<div id="shopInfo${item.i_shop}" class="shopInfo">
				<div class="shopNm">${item.shop }</div>
				<div>${item.addr }</div>
				<div>${item.tel }</div>
			</div>		
		</div>
	</c:forEach>
	</div>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
	function hoverShopConatainer(i_shop) {
		var div = document.getElementById('shopInfo'+i_shop);
		var img = document.getElementById('shopContainerImg'+i_shop);
		if(div.style.display == 'none') {
			div.style.display = 'block';
			img.style.opacity = 0.2;
		} else {
			div.style.display = 'none';
			img.style.opacity = 1;
			
		}
	}

	function chkSearchFrm() {
		if(searchFrm.cd_sido.value == 0) {
			alert('시/도를 선택해주세요!');
			return false;
		}
		
		return true;
	}

	function onChangeCategory() {
		if(searchFrm.cd_sido.value == 0) {
			searchFrm.cd_sigungu.innerHTML = `<option value="0">--시군구--</option>`;
			return;
		} 
		ajaxSelSigungu();	
	}
	
	function ajaxSelSigungu() {
		const value = searchFrm.cd_sido.value;
		if(value != 0) {
			const param = {
				params : {
					'cd_sido' : value
				}
			}
			
			axios.get('/location/ajaxSelSigungu', param)
				.then(function(res) {
					const result = res.data;
					searchFrm.cd_sigungu.innerHTML = `<option value="0">전체</option>`;
					if(searchFrm.cd_sido != 8) {
						for(var i=0; i<result.length; i++) {
							searchFrm.cd_sigungu.innerHTML += 
									`<option value="\${result[i].cd_sigungu}">\${result[i].sigungu}</option>`;
						}
					}
				})
		}
	}
</script>
</div>
