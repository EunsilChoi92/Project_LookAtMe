<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="/res/css/join.css">
<div id="sectionContainerCenter">
	<div id="joinContainer">
		<div id="joinBox">
			<div id="joinTitle" class="fontTitle">JOIN US!</div>	
			<div class="msg">${msg}</div>
			<form id="frm" class="frm" action="/user/join" method="post" onsubmit="return chkLength();" enctype="multipart/form-data">
			<div id="user_id">
				<div id="idChk">	
					<div>아이디<span>ID</span></div>
					<div id="idChkResult" class="msg"></div>
					<button type="button" onclick="chkId()">중복확인</button>
				</div>
				<div><input type="text" name="user_id" placeholder="아이디"></div>
			</div>
			<div>
				<div>비밀번호<span>Password</span></div>
				<div><input type="password" name="user_pw" placeholder="비밀번호"></div>			
			</div>
			<div>
				<div>비밀번호 확인<span>Password Check</span></div>
				<div><input type="password" name="user_pwre" placeholder="비밀번호 확인"></div>
			</div>
			<div>
				<div>이름<span>Name</span></div>
				<div><input type="text" name="nm" placeholder="이름"></div>			
			</div>
			<div id="profileImgContainer">
				<div>프로필 이미지<span>Profile Image</span></div>
				<div id="uploadProfileImg">
					<div id="profileImg"></div>
				</div>
				<div class="btn" id="btn">
					<!-- <label for="profile_image"></label> -->
					<input type="file" id="profile_image" name="user_profile" accept="image/*" onchange="previewImage(this)" value="사진선택"><br>
				</div>
			</div>
			<div>
				<a class="fontTitle" id="btnBack" href="javascript:history.back();">BACK</a>
				<input class="fontTitle" type="submit" value="JOIN">
			</div>
			</form>
		</div>
	</div>
</div>	
	<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
	<script>
		function chkId() {
			if(frm.user_id.value == '') {
				alert('아이디를 입력해주세요!');
				frm.user_id.focus();
				return;
			}
			const user_id = frm.user_id.value;
			axios.post('/user/ajaxIdChk', {
				user_id
			}).then(function(res) {
				console.log(res);
				if(res.data == '2') {
					idChkResult.innerText = '사용할 수 있는 아이디입니다.';
				} else if(res.data == '3') {
					idChkResult.innerText = '이미 사용중인 아이디입니다.';
				}
			})
		}
		
		//이미지 미리보기
	    function previewImage(f){
	    	var file = f.files;
	    	// 확장자 체크
	    	if(!/\.(gif|jpg|jpeg|png)$/i.test(file[0].name)){
	    		alert('gif, jpg, png 파일만 선택해 주세요.\n\n현재 파일 : ' + file[0].name);
	    		// 선택한 파일 초기화
	    		f.outerHTML = f.outerHTML;
	    		document.getElementById('profileImg').innerHTML = '';
	    	}
	    	else {
	    		// FileReader 객체 사용
	    		var reader = new FileReader();
	    		// 파일 읽기가 완료되었을때 실행
	    		reader.onload = function(rst){
	    			document.getElementById('profileImg').innerHTML = '<img src="' + rst.target.result + '">';
	    		}
	    		// 파일을 읽는다
	    		reader.readAsDataURL(file[0]);
	    	}
	    }
	</script>