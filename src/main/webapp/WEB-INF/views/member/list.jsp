<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
table, th, td {
	border: 1px solid black;
	border-collapse: collapse;
}

.width70 {
	width: 70%;
}

th, td {
	padding: 10px;
}

.right{
	text-align : right;
}

#numbering{
	text-align : center;
}

.next, .prev, .iNum {

}
</style>
</head>
<body>
	<div class="right width70">
		<form action="mSearch" method="GET">

			<!-- 카테고리 -->
			<select name="category">
				<option value="MNAME">이름</option>
				<option value="MID">아이디</option>
				<option value="MPHONE">연락처</option>
			</select>

			<!-- 검색어 -->
			<input type="text" name="keyword" />

			<!-- 검색버튼 -->
			<input type="submit" value="검색" /> <select id="limit"
				onchang="test1()">
				<option value="5">5개씩</option>
				<option value="10">10개씩</option>
				<option value="20">20개씩</option>
			</select>

		</form>
	</div>
	<table class="table width70">
		<caption>회원목록(페이징)</caption>
		<thead>
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>생년월일</th>
				<th>성별</th>
				<th>연락처</th>
			</tr>
		</thead>

		<tbody></tbody>

	</table>
	<div id="numbering" class="width70"></div>


</body>
<script src="https://code.jquery.com/jquery-3.7.0.js"
	integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
	crossorigin="anonymous"></script>
<script>
	let page = 1; // 페이지 번호
	let count = ${count}; // 게시글 갯수
	let limit = 5; // 화면에 출력 개수
	const block = 5; // 화면 출려개수(페이지 버튼 출력개수)

	let list = [];
	let obj = {};

	$(function(){
		
		<c:forEach var="memberList" items="${memberList}" varStatus="i">
			obj = {
				"mId" : '${memberList.MId}',
				"mPw" : '${memberList.MPw}',
				"mName" : '${memberList.MName}',
				"mBirth" : '${memberList.MBirth}',
				"mGender" : '${memberList.MGender}',
				"mEmail" : '${memberList.MEmail}',
				"mPhone" : '${memberList.MPhone}',
				"mAddr" : '${memberList.MAddr}',
				"mProfileName" : '${memberList.MProfileName}'				
			}
			
			list[${i.index}] = obj;
		</c:forEach>

		pagingList(page, list);
		
	});
		
	
	
	

	$('#limit').change(function() {

		page = 1;
		limit = Number($('#limit').val());
		pagingList(page, list);

	});

	
	
	$(document).on('click','a',function(e){
        page = parseInt($(this).data('page'));
        pagingList(page, list);
        return false;
    });

	function pagingList(page, list) {
		
		console.log(page);

		const maxPage = Math.ceil(count/limit);
		
		if (page > maxPage) {
			if(maxPage==0) {
				maxPage = 1;
			}
			page = maxPage;
		}
		
		
		let startRow = (page - 1) * limit;

		// 끝나는 행 : 5 10 15
		let endRow = page * limit - 1;
		
		if(endRow >= count){
			endRow = count-1;
		}
		
		// 시작하는 페이지
		let startPage = (((Math.ceil(page / block))) - 1) * block + 1;

		// 끝나는 페이지
		let endPage = startPage + block - 1;

		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		console.log("page : " + page);
		console.log("startRow : " + startRow);
		console.log("endRow : " + endRow);
		console.log("startPage : " + startPage);
		console.log("endPage : " + endPage);
		console.log("maxPage : " + maxPage);
		console.log("count : " + count);		
		console.log("limit : " + limit);
		
		txt = "";

		for (var i = startRow; i <= endRow; i++) {
		
			txt += "<tr>";
			txt += "<td>" + list[i].mId + "</td>";
			txt += "<td>" + list[i].mName + "</td>";
			txt += "<td>" + list[i].mBirth + "</td>";
			txt += "<td>" + list[i].mGender + "</td>";
			txt += "<td>" + list[i].mPhone + "</td>";
			txt += "</tr>";
		}

		$('.table tbody').empty();
		$('.table tbody').append(txt);
			
		let pageNums = [];
		let prev = (page - 1 < 1 ? 1 : page - 1);              // 이전 페이지
        let next = (page + 1 >= maxPage ? maxPage : page + 1); // 다음페이지
		
		
		// 이전
		if(page<=1){
			pageNums.push(" \< ");
		} else {
			pageNums.push("<a class='prev' href='#'  data-page="+prev+"> \< </a>");
		}
        
        // 번호
		for(var i=startPage; i<=endPage ;i++){
            if(page == i){
              pageNums.push(" "+i+" ");
              continue;
            } 
            pageNums.push("<a class='iNum' href='#' data-page=" + i + "> " + i + " </a> ");
          }
        
        // 다음
		if(page>=maxPage){
			pageNums.push(" \> ");
		} else {
			pageNums.push(" <a class='next' href='#'data-page="+next+"> \> </a>");
		}
        
		$('#numbering').empty();
		$('#numbering').append(pageNums);
        
        
		

	}

</script>

</html>