<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<link rel="stylesheet" type="text/css" href="/res/css/shopList.css">
<!-- 전체 리스트, 검색 리스트 보여주는 곳 -->
<!-- 카테고리별로 선택할 수 있게 해야함 -->
<div id="msgSection">
	<div>
		예뻐지기 위한 놀이터, loOKatme
	</div>
</div>
<div>
	<form id="searchFrm" action="/shop/main" method="post" onsubmit="return chkSearchFrm()">
		<span>지역검색 : </span>
		<select name="cd_sido" onchange="ajaxSelSigungu()">
			<option value="0">--시도--</option>
			<c:forEach items="${locationCategory }" var="sido">
				<option value="${sido.cd_sido}">${sido.val }</option>
			</c:forEach>
		</select>
		<select name="cd_sigungu">
			<option value="0">--시군구--</option>
		</select>
		<button>검색</button>
	</form>
</div>
<c:forEach items="${shopList}" var="item">
	<div class="cursor" onclick="location.href='/shop/detail?i_shop=${item.i_shop}'">
		<div>샵이름 : ${item.shop }</div>
		<div>샵 제일 앞 사진 : ${item.shop_pic }</div>
		<div>샵 주소 : ${item.addr }</div>
		<div>우편번호 : ${item.postcode }</div>
		<div>카테고리 : ${item.cd_category_name }</div>
	
		${item.shop }
	</div>
</c:forEach>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
	function chkSearchFrm() {
		if(searchFrm.cd_sido.value == 0) {
			alert('시/도를 선택해주세요!');
			return false;
		}
		
		return true;
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
					for(var i=0; i<result.length; i++) {
						searchFrm.cd_sigungu.innerHTML += 
								`<option value="\${result[i].cd_sigungu}">\${result[i].sigungu}</option>`;
					}
				})
		}
	}
</script>
