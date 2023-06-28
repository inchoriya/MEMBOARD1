<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEMBOARD</title>
<style>
table, th, td {
	border: 1px solid;
	border-collapse: collapse;
	padding: 10px;
}
</style>
</head>
<body>

	<table>
		<caption>회원정보 상세보기</caption>

		<tr>
			<th>아이디</th>
			<td>${member.memId}</td>
		</tr>


		<c:if test="${loginId eq member.memId || loginId eq 'admin'}">
			<tr>
				<th>비밀번호</th>
				<td>${member.memPw}</td>
			</tr>
		</c:if>

		<tr>
			<th>이름</th>
			<td>${member.memName}</td>
		</tr>

		<tr>
			<th>생년월일</th>
			<td>${member.memBirth}</td>
		</tr>

		<tr>
			<th>성별</th>
			<td>${member.memGender}</td>
		</tr>

		<tr>
			<th>이메일</th>
			<td>${member.memEmail}</td>
		</tr>

		<tr>
			<th>연락처</th>
			<td>${member.memPhone}</td>
		</tr>

		<tr>
			<th>주소</th>
			<td>${member.memAddr}</td>
		</tr>

		<tr>
			<th>프로필 사진</th>
			<td><img src="resources/profile/${member.memProfileName}"
				width="200px" /></td>
		</tr>



		<c:if test="${loginId eq member.memId || loginId eq 'admin'}">
			<tr>
				<th colspan="2"><input type="button"
					onclick="location.href='mModiForm?memId=${member.memId}'"
					value="수정" /> <input type="button"
					onclick="location.href='mDelete?memId=${member.memId}'" value="삭제" />
				</th>
			</tr>
		</c:if>

	</table>

</body>








</html>