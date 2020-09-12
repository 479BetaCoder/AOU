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
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">Dashboard</a>
                	 </li>
                   </ul>
               
              </div>
            </div>
          </nav>
         

		<div id="loginbox" style="width:500px;margin-top:6%;margin-left:30%"
			class="mainbox col-md-3 col-md-offset-2 col-sm-6 col-sm-offset-2">

			<div class="panel panel-primary">
			<div class="panel-heading">
				<div class="panel-title text-center"><strong style="color: cadetblue;
    			font-weight: 500;
    			font-size: larger;">Product Form</strong></div>
				
				</div>

				<div style="padding-top: 30px" class="panel-body">


	
						<form:form name = "myAddForm" id= "addItemForm" enctype="multipart/form-data" method="POST"  
						action="${pageContext.request.contextPath}/Vendor/saveItem" modelAttribute="vendorItem"
						class="form-horizontal">
						<form:hidden name ="id" path="id"/>
						
						<div class="form-group">
							<div class="col-xs-15">
								<div>

									<!-- Check for registration error -->
									<c:if test="${registrationError != null}">

										<div class="alert alert-danger col-xs-offset-1 col-xs-10">
											${registrationError}</div>

									</c:if>

								</div>
							</div>
						</div>
						
						
						<!-- Item name -->
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:6px"><i class="fas fa-stroopwafel"></i></span>
						<form:input name = "itemName" path="itemName" placeholder="itemName (*)"
								class="form-control" required="required" />
						</div>

						<!-- Item Desc -->
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:6px"><i class="fas fa-mortar-pestle"></i></span>
							<form:textarea  name = "itemDescription" rows="6" cols="20" path="itemDescription" required="required" placeholder="itemDescription (*)"
								class="form-control rounded-0"></form:textarea>
						</div>
						
						
						
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:8px"><i class="fas fa-dollar-sign"></i></span>
						<form:input type="number" step="0.1" name = "itemPrice" min="1" path="itemPrice" placeholder="itemPrice (*)"
								class="form-control" />
						</div>
						
						<!-- Item photo  -->
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:4px">
						<i class="fas fa-camera-retro"></i>
						</span>
						<form:input class="form-control" style="border:0" type="file" accept="image/x-png,image/gif,image/jpeg"  path="itemPhoto"/>
						</div>
						
						

						<!-- Add Button -->
						<div style="margin-top: 15px;margin-left: 20%" class="form-group">
							<div class="col-sm-6 controls">
								<button id="btnSaveItem" type="submit" class="btn btn-success">Save</button>
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