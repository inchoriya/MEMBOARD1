<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
</head>
<body>

	<form action="bWrite" method="POST" enctype="multipart/form-data">
	<input type="hidden" name="bWriter" value="${loginId}"/>
	<table>
	<caption>게시글 작성</caption>
	<!-- 
		<tr>
			<th>작성자</th>
			<td><input type="text" name="bWriter" size="40"/></td>		
		</tr>
		
		<tr>
			<th>비밀번호</th>
			<td><input type="password" name="bPw" size="40"/></td>		
		</tr>
	 -->	
		<tr>
			<th>제목</th>
			<td><input type="text" name="bTitle" size="40"/></td>		
		</tr>
		
		<tr>
			<th>내용</th>
			<td><textarea rows="20" cols="40" name="bContent"></textarea></td>		
		</tr>
		
		<tr>
			<th>첨부파일</th>
			<td><input type="file" name="bFile"/></td>		
		</tr>
		
		<tr>
			<th colspan="2">
				<input type="submit" value="등록"/>
			</th>		
		</tr>
		
	</table>
	</form>
	
</body>

<script>
	<!-- 로그인 하지 않으면 로그인 페이지로 이동 -->
	<!-- 로그인을 해야 게시글 작성할 수 있음 -->
	<!-- c:if 태그 사용 -->
	
	<c:if test="${loginId == null}">
		alert('로그인 후에 사용해주세요.');
		location.href = "loginForm";
	</c:if>
	
	
</script>


</html>