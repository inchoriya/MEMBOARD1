<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board_View</title>
<link rel="stylesheet" href="./resources/css/table.css" />
<style>
table {
	margin: 20px 0px 20px 0px;
}
</style>
</head>
<body>

	<table>
		<caption>게시글 상세보기</caption>

		<tr>
			<th>번호</th>
			<td>${view.BNum}</td>
		</tr>

		<tr>
			<th>작성자</th>
			<td>${view.BWriter}</td>
		</tr>

		<tr>
			<th>제목</th>
			<td>${view.BTitle}</td>
		</tr>

		<tr>
			<th>내용</th>
			<td>${view.BContent}</td>
		</tr>

		<tr>
			<th>작성일</th>
			<td>${view.BDate}</td>
		</tr>

		<tr>
			<th>조회수</th>
			<td>${view.BHit}</td>
		</tr>

		<tr>
			<th>첨부파일</th>
			<c:choose>
				<c:when test="${view.BFileName == null}">
					<td><img src="./resources/fileUpload/default.png"
						width="200px" /></td>
				</c:when>

				<c:otherwise>
					<td><img src="./resources/fileUpload/${view.BFileName}"
						width="200px" /></td>
				</c:otherwise>
			</c:choose>


		</tr>

		<tr>
			<th colspan="2">
				<button id="modify">수정</button>
				<button id="delete">삭제</button>
			</th>
		</tr>

	</table>

	<div id="cmtWrite">
		<!-- 댓글 작성 영역 -->
		<input type="hidden" value="${view.BNum}" id="cbNum" /> <input
			type="hidden" value="${loginId}" id="cWriter" />
		<textarea rows="3" cols="30" id="cContent" onfocus="checkLogin()"></textarea>
		<button id="writeBtn">댓글 입력</button>
	</div>

	<div id="cmtArea">
		<!-- 댓글 목록 가져올 영역 -->
	</div>


</body>
<!-- 
	jQuery를 사용해서 
	[수정] 버튼을 누르면 modiForm으로 bNum의 정보를 가지고 이동
	[삭제] 버튼을 누르면 boardDelete로 bNum의 정보를 가지고 이동
-->

<script src="https://code.jquery.com/jquery-3.7.0.js"
	integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
	crossorigin="anonymous"></script>
<script>
	$('#modify').click(function() {
		let pw = 'ddd';
		let check = prompt('비밀번호를 입력해주세요');
		
		if(pw==check){
			location.href = "modiForm?bNum=${view.BNum}";	
		} else {
			alert('비밀번호가 일치하지 않습니다.');
		}
	});
	
	$('#delete').click(function() {
		let pw = 'dddd';
		let check = prompt('비밀번호를 입력해주세요');
		
		if(pw==check){
			location.href = "boardDelete?bNum=${view.BNum}";	
		} else {
			alert('비밀번호가 일치하지 않습니다.');
		}
		
	});
	
	$('#button21').click(function(){
		console.log('hi');
		alert('안녕하세요');
	});
	
	
	function checkLogin(){
		
		if(${loginId == null}){
			$('#cContent').blur();
			alert('로그인 후 사용하세요');
			location.href="loginForm";
		}
	}
	
	// ajax로 댓글 불러오기
	$.ajax({
		type : "POST",
		url : "cList",
		data : {
			"cbNum" : ${view.BNum}
		},
		dataType : "json",
		success : function(list){
			console.log(list);
			
			// cmtList() 함수 호출
			cmtList(list);
		},
		error :  function(){
			alert("댓글 불러오기 통신 실패");
		}
		
	});
	
	
	
	// 댓글 입력(writeBtn) 버튼을 클릭했을 경우
	$('#writeBtn').click(function(){
		let cWriter = $('#cWriter').val();		// 작성자
		let cContent = $('#cContent').val();	// 내용
		let cbNum = $('#cbNum').val();			// 게시글 번호(댓글 번호 아님)
		
		// console.log("cWriter : " + cWriter + ", cContent : " + cContent+ ", cbNum : " + cbNum );
		
		$.ajax({
			type : "POST",
			url : "cWrite",
			data : {
				"cbNum" : cbNum,
				"cContent" : cContent,
				"cWriter" : cWriter
			},
			dataType : "json",
			success : function(list){
				cmtList(list);
				$('#cContent').val("");
			},
			error : function(){
				alert('댓글 작성 통신 실패!');
			}
		});
		
		
		
		
		
		
		
		
	});
	
	// 댓글 수정
	function cModify(cNum){
		//alert('수정 댓글 번호 : ' + cNum);
		let cContent = $('#cContent').val();
		let cbNum = ${view.BNum};
		
		$.ajax({
			type : "POST",
			url : "cModify",
			data : {
				"cNum" : cNum,
				"cbNum" : cbNum,
				"cContent" : cContent
			},
			dataType : "json",
			success : function(list){
				$('#cContent').val("");
				cmtList(list);
			},
			error : function(){
				alert('댓글 수정 통신 실패!');
			}
		});
		
	}
	
	// 댓글 삭제
	function cDelete(cNum){
		let conf = confirm('삭제하시겠습니까?');
		let cbNum = ${view.BNum};
		
		if(conf){
			$.ajax({
				type : "POST",
				url : "cDelete",
				data : {
					"cNum" : cNum,
					"cbNum" : cbNum
				},
				dataType : "json",
				success : function(list){
					cmtList(list);
				},
				error : function(){
					alert('댓글 삭제 통신 실패!');
				}
			});
			
		} else {
			alert('취소했습니다.');
		}
	}	
	
	function cmtList(list){
		
		let output = "";
		
		output += "<table>";
		output += "<tr>";
		output += "<th>작성자</th>";
		output += "<th>내용</th>";
		output += "<th>작성일</th>";
		output += "<th>수정</th>";
		output += "<th>삭제</th>";
		output += "</tr>";
		
		for(let i in list){
			output += "<tr>";
			
			output += "<td>" + list[i].cwriter + "</td>";
			output += "<td>" + list[i].ccontent + "</td>";
			output += "<td>" + list[i].cdate + "</td>";
			
			if('${loginId}' == list[i].cwriter || '${loginId}' == 'admin'){
				output += "<td><button onclick='cModify("+ list[i].cnum+")'>수정</button></td>";
				output += "<td><button onclick='cDelete("+ list[i].cnum+")'>삭제</button></td>";
			} else {
				output += "<td></td>";
				output += "<td></td>";	
			}
			output += "</tr>";
		}
		output += "</table>";
		$('#cmtArea').html(output);
	}
	
	
	
	
</script>



</html>