<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board_게시글상세보기</title>
<style>
table, td, th {
	border: 1px solid black;
	border-collapse: collapse;
	padding: 10px;
}
</style>
</head>
<body>

	<table>
		<caption>게시글 상세보기</caption>
		<tr>
			<th>글번호</th>
			<td>${view.boNum}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${view.boWriter}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${view.boTitle}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${view.boContent}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${view.boDate}</td>
		</tr>
		<tr>
			<th>조회수</th>
			<td>${view.boHit}</td>
		</tr>
		<tr>
			<th>사진</th>
			<td><img
				src="${pageContext.request.contextPath}/resources/fileUpload/${view.boFileName}"
				width="200px"></td>
		</tr>

		<c:if test="${loginId eq view.boWriter || loginId eq 'admin'}">
			<th colspan="2"><input type="button" value="수정"
				onclick="location.href='bModifyForm?boNum=${view.boNum}'" /> <input
				type="button" value="삭제"
				onclick="location.href='bDelete?boNum=${view.boNum}'" /></th>
		</c:if>

	</table>
	<br/><br/>
	
	<div>
		<input type="hidden" value="${view.boNum}" id="cbNum"/>
		<input type="hidden" value="${loginId}" id="cmtWriter"/>
		<textarea rows="3" cols="30" id="cmtContent" onfocus="checkLogin()"></textarea>
		<button onclick="cmtWrite()">댓글 입력</button>
	</div>
	<br/>
	
	<div id="cmtArea"></div>
	<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
</body>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
/* 
	[1] Ajax (Asynchronous JavaScript And XML)
	 : 비동기식 자바스크립트 XML
	 : 페이지 이동없이 DB에서 데이터를 가져올 수 있다.
	 : HTML만으로 어려운 다양한 작을 웹페이지에서 이용자가 웹페이지와 자유롭게 상호 작용할 수 있도록 하는 기술
	 
	[2] JSON (JavaScript Object Notation)
	
	{
		"name" : "황인철" ,
		"age" : 30 ,
		"gender" : "남",
		"families" : ["배우자", "자녀"] ,
		"isMarried" : true,
		"key" : "value"		 
	}
	
	[3] Ajax 사용법
	
	$.ajax({
		type : 통신타입 (GET, POST중 선택),
		
		url : 요청할 주소(controller에서 RequestMapping value로 받을 주소),
		
		data : {
			"parameterName" : parameterValue
		},
		
		dataType : 응답받을 데이터 타입(text, html, xml, json등등) ,
		
		sucess : function(result){
			요청 및 응답에 성공 했을 경우,
			result 정보를 가지고 온다
		},
		
		error : function(){
			요청 및 응답에 실패 했을 경우
		}
		
	});
	

*/

	$(document).ready(function(){
		$.ajax({
			type : "POST",
			url : "comment/cList",
			data : {
				"cbNum" : ${view.boNum}
			},
			dataType : "json",
			success : function(list){
				commentList(list);
			},
			error : function(){
				alert("댓글 불러오기 통신 실패!");
			}
		});
	});
	
	
	// 댓글 불러오기 함수
	function commentList(list){
		let output = "";
		
		output += "<table>";
		output += "<tr>";
		output += "<th>작성자</th>";
		output += "<th>내용</th>";
		output += "<th>작성일</th>";
		output += "<th>수정</th>";
		output += "<th>삭제</th>";
		output += "</tr>";
		
		let check = false;
		
		for(let i in list){
			output += "<tr>";
			
			output += "<td>"+ list[i].cmtWriter +"</td>";
			output += "<td><span id='cmtModiContent"+list[i].cmtNum+"'>"+ list[i].cmtContent +"</span></td>";
			output += "<td>"+ list[i].cmtDate +"</td>";
			
			
			if('${loginId}' == list[i].cmtWriter || '${loginId}' == 'admin'){
				output += "<td><button onclick='cmtCon("+ list[i].cmtNum +", "+list[i].cbNum+")'>수정</button></td>";
				output += "<td><button onclick='cmtDelete("+ list[i].cmtNum +", "+list[i].cbNum+")'>삭제</button></td>";
			} else {
				output += "<td></td><td></td>";
			}
			
			output += "</tr>";
		}
		
		document.getElementById("cmtArea").innerHTML = output;
		
	}
	
	function cmtDelete(cmtNum, cbNum){
		// console.log("cmtNum : " + cmtNum + " , cbNum : " + cbNum);
		
		$.ajax({
			type : "POST",
			url : "comment/cmtDelete",
			data : {
				"cbNum" : cbNum,
				"cmtNum" : cmtNum
			},
			dataType : "json",
			success : function(list){
				commentList(list);
			},
			error : function(){
				alert("댓글 삭제 통신 실패!");
			}
		});
		
		
	}
	
	// 수정버튼을 눌렀을때
	function cmtCon(cmtNum, cbNum){
		$("#cmtModiContent"+cmtNum).html("<input type='text' id='cContent'/> <input type='button' value='확인' onclick='cmtModify("+cmtNum+", "+cbNum+")'/>");
	}
	
	// 수정댓글 내용 작성 후 확인버튼을 눌렀을때
	function cmtModify(cmtNum, cbNum){
		console.log("cmtNum : " + cmtNum + " , cbNum : " + cbNum);
		// 44, 1
		
		let cmtContent = $("#cContent").val();
		
		$.ajax({
			type : "POST",
			url : "comment/cmtModify",
			data : {
				"cbNum" : cbNum,
				"cmtNum" : cmtNum,
				"cmtContent" : cmtContent
			},
			dataType : "json",
			success : function(list){
				commentList(list);
			},
			error : function(){
				alert("댓글 수정 통신 실패!");
			}
		});
		
		
	}
	
	
	// 댓글 입력
	function cmtWrite(){
		let cmtWriter = document.getElementById("cmtWriter").value;
		let cmtContent = $("#cmtContent").val();
		let cbNum = $("#cbNum").val();
		
		$.ajax({
			type : "POST",
			url : "comment/cmtWrite",
			data : {
				"cbNum" : cbNum,
				"cmtWriter" : cmtWriter,
				"cmtContent" : cmtContent
			},
			dataType : "json",
			success : function(list){
				commentList(list);
				$("#cmtContent").val("");
				
			},
			error : function(){
				alert('댓글 작성 통신 실패!');
			}
		});
	}
	
	// 댓글 입력시 로그인 여부 확인
	function checkLogin(){
		
		if(${loginId eq null}){
			$("#cmtContent").blur();
			alert('로그인 후 사용하세요.');
			location.href="mLoginForm";
		}
	}
	
</script>
</html>









