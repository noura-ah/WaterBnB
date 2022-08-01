<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Show a pool</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<body>
	<div class="container w-75 ">
		<div class="w-100 d-flex justify-content-end">
		<a style="color:#603F8B" href="/"><u>Home</u></a>
		<c:choose>
			<c:when test="${not empty user_id}"><a style="color:#603F8B" href='<c:url value="/guest/signin/logout"/>' class="ml-4" ><u>Logout</u></a></c:when>
			<c:otherwise><a href="/guest/signin" class="ml-4" style="color:#603F8B" ><u>Signin/Signup</u></a></c:otherwise>
		</c:choose>
		</div>
		<br>
		<br>
		<div class=" d-flex  justify-content-between">
			<c:choose>
			 	<c:when test="${user_id == pool.user.id}">			 
			<div class="">
			<form:form  method="put" modelAttribute="pool" action="/pools/${poolid}/edit">	
				<div class="mb-3"> 
					<form:label path="address" class="form-label">Address:</form:label>
					>hr
					<form:input  path="address" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
					<form:errors path="address" cssClass="invalid-feedback"/>
				</div>
				<div class="mb-3">
					<form:label path="description" class="form-label">Description:</form:label>
					<form:textarea path="description" cols="70" rows="10" cssClass="form-control" cssErrorClass="form-control is-invalid"></form:textarea>
					<form:errors path="description" cssClass="invalid-feedback"/>
				</div>
				<input type="submit" value="Save" class="btn btn-dark">
			</div>
			<div>
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
				
			</div>
			</form:form>
			</c:when>
				<c:otherwise>
						<div class="w-75">
							<p><c:out value="${pool.address}"/></p>
							<hr>
							<p class="mr-4"><c:out value="${pool.description}"/></p>
						</div>
						
						<div class="w-50 ml-5">
							<p>Email: <c:out value="${pool.user.email}"/></p>
							<p>Name: <c:out value="${pool.user.firstname}"/> <c:out value="${pool.user.lastname}"/></p>
							<p>Pool size: <c:out value="${pool.poolSize}"/></p>
							<p>Cost: <c:out value="${pool.cost}"/></p>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
			<br>
		<div class="d-flex align-items-center justify-content-between">
			Reviews (<fmt:formatNumber type="number" maxFractionDigits="2" value="${pool.rating}"/> /5.0)
			
			<c:if test="${user_id != pool.user.id}"><a href="/pools/${pool.id}/review">Leave a review</a></c:if>
			
			
		</div>
		<br>
		<div class="card  ">
			<c:forEach items="${pool.reviews}" var="item" >
			<div class="p-3 ">
				<div><c:out value="${item.user.firstname}"/> <c:out value="${item.user.lastname}"/>:</div>
				<div>Rating :<c:out value="${item.rating}"/>/5</div>
				<div class="ml-3"><c:out value="${item.comment}"/></div>
			</div>
			<hr>
			</c:forEach>
		</div>
	
    </div>
	
</body>
</html>