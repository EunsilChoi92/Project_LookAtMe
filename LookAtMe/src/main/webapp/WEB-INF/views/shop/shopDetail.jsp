<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!-- 글 수정, 삭제 버튼 -->
<h1>글  수정, 삭제~~~~~(작성한 사람과 로그인한 사람이 같으면 보임)</h1>
<c:if test="${loginUser.i_user == shopDetail.i_user }">
	<button onclick="location.href='/shop/regMod?i_shop=${shopDetail.i_shop}'">수정</button>
	<button onclick="delShop()">삭제</button>
</c:if>

<!-- 샵 사진 -->
<h1>샵 사진~~(사진 있어야 보임)</h1>
<c:forEach items="${shopPicList}" var="item">
	<div id="img${item.i_pic }">
		<c:if test="${loginUser.i_user == shopDetail.i_user }">
			<button style="background:pink" onclick="ajaxDelShopPic(${item.i_pic})">오른쪾사진삭제슝슝</button>
		</c:if>
		<span>${item.shop_pic }</span>
	</div>
</c:forEach>
<hr>

<!-- 가게 정보 -->
<h1>가게 정보</h1>
<div>가게이름 : ${shopDetail.shop}</div>
<div>가게주소 : ${shopDetail.addr }</div>
<div>우편번호 : ${shopDetail.postcode }</div>
<div>카테고리 : ${shopDetail.cd_category_name }</div>
<div>좋아요 수 : ${shopDetail.cnt_favorite }</div>
<div>평균 별점: ${shopDetail.scoreAvg }</div>
<hr>
<!-- 좋아요 -->
<h1>좋아요?!?!?!?!!?!?!?!?!?!(로그인 해야 보임)</h1>
<c:if test="${loginUser != null }">
	<span id="favorite" class="material-icons cursor" onclick="toggleFavorite()">
		${shopDetail.is_favorite == 1 ? "favorite" : "favorite_border"}
	</span>
</c:if>

<hr>
<!-- 지도 -->
<h1>지도</h1>
<div id="mapContainer" style="width:500px; height:400px;"></div>

<hr>
<!-- 코멘트 작성 -->
<h1>코멘트 작성!!!!(로그인 해야 보임)</h1>
<c:if test="${loginUser != null }">
	<form id="commentFrm" action="/comment/regModComment" onsubmit="return chkComment()" method="post">
		<!-- 별점 입력 -->
		<!-- 별점은 starRadio 클래스 위치 말고 코드 자체는 손대지 말렴 -->
		<div class="starRadio"> 
			<c:forEach var="i" begin="5" end="50" step="5">
				<label class="starRadio__box starRadio_box_label"> 
			        <input type="radio" name="score" value="${i / 10}"> 
			        <span class="starRadio__img">
			            <span class="blind">별 ${i / 10}개</span>
			        </span> 
				</label>
			</c:forEach>
		</div>
		
		<!-- 코멘트 작성 -->
		<textarea name="comment_ctnt"></textarea>
		<input type="hidden" name="i_shop" value="${shopDetail.i_shop }">
		<input type="hidden" name="i_comment" value="0">
		<input type="submit" value="등록">
		<input type="button" value="취소" onclick="cancleComment()">
	</form>
</c:if>

<hr>
<!-- 코멘트 출력 -->
<h1>코멘트 출력</h1>
<div class="cursor" onclick="orderBy(1)">최신순</div>
<div class="cursor" onclick="orderBy(2)">별점 높은 순</div>
<div class="cursor" onclick="orderBy(3)">별점 낮은 순</div>


<hr>
<h1>코멘트 인피니트 스크롤 구현(위 코멘트와 내용 같음)</h1>
<div id="commentContainer">
	<c:forEach items="${commentList}" var="item">
		<div id="comment${item.i_comment }" class="comment_item">
			<c:if test="${loginUser.i_user == item.i_user }">
				<button onclick="modifyComment(${item.i_comment})">수정</button>
				<button onclick="ajaxDelComment(${item.i_comment})">삭제</button>
			</c:if>
			<div>프사 : 
				<img style="width:30px;" alt="profile" src="/res/img/user/${item.i_user}/${item.profile_img}">
			</div>
			<div>코멘트 쓴 사람 : ${item.nm}</div>
			<div>코멘트 내용 : ${item.comment_ctnt}</div>
			<!-- 날짜 표시도 해야되는데 년, 월, 일, 시, 분, 초 중에서 뭐뭐 보여줄지, 어떤 형태로 보여줄지 고민중 -->
			<div>빛나라 지식의 별</div>
			<div>꺄르르 : ${item.score }</div>
			
			<!-- 별점 출력 -->
			<div class="starRadio"> 
				<c:forEach var="i" begin="5" end="50" step="5">
					<label class="starRadio__box normal_cursor"> 
						<c:if test="${i == item.score * 10}">
					        <input type="radio" checked disabled> 
						</c:if>
						<c:if test="${i != item.score * 10}">
					        <input type="radio" disabled> 
						</c:if>
				        <span class="starRadio__img">
				            <span class="blind">별 ${i / 10}개</span>
				        </span> 
					</label>
				</c:forEach>
			</div>
			<a class="paging_next" href="/shop/detail?i_shop=25&commentPage=1"></a>
			<hr>
		</div>
	</c:forEach>
</div>
<div class="scroller-status">
	<p class="infinite-scroll-request">Loading...</p>
	<p class="infinite-scroll-last">End of content</p>
	<p class="infinite-scroll-error">No more pages to load</p>
</div>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=	faf4b3a5a0e4ed4c610c95db44ba090d"></script>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script src="https://unpkg.com/infinite-scroll@3/dist/infinite-scroll.pkgd.js"></script>
<script>

	// 인피니트 스크롤 코드 시작
	var elem = document.querySelector('#commentContainer');
	var infScroll = new InfiniteScroll( elem, {
	  // options
	  path: '.paging_next',
	  append: '.comment_item',
	  history: false,
	  checkLastPage: true,
	  status: '.scroller-status'
	  
	});
	// 인피니트 스크롤 코드 끝
	

	// 최신순: 1, 별점 높은 순: 2, 별점 낮은 순: 3 정렬
	// 수정 해야됨!!! ☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
	// css 작업 후에 order By된 commentList 데이터 뿌리기 필요!!!!!
	function orderBy(status) {
		const param = {
			params: {
				'i_shop': ${shopDetail.i_shop},
				'orderBy': status
			}
		}
		
		axios.get('/comment/ajaxSelCommentList', param)
			.then(function(res) {
				const result = res.data;
				for(let i=0; result.length; i++) {
					console.log((i + 1) + '번 별점 : ' + result[i].score);
					console.log((i + 1) + '번 순서 : ' + result[i].i_comment);
					console.log('------------');
				}
			});
	}

	// MAP API 관련 코드 시작
	var options = { //지도를 생성할 때 필요한 기본 옵션
		center: new kakao.maps.LatLng(${shopDetail.lat}, ${shopDetail.lng}), //지도의 중심좌표.
		level: 3 //지도의 레벨(확대, 축소 정도)
	};
	
	var map = new kakao.maps.Map(mapContainer, options); //지도 생성 및 객체 리턴
	
	createMarker();
	
	
	function createMarker() {
		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(${shopDetail.lat}, ${shopDetail.lng}); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);
	}
	// Map API 관련 코드 끝
	
	
	function toggleFavorite() {
		const param = {
				params : {
					'i_shop' : ${shopDetail.i_shop},
					'proc_type' : (favorite.innerText == 'favorite' ? 'del' : 'ins')
				}
		}
		
		axios.get('/shop/ajaxLikeShop', param)
			.then(function(res) {
				console.log(res.data);
				if(res.data == 1) {
					favorite.innerText = (favorite.innerText == 'favorite' ? 'favorite_border' : 'favorite');
					// 좋아요 누른 후 좋아요 개수도 +1로 바꿔야 함~~
					// 아작스로 가져와야 할듯 ㅜㅜ
				
				}
			})
	}
	
	function delShop() {
		if(confirm('삭제하시겠습니까?')) {
			location.href='/shop/delShop?i_shop=${shopDetail.i_shop}';
		}
	}
	
	function ajaxDelComment(i_comment) {
		if(confirm('삭제하시겠습니까?')){
			const param = {
					params: {
						'i_shop' : ${shopDetail.i_shop},
						'i_comment' : i_comment
					}
			};
			
			console.log(${shopDetail.i_shop});
			console.log(i_comment);
			axios.get('/comment/ajaxDelComment', param)
				.then(function(res) {
					const result = res.data;
					if(result == 1) {
						alert('댓글이 삭제되었습니다.');
						const element = document.querySelector('#comment' + i_comment);
						element.remove();
					} else {
						console.log(result);
						alert('댓글 삭제 실패!');
					}
				})
		}
	}
	
	function modifyComment(i_comment) {
		commentFrm.i_comment.value = i_comment;
		
		const param = {
			params: {
				'i_shop' : ${shopDetail.i_shop},
				'i_comment' : i_comment
			}	
		};
		
		axios.get('/comment/ajaxSelComment', param)
			.then(function(res) {
				const result = res.data;
				console.log(result);
				console.log(result.comment_ctnt);
				commentFrm.comment_ctnt.value = result.comment_ctnt;
				
				// 라디오 체크
				let starLabels = document.getElementsByClassName("starRadio_box_label");
				for(var i=0; i<starLabels.length; i++) {
					let starValue = starLabels[i].firstElementChild.value;
					if(result.score == starValue) {
						starLabels[i].firstElementChild.checked = true;
						break;
					}
				}
			});		
	}
	
	function cancleComment() {
		commentFrm.i_comment.value = 0;
		commentFrm.comment_ctnt.value = null;
	}

	function chkComment() {
		if(commentFrm.comment_ctnt.value == 0) {
			alert('내용을 입력해주세요!');
			return false;
		}
		return true;
	}

	function ajaxDelShopPic(i_pic) {
		console.log('i_shop : ' + ${shopDetail.i_shop} + ' i_pic : ' + i_pic);
		if(confirm('삭제하시겠습니까?')) {
			const param = {
					params: {
						'i_shop' : ${shopDetail.i_shop},
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
	
	
	// 아직 안 씀
	function ajaxSelShopPic() {
		const param = {
			params : {
				'i_shop' : ${shopDetail.i_shop}
			}	
		};
		
		axios.get('/shop/ajaxSelShopPic', param)
			.then(function(res) {
				const result = res.data;
				console.log(result);
			});
	}
	
	

</script>