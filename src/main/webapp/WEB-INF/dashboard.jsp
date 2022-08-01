<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>Add a book</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
	<div class="container w-75">
	<c:if test="${not empty success}">
			<div class="alert alert-success mt-4"><c:out value="${success}"/></div>
		</c:if>
		<div class="w-100 d-flex justify-content-end">
			<a style="color:#603F8B" href='<c:url value="/guest/signin/logout"/>' class="ml-4" ><u>Logout</u></a>
		</div>
		
	<h1>Current listings</h1>

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
				<c:forEach items="${pools}" var="item">
					<tr>	
						<td ><c:out value="${item.address}"/></td>
						<td ><c:out value="${item.poolSize}"/></td>
						<td ><c:out value="${item.cost}"/></td>
						<td >
							<a href='<c:url value="/pools/${item.id}"/>' ><fmt:formatNumber type="number" maxFractionDigits="2" value="${item.rating}"/> - edit</a>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		
		<div >
			<div class="d-flex align-items-center justify-content-between">
				<h1 class="mb-2">New listing</h1>
			</div>
			<form:form class="border border-3 p-4 border-dark" method="post" modelAttribute="pool" action="/host/dashboard">
			<div class="mb-3"> 
				<form:label path="address" class="form-label">Address:</form:label>
				<form:input  path="address" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
				<form:errors path="address" cssClass="invalid-feedback"/>
			</div>
			<div class="mb-3">
				<form:label path="description" class="form-label">Description:</form:label>
				<form:textarea path="description" cssClass="form-control" cssErrorClass="form-control is-invalid"></form:textarea>
				<form:errors path="description" cssClass="invalid-feedback"/>
			</div>
			<div class="mb-3">
				<form:label path="cost" class="form-label">Cost per night: </form:label> $
				<form:input  path="cost" type="number" cssClass="form-control" cssErrorClass="form-control is-invalid"/>
				<form:errors  path="cost" cssClass="invalid-feedback"/>
			</div>
			<div class="mb-3">
						<form:select path="poolSize" cssClass="form-control" cssErrorClass="form-control is-invalid">
							<form:option value="Small">Small</form:option>
							<form:option value="Meduim">Meduim</form:option>
							<form:option value="Large">Large</form:option>
						</form:select>
						<form:errors  path="poolSize" cssClass="invalid-feedback"/>
					</div>
			<input type="submit" value="Add Listing" class="btn btn-dark">
		</form:form>
		</div>
		
	</div>
    
	
</body>
</html>
