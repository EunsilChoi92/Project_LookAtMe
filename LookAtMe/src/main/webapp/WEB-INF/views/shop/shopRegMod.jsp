<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="sectionContainerCenter">
   <div>
      <form id="frm" action="/shop/regMod" method="post" onsubmit="return chkFrm()" enctype="multipart/form-data">
         <div><input type="text" name="shop" placeholder="가게명" value="${shopInfo.shop}"></div>
         <div>
            <div><input type="text" name="addr" placeholder="주소" value='${shopInfo.addr}' onkeyup="changeAddr()"></div>
            <button name="btn" type="button" onclick="getLatLng()">좌표가져오기</button>
            <span id="resultGetLatLng"></span>
         </div>
         <div>
	         <input type="tel" name="phone" placeholder="전화번호" value="${shopInfo.i_shop }">
         </div>
         <input type="hidden" name="i_shop" value="${shopInfo == null? 0 : shopInfo.i_shop }">
         <input type="hidden" name="lat" value="${shopInfo == null? 0 : shopInfo.lat }">
         <input type="hidden" name="lng" value="${shopInfo == null? 0 : shopInfo.lng }">
         <input type="hidden" name="i_user" value="${loginUser.i_user }">
         <div>
            카테고리 : 
            <select name="cd">
               <option value="0">--선택--</option>
               <c:forEach items="${categoryList}" var="item">
                  <c:if test="${shopInfo.cd == item.cd}">
	                  <option value="${item.cd}" selected>${item.val}</option>
                  </c:if>
				  <c:if test="${shopInfo.cd != item.cd}">
	                  <option value="${item.cd}">${item.val}</option>
                  </c:if>
               </c:forEach>
            </select>
         </div>
         <div>샵 사진 등록</div>
         <div><input type="file" name="shop_pic" multiple></div>
         <div><input type="submit" value="등록"></div>
      </form>
		<c:if test="${shopPicList != null }">
			<h1>샵 사진~~</h1>
				<c:forEach items="${shopPicList}" var="item">
					<div id="img${item.i_pic }">
						<button style="background:pink" onclick="ajaxDelShopPic(${item.i_pic})">왼쪾사진삭제슝슝</button>
						<span>${item.shop_pic }</span>
					</div>
				</c:forEach>
		</c:if>
   </div>
   <script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4c60cbf0c3fcc8772b7e3e33c2b33422&libraries=services"></script>
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
         } else if(frm.cd.value == '0') {
            alert('카테고리를 선택해 주세요');
            frm.cd.focus();
            return false;
         }
      }
   
      function changeAddr() {
         resultGetLatLng.innerText = '';
         frm.lat.value = '0';
         frm.lng.value = '0';
      }
   
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

   </script>
</div>