<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table>
		<caption>회원목록(페이징)</caption>
		
		<tr>
			<th>아이디</th>
			<th>이름</th>
			<th>생년월일</th>
			<th>성별</th>
			<th>연락처</th>
		</tr>
		
		<c:forEach var="list" items="${memberList}">
		<tr>
			<td>${list.memId}</td>
			<td>${list.memName}</td>
			<td>${list.memBirth}</td>
			<td>${list.memGender}</td>
			<td>${list.memPhone}</td>
		</tr>
		</c:forEach>

		<tr>
			<td colspan="5">
				<!-- 검색기능 -->
				<form action="mSearch" method="GET">
				
				<!-- 카테고리 -->
				<select name="category">
					<option value="MEMNAME">이름</option>				
					<option value="MEMID">아이디</option>				
					<option value="MEMPHONE">연락처</option>				
				</select>
				
				<!-- 검색어 -->
				<input type="text" name="keyword"/>
				
				<!-- 검색버튼 -->
				<input type="submit" value="검색"/>	
							
				</form>
			</td>
		</tr>
		
		
		
	</table>
	
	
</body>
</html>