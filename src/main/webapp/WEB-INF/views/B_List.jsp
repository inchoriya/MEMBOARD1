<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board_페이징목록</title>
<style>
	table, td, th{
		border : 1px solid black;
		border-collapse : collapse;
		padding : 10px;
	}
	
	.limitr{
		border : 0px;
		text-align : right;
	}
	
	.trcenter{
		text-align : center;
	}
	
	.space1{
		margin : 5px;
	}
	
	a{
		text-decoration: none;
	}
</style>
</head>
<body>
	<table>
	<caption>게시글 목록</caption>
	
	<tr>
		<th>번호</th>
		<th>제목</th>
		<th>작성자</th>
		<th>작성일</th>
		<th>조회수</th>
	</tr>
	
	<c:forEach var="list" items="${pagingList}">
	<tr>
		<td>${list.boNum}</td>
		<td><a href="bView?boNum=${list.boNum}">${list.boTitle}</a></td>
		<td>${list.boWriter}</td>
		<td>${list.boDate}</td>
		<td>${list.boHit}</td>
	</tr>
	</c:forEach>
	
	<tr>
	<td colspan="5"  class="limitr">
		<select onchange="changeLimit(this.value)">
			<option value="5">게시글 갯수</option>
			<option value="5">5개씩</option>
			<option value="10">10개씩</option>
			<option value="20">20개씩</option>
		</select>
		
	</td>
	</tr>
	
	<tr>
	<td colspan="5" class="trcenter">
	
	
	
	
	
	<!-- 페이징 처리 -->
	<!-- [처음]페이지에 대한 처리 -->
	<c:if test="${paging.page <= 1}"><c:out value="<< 처음"/></c:if>
	<c:if test="${paging.page > 1}">
		<a href="bList?page=1&limit=${paging.limit}"><c:out value="<< 처음"/></a>
	</c:if>
	
	
	<!-- [이전]페이지에 대한 처리 -->
	<c:if test="${paging.page <= 1}"><c:out value="< 이전"/></c:if>
	<c:if test="${paging.page > 1}">
		<a href="bList?page=${paging.page-1}&limit=${paging.limit}"><c:out value="< 이전"/></a>
	</c:if>
	
	<!-- [페이지번호]페이지에 대한 처리 -->
	<c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}">
	
	<c:choose>
	
	<c:when test="${paging.page == i}">
	<span class="space1">[${i}]</span>
	</c:when>
	
	<c:otherwise>
		<span class="space1"><a href="bList?page=${i}&limit=${paging.limit}">${i}</a></span>
	</c:otherwise>
	
	</c:choose>
	
	</c:forEach>	
	<!-- [다음]페이지에 대한 처리 -->
	<c:if test="${paging.page >= paging.maxPage}"><c:out value="다음 >"/></c:if>
	<c:if test="${paging.page < paging.maxPage}">
		<a href="bList?page=${paging.page+1}&limit=${paging.limit}"><c:out value="다음 >"/></a>
		
	</c:if>
	
	<!-- [마지막]페이지에 대한 처리 -->
	<c:if test="${paging.page >= paging.maxPage}"><c:out value="마지막 >>"/></c:if>
	<c:if test="${paging.page < paging.maxPage}">
		<a href="bList?page=${paging.maxPage}&limit=${paging.limit}"><c:out value="마지막 >>"/></a>
		
	</c:if>
	
	</td>
	</tr>
	
	</table>
</body>

<script>
	function changeLimit(limit){
		location.href="bList?limit="+limit;
	}
</script>


</html>