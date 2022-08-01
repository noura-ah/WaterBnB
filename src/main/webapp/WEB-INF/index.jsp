<%@ page isErrorPage="true" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>    


<!DOCTYPE html>
<head>
	<meta charset="UTF-8">
	<title>Register/Login</title>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
</head>
<body>
	<div class="container w-75 d-flex flex-column justify-content-center align-items-center">
		<c:if test="${not empty error}">
			<div class="w-100 alert alert-danger mt-4"><c:out value="${error}"/></div>
		</c:if>
		
		<c:choose>
			<c:when test="${not empty user_id}"><div class="w-100 d-flex justify-content-end"><a style="color:#603F8B" href="/guest/signin/logout"><u>Logout</u></a></div></c:when>
			
			<c:otherwise><div class="w-100 d-flex justify-content-end"><a style="color:#603F8B" href="/guest/signin"><u>Signin/Signup</u></a></div></c:otherwise>
		</c:choose>
		<br>
		
				<div class="w-75">
					<h4>Find places to swim and sleep on water bnb!</h4>
					
					<form  method="get" action="/search">
						<div class="d-flex mb-3"> 
							<input class="w-75 mr-2" name="search" placeholder="location" cssClass="form-control" cssErrorClass="form-control is-invalid"  />
							
						
							<input style="background-color:#603F8B" type="submit" value="Submit" class="btn btn-dark">
						</div>
					</form>
				</div>
		
	</div>
    
	
</body>
</html>
