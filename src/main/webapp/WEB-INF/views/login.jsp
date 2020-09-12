<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	

<!DOCTYPE HTML>
<html lang="en">
<head>
<% String title[] = request.getAttribute("javax.servlet.forward.request_uri").toString().split("/"); 
	String pageTitle = title[title.length-1];
%>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
 <title><%= pageTitle %></title>
 <link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/myIcon.JPG" type="image/x-icon" />
  <!-- Font Awesome -->
 <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.1/css/all.css" integrity="sha384-50oBUHEmvpQ+1lW4y57PTFmhCaXp0ML5d60M1M7uH2+nqUivzIebhndOJK28anvf" crossorigin="anonymous">
  <!-- Bootstrap core CSS -->
  <link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">
  <!-- Material Design Bootstrap -->
  <link href="${pageContext.request.contextPath}/resources/css/mdb.min.css" rel="stylesheet">
  <script src="https://cdnjs.cloudflare.com/ajax/libs/wow/1.1.2/wow.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/web-animations/2.2.2/web-animations.min.js"></script>
<script>
new WOW().init();
</script>









<!--Previous Stuff  -->


 
<script>
//Method to add days to date
	 function addDays(date, days) {
	   var dat = date;
	   dat.setDate(dat.getDate() + days);
	   return dat;
	 }
</script>
<style>
.error {
	color: red;
	padding:5px;
}
</style>
	
</head>

 <!-- Start your project here-->
<body>
<header>
          <!--Navbar-->
          <nav class="navbar navbar-expand-lg navbar-dark black fixed-top scrolling-navbar">
            <div class="container">
              <a class="navbar-brand" href="#">
               <strong>A<i class="fas fa-globe-americas"></i>U</strong>
              </a>
              <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-7" aria-controls="navbarSupportedContent-7" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarSupportedContent-7">
                <ul class="navbar-nav mr-auto">
                  <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}">Home</a>
                   <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Login">Sign In</a>
                   <span class="sr-only">(current)</span>
                   </li>
                   </ul>
               
              </div>
            </div>
          </nav>
	

		<div id="loginbox" style="width:500px;margin-top:8%;margin-left:30%" 
			class="mainbox col-md-3 col-md-offset-2 col-sm-6 col-sm-offset-2">

			<div class="panel panel-info">

				<div class="panel-heading">
					<div class="panel-title text-center"><strong style="color: cadetblue;
    font-weight: 500;
    font-size: larger;">Sign In</strong></div>
				</div>

				<div style="padding-top: 30px" class="panel-body">

					<!-- Login Form -->
					<form:form
						action="${pageContext.request.contextPath}/authenticateTheUser"
						method="POST" class="form-horizontal">

						<!-- Place for messages: error, alert etc ... -->
						<div class="form-group">
							<div class="col-xs-15">
								<div>

									<!-- Check for login error -->

									<c:if test="${param.error != null}">

										<div class="alert alert-danger col-xs-offset-1 col-xs-10">
											Invalid username or password.</div>

									</c:if>

									<!-- Check for logout -->

									<c:if test="${param.logout != null}">

										<div class="alert alert-success col-xs-offset-1 col-xs-10">
											You have been logged out.</div>

									</c:if>

								</div>
							</div>
						</div>

						<!-- User name -->
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-user"></i></span> <input type="text"
								name="username" placeholder="username" class="form-control">
						</div>

						<!-- Password -->
						<div style="margin-bottom: 25px" class="input-group">
							<span class="input-group-addon"><i
								class="glyphicon glyphicon-lock"></i></span> <input type="password"
								name="password" placeholder="password" class="form-control">
						</div>

						<!-- Login/Submit Button -->
						<div style="margin-top: 10px" class="form-group">
							<div class="col-sm-5 controls" style="margin-left: 30%">
								<button type="submit" class="btn btn-success">Login</button>
							</div>
						</div>

					</form:form>

				</div>

			</div>
			</div>

	
	 
</header>
 </body>
<!-- SCRIPTS -->
  <!-- JQuery -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/jquery-3.3.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mdb.min.js"></script>
  </html>