<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    


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
		
		<div class="d-flex align-items-center justify-content-between ">		 
			<div>
			<form:form  method="post" modelAttribute="review" action="/pools/${poolid}/review/add">	
				<div class="mb-3"> 
					<form:label path="comment" class="form-label">Review of <c:out value="${pool.address}"/></form:label>
					<form:textarea cols="70" rows="10" path="comment" cssClass="form-control" cssErrorClass="form-control is-invalid"  ></form:textarea>
					<form:errors path="comment" cssClass="invalid-feedback"/>
				</div>
				<div class="mb-3">
					<form:select path="rating" cssClass="form-control" cssErrorClass="form-control is-invalid">
						<form:option value="1">1</form:option>
						<form:option value="2">2</form:option>
						<form:option value="3">3</form:option>
						<form:option value="4">4</form:option>
						<form:option value="5">5</form:option>
					</form:select>
					<form:errors  path="rating" cssClass="invalid-feedback"/>
				</div>
				
				<input type="submit" value="Save" class="btn btn-dark">
			</div>
			
			</form:form>
			
	
    </div>
	
</body>
</html>