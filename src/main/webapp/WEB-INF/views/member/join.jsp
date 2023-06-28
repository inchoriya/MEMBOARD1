<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	table, td, th{
		border : 1px solid black;
		border-collapse : collapse;
		padding : 5px;
	}
</style>
</head>
<body>

	<!-- 
		Ajax(Asynchoronous JavaScript And XML) : 비동기식 자바스크립트 XML
		 - HTML만으로 어려운 다양한 작업을 웹페이지에 구현해 이용자가 웹페이지와 자유롭게 상호 작용할 수 있도록 하는 기술
		 - jsp 페이지 이동 없이 데이터베이스에서 정보를 가져올 수 있다.
		 - ajax를 사용하려변 JSON에 대해서 알아야 한다.
		
		JSON(JavaScript Object Notation) : 자바스크립트에서 객체를 만들 때 사용하는 표현식 
		 - 중괄호를 사용해서 key와 value로 구분
		 - key는 이름, value는 값 
		 - 예시)
		 {
		 	"key" : value,
		 	"String" : "문자열",
		 	"숫자" : 1234,
		 	"boolean" : true,
		 	"mId" : "icia"
		 }
		 
		Ajax 사용법 => 반드시 jQuery가 있어야 한다!
		
		$.ajax({
			type : 통신타입(GET과 POST중 선택),
			url : 요청 할 주소(Controller에서 RequestMapping으로 받을 값),
			data : 서버에 요청시 보낼 파라미터(매개변수) <- JSON으로 보낸다
			{ 
				"keyName" : keyValue 
			},
			dataType : 응답받을 데이터의 타입(text, html, xml, json 등등),
			success : function(result){
				요청 및 응답에 성공 했을 경우, result(결과값)을 가져온다
			},
			error : function(){
				요청 및 응답에 실패 했을 경우
			}  
		});
	
	
	
	 -->


	<form action="mJoin" method="POST" encType="multipart/form-data">
		<table>
			<caption>회원가입</caption>

			<tr>
				<th>아이디</th>
				<td><input type="text" name="mId" id="mId" /> <br />
				<span id="check1"></span></td>
			</tr>

			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="mPw" id="mPw"
					placeholder="영문, 숫자, 특수문자를 혼합해서 8자 이상" size="40" /> <br />
				<span id="check2"></span></td>

			</tr>

			<tr>
				<th>비밀번호 확인</th>
				<td><input type="password" id="checkPw" /> <br />
				<span id="check3"></span></td>
			</tr>

			<tr>
				<th>이름</th>
				<td><input type="text" name="mName" /></td>
			</tr>

			<tr>
				<th>생년월일</th>
				<td><input type="date" name="mBirth" /></td>
			</tr>

			<tr>
				<th>성별</th>
				<td>여자 <input type="radio" name="mGender" value="여자" /> 남자 <input
					type="radio" name="mGender" value="남자" />
				</td>
			</tr>

			<tr>
				<th>이메일</th>
				<td><input type="email" name="mEmail" /></td>
			</tr>

			<tr>
				<th>연락처</th>
				<td><input type="text" name="mPhone" /></td>
			</tr>

			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="addr1" id="sample6_postcode" placeholder="우편번호">
					<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" name="addr2" id="sample6_address" placeholder="주소"><br>
					<input type="text" name="addr3" id="sample6_detailAddress" placeholder="상세주소">
				</td>
			</tr>

			<tr>
				<th>프로필 사진</th>
				<td><input type="file" name="mProfile" /></td>
			</tr>

			<tr>
				<th colspan="2"><input type="submit" value="가입" /></th>
			</tr>

		</table>
	</form>

</body>

<script src="https://code.jquery.com/jquery-3.7.0.js" integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM=" crossorigin="anonymous"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>		
<script>
	$('#join').click(function() {
		location.href = "member/joinForm";
	});
	
	/* 키를 눌렀다 땟을때 실행 */
	$('#mId').keyup(function(){
		
		let mId = $('#mId').val();
		let check1 = $('#check1');
	
		// Ajax 를 사용해서 아이디 중복체크
		$.ajax({
			type : "GET",
			url : "idCheck",
			data : 
			{ 
				"mId" : mId 
			},
			dataType : "text",
			success : function(result){
				if(result=="OK"){
					check1.html(mId + "는 사용 가능한 아이디");
					check1.css("color", "blue");
				} else {
					check1.html(mId + "는 사용 불가능한 아이디");
					check1.css("color", "red");
				}
			},
			error : function(){
				alert("idCheck함수 통신실패!");
			}  
		});
		
		
		
		
	});
	
	$('#mPw').keyup(function(){
		
		let mPw = $('#mPw').val();
		let check2 = $('#check2');
		
		
		// 기본값 -1
		let num = mPw.search(/[0-9]/);	// 숫자 입력 여부 : 입력하면 -1이 아니다
		let eng = mPw.search(/[a-z]/);	// 영문 입력 여부 : 입력하면 -1이 아니다
		let spe = mPw.search(/[`~!@#$%^&*|\\\'\":;\/?]/);	// 특수문자 입력 여부 : 입력하면 -1이 아니다
		let spc = mPw.search(/\s/);	// 공백 여부 : 입력하면 -1이 아니다
		
		// console.log("num = " + num + ", eng = " + eng + ", spe = " + spe + ", spc = " + spc);
		
		if(mPw.length < 8 || mPw.length > 16){
			check2.html("비밀번호는 8자리에서 16자리 이내로 입력해주세요.");
			check2.css("color", "red");
		} else if(spc != -1 ) {
			check2.html("비밀번호는 공백없이 입력해주세요");
			check2.css("color", "red");
		} else if(num == -1 || eng == -1 || spe == -1){
			check2.html("영문, 숫자, 특수문자를 혼합하여 입력해주세요.");
			check2.css("color", "red");
		} else {
			check2.html("사용가능한 비밀번호 입니다.");
			check2.css("color", "blue");
		}
		
	});
	
	$('#checkPw').keyup(function(){
		
		let mPw = $('#mPw').val();
		let checkPw = $('#checkPw').val();
		
		let check3 = $('#check3');
		
		if(mPw==checkPw){
			check3.html("비밀번호 일치");
			check3.css("color", "blue");
		} else {
			check3.html("비밀번호 불일치");
			check3.css("color", "red");
		}
		
	});
	
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







