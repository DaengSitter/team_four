<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style>
			table {border-collapse: collapse;}
		</style>
	</head>
	
	<body>
	<c:forEach var="vo" items="${list }">
		<table border="1" align="center" width="700">
		<c:if test="${vo.onecomment_delete eq 0 }">
			<tr>
				<input type="hidden" name="onecomment_idx" value="${vo.onecomment_idx }">
				<td>작성자</td>
				<td>${vo.onecomment_admin_name }</td>
			</tr>
			<tr>
				<td>작성일</td>
				<td>${vo.onecomment_regdate }</td>
			</tr>

			<tr>
				<td>답변내용</td>
				<td>${vo.onecomment_content }</td>
			</tr>
		</c:if>
		</table>
		<br>
	</c:forEach>
	</body>
</html>