<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBOARD</title>
</head>
<body>
	<h1>로그인 페이지</h1>
	<form action="mLogin" method="POST">
	아이디 : <input type="text" name="memId"/><br/>
	비밀번호 : <input type="password" name="memPw"/><br/>
	<input type="submit" value="로그인"/>
	</form>
</body>
</html>