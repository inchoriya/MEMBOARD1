<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board_게시글작성</title>
</head>
<body>
	<h1>게시글 작성페이지</h1>
	
	 <form action="bWrite" method="POST" enctype="multipart/form-data">
	 <input type="hidden" name="boWriter" value="${loginId}"/>
	 <table>
	 <caption>게시글 작성</caption>
	 	
	 	<!-- 
	 	<tr>
	 		<th>작성자</th>
	 		<td><input type="text" name="boWriter"/></td>
	 	</tr> 
	 	-->
	 	
	 	<tr>
	 	
	 		<th>제목</th>
	 		<td><input type="text" name="boTitle"/></td>
	 	</tr>
	 	<tr>
	 		<th>내용</th>
	 		<td><textarea name="boContent"></textarea></td>
	 	</tr>
	 	
	 	<tr>
	 		<th>파일업로드</th>
	 		<td><input type="file" name="boFile"/></td>
	 	</tr>
	 	<tr>
	 		<th colspan="2"><input type="submit" value="등록"/></th>
	 	</tr>
	 </table>
	 </form>
	 
</body>

<c:if test="${loginId eq null}">
<script>
	alert('로그인 후에 사용해주세요.');
	location.href="mLoginForm";
</script>
</c:if>


</html>