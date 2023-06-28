<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="mLogin" method="POST">
	<fieldset>
		<legend>로그인</legend>
		<label>아이디 : <input type="text" name="mId"/></label><br/>
		<label>비밀번호 : <input type="password" name="mPw"/></label><br/>
		<input type="submit" value="로그인"/>
	</fieldset>
	</form>
</body>
</html>