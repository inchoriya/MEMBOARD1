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


</style>
</head>
<body>
	<!-- 
	
		action(보낼 주소) : mJoin
		method : POST방식
	
		 항목		name		id		    type
		----------------------------------------------------
		1 아이디 		memId					text
		  중복체크							button
		2 비밀번호 	memPw		memPw		password
		  비번확인				checkPw		password	
		3 이름		memName					text
		4 생년월일	memBirth				date
		5 성별		memGender				radio
		6 이메일		memEmail				email
		7 연락처 		memPhone				text
		8 주소		memAddr					text
		
	-->

	<form action="mJoin" method="POST" name="joinForm">
		<table>
			<caption>회원가입</caption>


			<tr>
				<th>아이디</th>
				<td><input type="text" id="memId" name="memId" onkeyup="checkId()"/>
				<br/><span id="check1"></span></td>
			</tr>

			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="memPw" id="memPw" onkeyup="pwRegexp()" size="40" placeholder="영문, 숫자, 특수문자 혼합"/>
				<br/><span id="pwResult1"></span></td>
			</tr>
			
			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="checkPw" onkeyup="pwCheck()" size="40"/>
				<br/><span id="pwResult2"></span></td>
				
			</tr>

			<tr>
				<th>이름</th>
				<td><input type="text" id="memName" name="memName" onkeyup="nameRegexp()" size="40"/>
				<br/><span id="pwResult3"></span></td>
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
				<td><input type="email" id="memEmail" name="memEmail" size="40"/>
				<span id="confEmail"><input type="button" value="인증번호 발송" onclick="checkEmail()"/></span></td>
			</tr>

			<tr>
				<th>연락처</th>
				<td><input type="text" name="memPhone" size="40"/></td>
			</tr>
			
			<tr>
				<th>주소</th>
				<td>
					<input type="text" 	 name="addr1" id="sample6_postcode" placeholder="우편번호">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text"   name="addr2" size="40" id="sample6_address" placeholder="주소"><br>
					<input type="text"   name="addr3" size="40" id="sample6_detailAddress" placeholder="상세주소">
					
				</td>
			</tr>
			
			<tr>
				<th>프로필 사진</th>
				<td><input type="file" name="memProfile"/></td>
			</tr>
			
			<tr>
				<th colspan="2"><input type="button" onclick="checkConfirm()" value="가입" /></th>
			</tr>

		</table>
	</form>
</body>


<script src="https://code.jquery.com/jquery-3.6.1.js" integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
<script>

function pwRegexp(){
	let memPw = document.getElementById("memPw").value;
	let pwResult1 = document.getElementById("pwResult1");
	
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
	

	
	if(!pwRegexp() || !pwCheck()){
		
		alert('비밀번호를 확인해주세요!.');
		
	} else if(!checkEmail2()){
		
		alert('이메일 인증을 진행해주세요.');
		
	} else {
		
		joinForm.submit();
	}
}

function checkId(){
	let memId = document.getElementById("memId").value;
	// location.href = "idCheck?memId=" + memId;
	
	let check1 = document.getElementById("check1");
	
	$.ajax({
		type : "POST",
		url : "idoverlap",
		data : {
			"memId" : memId
		}, 
		dataType : "text", 
		success : function(result){
			if(result=="OK"){
				// 사용할 수 있는 아이디일 경우 실행
				check1.innerHTML = memId + "는 사용가능한 아이디";
				check1.style.color = "#0000ff";
				
			} else {
				// 사용할 수 없는 아이디일 경우 실행
				check1.innerHTML = memId + "는 이미 사용중인 아이디";
				check1.style.color = "#ff0000";
				
			}
		},
		error : function(){
			alert("idoverlap함수 통신실패!");
			
		}
		
	});

	
}

function checkEmail(){
	
	
	let memEmail = $("#memEmail").val();
	
	$.ajax({
		type : "POST",
		url : "mCheckEmail",
		data : { "memEmail" : memEmail },
		dataType : "text",
		success : function(uuid){
			console.log("이메일 인증번호1 : " + uuid);
			$("#confEmail").html("<br/><input type='text' id='uuidCheck'/>"
					+" <input type='hidden' value='"+ uuid +"' id='uuid'/>"
					+" <input type='button' value='인증' onclick=\"checkEmail2()\"/>");
		},
		error : function(){
			alert('이메일 인증 통신 실패!');
		}
	});
}


function checkEmail2(){
	let uuid = $("#uuid").val();
	console.log("이메일 인증번호2 : " + uuid);
	
	let uuidCheck = $("#uuidCheck").val();
	console.log("입력한 인증번호 : " + uuidCheck);
	
	let boolUUID = false;
	
	if(uuidCheck==null || uuidCheck==""){
		
	}else if(uuid == uuidCheck){
		alert('인증성공!');
		boolUUID = true;
	} else {
		alert('인증실패!');
	}
	
	return boolUUID;
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