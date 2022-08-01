<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>Search for a pool </title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
	<div class="container w-75">
		<c:if test="${not empty success}">
			<div class="alert alert-success mt-4"><c:out value="${success}"/></div>
		</c:if>
		<div class="w-100 d-flex justify-content-end">
		<a style="color:#603F8B" href="/"><u>Home</u></a>
		<c:choose>
			<c:when test="${not empty user_id}"><a style="color:#603F8B" href='<c:url value="/guest/signin/logout"/>' class="ml-4" ><u>Logout</u></a></c:when>
			<c:otherwise><a href="/guest/signin" class="ml-4" style="color:#603F8B" ><u>Signin/Signup</u></a></c:otherwise>
		</c:choose>
		</div>
		
			
		
		<h4 class="mb-5">Find your pool!</h4>
		<form class="row" method="post" action="/search" >
				<div class="ml-3 w-50"> 
					<input  name="search" Class="form-control" placeholder="new location"/>
				</div>
				<div class="ml-2 mb-4"> 
					<input style="background-color:#603F8B"  type="submit" value="Search" class="btn btn-dark">
				</div>
			</form>
		<table class="table">
			<thead>
				<tr>
					<th scope="col">Addresses</th>
					<th scope="col">Pool Size</th>
					<th scope="col" >Cost Per Night</th>
					<th scope="col" >Details</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${pools}" var="pool">
					<tr>	
						<td ><c:out value="${pool.address}"/></td>
						<td ><c:out value="${pool.poolSize}"/></td>
						<td ><c:out value="${pool.cost}"/></td>
						<td >
							<a href='<c:url value="/pools/${pool.id}"/>' ><fmt:formatNumber type="number" maxFractionDigits="2" value="${pool.rating}"/> see more ..</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		
	</div>
    
	
</body>
</html>
