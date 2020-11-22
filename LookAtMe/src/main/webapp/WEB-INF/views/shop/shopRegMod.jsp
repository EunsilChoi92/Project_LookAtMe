<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="sectionContainerCenter">
	<div>
		<form id="frm" action="/shop/regMod" method="post"
			onsubmit="return chkFrm()" enctype="multipart/form-data">
			<div>
				<input type="text" name="shop" placeholder="가게명"
					value="${shopInfo.shop}">
			</div>

			<div>
				<input type="text" id="postcode" name="postcode" placeholder="우편번호" value="${shopInfo == null? '' : shopInfo.postcode }" readonly>
				<input type="button" onclick="openSearchAddr()" value="우편번호 찾기">
			</div>
			<div><input type="text" id="address" name="addr" placeholder="주소" value="${shopInfo == null? '' : shopInfo.addr }" readonly></div>
			<div><input type="text" id="detailAddress" name="detail_addr" placeholder="상세주소" value="${shopInfo == null? '' : shopInfo.detail_addr }"></div>
			<div><input type="text" id="extraAddress" name="extra_addr" placeholder="참고항목" readonly value="${shopInfo == null? '' : shopInfo.extra_addr }"></div>
			<div><input type="tel" name="tel" placeholder="전화번호" value="${shopInfo == null? '' : shopInfo.tel }"></div>
			
			<input type="hidden" name="i_shop" value="${shopInfo == null? 0 : shopInfo.i_shop }"> 
			<input type="hidden" name="i_user" value="${loginUser.i_user }">
			<input type="hidden" name="lat" value="${shopInfo == null? 0 : shopInfo.lat }"> 
			<input type="hidden" name="lng" value="${shopInfo == null? 0 : shopInfo.lng }"> 
			
			<div>
				카테고리 : <select name="cd_category">
					<option value="0">--선택--</option>
					<c:forEach items="${categoryList}" var="item">
						<c:if test="${shopInfo.cd_category == item.cd}">
							<option value="${item.cd}" selected>${item.val}</option>
						</c:if>
						<c:if test="${shopInfo.cd_category != item.cd}">
							<option value="${item.cd}">${item.val}</option>
						</c:if>
					</c:forEach>
				</select>
			</div>
			<div>샵 사진 등록</div>
			<div>
				<input type="file" name="shop_pic" multiple>
			</div>
			<div>
				<input type="submit" value="등록">
			</div>
		</form>
		<c:if test="${shopPicList != null }">
			<h1>샵 사진~~</h1>
			<c:forEach items="${shopPicList}" var="item">
				<div id="img${item.i_pic }">
					<button style="background: pink"
						onclick="ajaxDelShopPic(${item.i_pic})">왼쪾사진삭제슝슝</button>
					<span>${item.shop_pic }</span>
				</div>
			</c:forEach>
		</c:if>
	</div>
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4c60cbf0c3fcc8772b7e3e33c2b33422&libraries=services"></script>
	<script
		src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
   
	   function ajaxDelShopPic(i_pic) {
			if(confirm('삭제하시겠습니까?')) {
				const param = {
						params: {
							'i_shop' : '${shopInfo.i_shop}',
							'i_pic' : i_pic
						}
				};
				
				axios.get('/shop/ajaxDelShopPic', param)
					.then(function(res) {
						console.log(res);	
						const result = res.data;
						
						if(result == 1) {
							alert('삭제되었습니다.');
							const element = document.querySelector('#img' + i_pic);
							element.remove();
						} else {
							alert('삭제 실패');
						}
					});
			}
		}
   
      function chkFrm() {
         if(frm.shop.value.length == 0) {
            alert('가게명을 입력해 주세요');
            frm.shop.focus();
            return false;
         } else if(frm.addr.value.length < 9) {
            alert('주소를 확인해 주세요');
            frm.addr.focus();
            return false;
         } else if(frm.lat.value == '0' || frm.lng.value =='0') {
            alert('좌표값을 가져와 주세요');
            return false;
         } else if(frm.cd_category.value == '0') {
            alert('카테고리를 선택해 주세요');
            frm.cd_category.focus();
            return false;
         }
      }
   
      function changeAddr() {
         resultGetLatLng.innerText = '';
         frm.lat.value = '0';
         frm.lng.value = '0';
      }
   
      /*
      const geocoder = new kakao.maps.services.Geocoder();
         
      function getLatLng() {
         const addrStr = frm.addr.value;
         
         if(addrStr.length < 9) {
            alert('주소를 확인해 주세요');
            frm.addr.focus();
            return;
         }
         
         geocoder.addressSearch(addrStr, function(result, status) {
             if (status === kakao.maps.services.Status.OK) {
            console.log(result[0]);
            
            if(result.length > 0) {
               resultGetLatLng.innerText = 'V';
                frm.lat.value = result[0].y;
                frm.lng.value = result[0].x;
               
            }
 
             }
         });
      }
      */
      
      var geocoder = new daum.maps.services.Geocoder();
      
      
      function openSearchAddr() {
          new daum.Postcode({
              oncomplete: function(data) {
            	  console.log(data);
                  // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                  var addr = ''; // 주소 변수
                  var extraAddr = ''; // 참고항목 변수
                  var restAddr = ''; // 시도, 시군구 제외한 나머지 주소

                  //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                      addr = data.roadAddress;
                  } else { // 사용자가 지번 주소를 선택했을 경우(J)
                      addr = data.jibunAddress;
                  }

                  // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                  if(data.userSelectedType === 'R'){
                      // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                      // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                      if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                          extraAddr += data.bname;
                      }
                      // 건물명이 있고, 공동주택일 경우 추가한다.
                      if(data.buildingName !== '' && data.apartment === 'Y'){
                          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                      }
                      // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                      if(extraAddr !== ''){
                          extraAddr = ' (' + extraAddr + ')';
                      }
                      // 조합된 참고항목을 해당 필드에 넣는다.
                      document.getElementById("extraAddress").value = extraAddr;
                  
                  } else {
                      document.getElementById("extraAddress").value = '';
                  }

                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
                  document.getElementById('postcode').value = data.zonecode;
                  document.getElementById("address").value = addr;
                  
                  // 주소로 좌표 찾기
                  geocoder.addressSearch(addr, function(result, status) {
                      if (status === kakao.maps.services.Status.OK) {
	                     console.log(result[0]);
	                     
	                     if(result.length > 0) {
	                         frm.lat.value = result[0].y;
	                         frm.lng.value = result[0].x;
	                         console.log(frm.lat.value + ', ' + frm.lng.value)
	                        
	                     }
                      }
                  });
                  
                  // 커서를 상세주소 필드로 이동한다.
                  document.getElementById("detailAddress").focus();
              }
          }).open();
      }
      

      

   </script>
</div>