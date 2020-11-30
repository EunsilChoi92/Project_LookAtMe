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
			<input type="text" name="searchTxt" placeholder="가게명" value="${param.searchTxt }">
			<select name="cd_sido" onchange="onChangeSido()">
				<option value="-1">지역을 선택해주세요</option>
				<option value="0">전체</option>
				<c:forEach items="${locationCategory }" var="sido">
					<c:choose>
						<c:when test="${sido.cd_sido == param.cd_sido }">
							<option value="${sido.cd_sido}" selected>${sido.val }</option>
						</c:when>
						<c:otherwise>
							<option value="${sido.cd_sido}">${sido.val }</option>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</select>
			<select name="cd_sigungu" onchange="setCategoryAll()">
				<option value="-1">시군구를 선택해주세요</option>
			</select>
			<select name="cd_category">
				<option value="-1">카테고리를 선택해주세요</option>
				<option value="0">전체</option>
				<c:forEach items="${categoryList }" var="category">
					<option value="${category.cd }">${category.val }</option>
				</c:forEach>
			</select>
			<button>검색</button>
		</form>
	</div>
	<div id="listFlex">
	<c:forEach items="${shopList}" var="item">
		<div class="shopContainer cursor" onmouseover="hoverShopConatainer(${item.i_shop})" onmouseout="hoverShopConatainer(${item.i_shop})" onclick="location.href='/shop/detail?i_shop=${item.i_shop}'">
			<img id="shopContainerImg${item.i_shop }" src="/res/img/shop/${item.i_shop}/${item.shop_pic}">
			<div id="shopInfo${item.i_shop}" class="shopInfo">
				<div class="shopMain">
					<div class="shopNm">${item.shop }</div>
					<div>
						<c:if test="${item.cd_category_name=='네일아트'}">💅🏻</c:if>
						<c:if test="${item.cd_category_name=='네일아트'}">💅🏻</c:if>
						<c:if test="${item.cd_category_name=='네일아트'}">💅🏻</c:if>
						<c:if test="${item.cd_category_name=='네일아트'}">💅🏻</c:if>
						<c:if test="${item.cd_category_name=='네일아트'}">💅🏻</c:if>
					</div>
				</div>
				<div class="shopNm">${item.scoreAvg }</div>
				<div class="shopAddr">${item.addr }</div>	
				<div>${item.tel }</div>
				<div>${item.cnt_favorite }명이 LOOKING 합니다</div>
				<!-- 카테고리 추가했읍니다 ㅎㅎㅎㅎ -->
				<div>카테고리 : ${item.cd_category_name }</div>
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

	// 지역과 카테고리를 선택하지 않으면 submit 되지 않음
	function chkSearchFrm() {
		if(searchFrm.cd_sido.value == -1) {
			alert('지역을 선택해주세요!');
			return false;
		}
		if(searchFrm.cd_category.value == -1) {
			alert('카테고리를 선택해주세요!');
			return false;
		}
		
		return true;
	}

	// 시/도를 바꿀 때마다 시군구와 뷰티 카테고리가 변경됨
	function onChangeSido() {
		// 뷰티 카테고리가 '전체'로 맞춰짐
		setCategoryAll();
		
		const value = searchFrm.cd_sido.value;
		// 시/도가 '지역을 선택해주세요.'일 때
		if(value == -1) {
			searchFrm.cd_sigungu.innerHTML = `<option value="-1">시군구를 선택해주세요</option>`;
			return;
		// 시/도가 '전체'일 때
		} else if(value == 0) {
			searchFrm.cd_sigungu.innerHTML = `<option value="0">전체</option>`;
			return;
		}
		
		// 시/도의 cd값이 0과 -1이 아닐 때 ajax로 해당 시/도의 시군구를 불러옴
		ajaxSelSigungu();	
	}
	
	// 시/도의 cd값에 따라 시군구를 불러움
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
					// 시군구 select의 제일 상위 옵션은 '전체'
					searchFrm.cd_sigungu.innerHTML = `<option value="0">전체</option>`;
					
					// 세종특별자치시(8)의 경우에는 시군구가 없음
					if(value != 8) {
						// for문으로 cd_sigungu 카테고리에 옵션을 넣음
						for(let i=0; i<result.length; i++) {
							searchFrm.cd_sigungu.innerHTML += 
									`<option value="\${result[i].cd_sigungu}">\${result[i].sigungu}</option>`;
						}
					}
				});
		}
	}
	
	// 뷰티 카테고리의 옵션 중 '전체'가 select 되도록 함
	function setCategoryAll() {
		let list = searchFrm.cd_category.children;
		list[1].selected = true;
	}
	
	// 검색 후 쿼리스트링에 담겨 있는 값을 보여주기 위해서 /shop/main이 새로고침 될 때마다 실행됨
	function startFirst() {
		// 쿼리스트링에 값이 담겨있는 경우(검색을 한 경우)에만 동작함
		// cd_sido의 값이 없으면 param.cd_sigungu의 값도 없으므로 if문에 cd_sigungu의 조건은 필요 없음
		if('${param.cd_sido}' != '' && '${param.cd_category}' != '') {
			const sidoList = searchFrm.cd_sido.children; // cd_sido select의 옵션들
			const value = parseInt('${param.cd_sido}');
			
			const categoryList = searchFrm.cd_category.children; // cd_category select의 옵션들
			const category = parseInt('${param.cd_category}');
			
			// cd_sido가 0일 때는 cd_sido와 cd_sigungu는 '전체'가 select 되어야 함
			if(value == 0) {
				// value값(cd_sido)이 -1부터 시작하므로 +1을 해주어야 index와 맞음
				sidoList[value + 1].selected = true;
				searchFrm.cd_sigungu.innerHTML = `<option value="0">전체</option>`;
			// cd_sido가 0이 아닐 경우에는 ajax로 시군구를 불러와서 쿼리스트링의 cd_sigungu 값을 찾아 select함
			} else {
				const param = {
						params: {
							'cd_sido': value
						}
				}
				
				axios.get('/location/ajaxSelSigungu', param)
					.then(function(res) {
						const result = res.data;
						searchFrm.cd_sigungu.innerHTML = `<option value="0">전체</option>`;
						
						// 세종특별자치시(8)의 경우에는 시군구가 없음 
						if(value != 8) {
							for(let i=0; i<result.length; i++) {
								// 쿼리스트링의 cd_sigungu와 result의 cd_sigungu가 같다면 select함
								if(result[i].cd_sigungu == '${param.cd_sigungu}') {
									searchFrm.cd_sigungu.innerHTML += 
										`<option value="\${result[i].cd_sigungu}" selected>\${result[i].sigungu}</option>`;
								} else {
									searchFrm.cd_sigungu.innerHTML += 
										`<option value="\${result[i].cd_sigungu}">\${result[i].sigungu}</option>`;
								}
							}
						}
					});
			}
			
			// 뷰티 카테고리는 항상 쿼리스트링에 있는 값이 selected 되어야 함
			categoryList[category + 1].selected = true;
		}
	}
	
	
	// 새로고침될 때마다 실행됨
	startFirst();
	
	
</script>
</div>
