<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBOARD</title>
</head>
<body>
	<h1>회원제 게시판 프로젝트</h1>
	<br/> 로그인 아이디 : ${loginId}
	<br/><br/>
	
	<!-- c:choose 사용 -->
	
	
	
	<c:choose>
	
	
	<c:when test = "${loginId eq 'admin'}">
		<button onclick="location.href='mLogout'">로그아웃</button>
		<button onclick="location.href='mList'">회원목록</button>
		<button onclick="location.href='mView?memId=${loginId}'">내정보보기</button>
		<button onclick="location.href='bWriteForm'">게시글작성</button>
		<button onclick="location.href='bList'">게시글목록</button>
	</c:when>
	
	
	
	<c:when test = "${loginId ne null}">
		<button onclick="location.href='mLogout'">로그아웃</button>
		<button onclick="location.href='mList'">회원목록</button>
		<button onclick="location.href='mView?memId=${loginId}'">내정보보기</button>
		<button onclick="location.href='bWriteForm'">게시글작성</button>
		<button onclick="location.href='bList'">게시글목록</button>
	</c:when>
	
	
	<c:otherwise>
		<button onclick="location.href='mJoinForm'">회원가입</button>
		<button onclick="location.href='mLoginForm'">로그인</button>
		<button onclick="location.href='bList'">게시글목록</button>
	</c:otherwise>
	</c:choose>
	
	
	
	
</body>
</html>