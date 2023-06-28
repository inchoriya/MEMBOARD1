<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBOARD</title>
<style>
table, th, td {
	border: 1px solid;
	border-collapse: collapse;
	padding: 10px;
}

.check1{
	color : #0000ff;
}


</style>
</head>
<body>
	
	<form action="mModify" method="POST" name="modiForm" enctype="multipart/form-data">
		<table>
			<caption>회원수정</caption>


			<tr>
				<th>아이디</th>
				<td><input type="text" name="memId" value="${member.memId}" readonly></td>
			</tr>

			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="memPw" id="memPw" onkeyup="pwRegexp()" size="40" placeholder="영문, 숫자, 특수문자 혼합"/>
				<br/><span id="pwResult1"></span>
				<br/><span id="pwResult3"></span></td>
			</tr>
			
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="checkPw" onkeyup="pwCheck()" size="40"/>
				<br/><span id="pwResult2"></span></td>
			</tr>

			<tr>
				<th>이름</th>
				<td><input type="text" id="memName" name="memName" size="40" placeholder="${member.memName}"/></td>
			</tr>

			<tr>
				<th>생년월일</th>
				<td><input type="date" name="memBirth"/></td>
			</tr>

			<tr>
				<th>성별</th>
				<td>남성<input type="radio" name="memGender" value="남성" /> 
					여성<input type="radio" name="memGender" value="여성" /></td>
			</tr>

			<tr>
				<th>이메일</th>
				<td><input type="email" name="memEmail" size="40" placeholder="${member.memEmail}"/></td>
			</tr>

			<tr>
				<th>연락처</th>
				<td><input type="text" name="memPhone" size="40" placeholder="${member.memPhone}"/></td>
			</tr>
			
			<tr>
				<th>주소</th>
				<td>
					<input type="text" 	 name="addr1" id="sample6_postcode" 		placeholder="우편번호">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text"   name="addr2" size="40" id="sample6_address"       placeholder="주소"><br>
					<input type="text"   name="addr3" size="40" id="sample6_detailAddress" placeholder="상세주소">
					
				</td>
			</tr>
			
			<tr>
				<th>프로필 사진</th>
				<td><input type="file" name="memProfile"/>
				<input type="hidden" name="memProfileName" value="${member.memProfileName}"/></td>
			</tr>
			
			<tr>
				<th colspan="2"><input type="button" value="수정" onclick="checkConfirm()"/></th>
			</tr>

		</table>
	</form>
</body>



<script>

function pwRegexp(){
	let memPw = document.getElementById("memPw").value;
	let pwResult1 = document.getElementById("pwResult1");
	let pwResult3 = document.getElementById("pwResult3");
	
	pwResult3.innerHTML = memPw;
	
	let num = memPw.search(/[0-9]/);
	let eng = memPw.search(/[a-z]/);
	let spe = memPw.search(/[`~!@#$%^&*|\\\'\":;\/?]/);
	let spc = memPw.search(/\s/);
	
	
	console.log("num : " + num + " , eng : " + eng + " , spe : " + spe);

	
	if(memPw.length < 8 || memPw.length > 16){
		pwResult1.style.color = "#ff0000";
		pwResult1.innerHTML = "비밀번호는 8자리에서 16자리 이내로 입력해주세요.";
		return false;
		
	} else if(spc >= 0){
		pwResult1.style.color = "#ff0000";
		pwResult1.innerHTML = "비밀번호는 공백없이 입력해주세요.";
		return false;
	
	} else if(num < 0 || eng < 0 || spe < 0){
		pwResult1.style.color = "#ff0000";
		pwResult1.innerHTML = "영문, 숫자, 특수문자를 혼합하여 입력해주세요.";
		return false;
	
	} else {
		pwResult1.style.color = "#0000ff";
		pwResult1.innerHTML = "사용가능한 비밀번호 입니다.";
		return true;
	}
	

}

function pwCheck(){
	
	let memPw = document.getElementById("memPw").value;
	let checkPw = document.getElementById("checkPw").value;
	let pwResult2 = document.getElementById("pwResult2");
	
	if(memPw == checkPw){
		pwResult2.style.color = "#0000ff";
		pwResult2.innerHTML = "비밀번호가 일치합니다.";
		return true;
	} else {
		pwResult2.style.color = "#ff0000";
		pwResult2.innerHTML = "비밀번호가 일치하지 않습니다.";
		return false;
	}
	
	
}

function checkConfirm(){
	if(pwRegexp() && pwCheck()){
		// submit이 되도록
		modiForm.submit();
		
	} else {
		alert('비밀번호를 확인하세요.');
	}
}



</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function sample6_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample6_postcode').value = data.zonecode;
                document.getElementById("sample6_address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("sample6_detailAddress").focus();
            }
        }).open();
    }
</script>






</html>