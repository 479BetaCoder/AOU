<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>  
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	

<!DOCTYPE HTML>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
 <title>Home</title>
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
<!-- Your custom styles (optional) -->
  <link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
<header>
          <!--Navbar-->
          <nav class="navbar navbar-expand-lg navbar-dark fixed-top scrolling-navbar">
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
                    <span class="sr-only">(current)</span>
                   <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}/Login">Sign In</a>
                   </li>
                   </ul>
               
              </div>
            </div>
          </nav>
  
          <!-- Full Page Intro -->
          <div class="view" style="background-image: url('${pageContext.request.contextPath}/resources/images/food_bg.jpg'); background-repeat: no-repeat; background-size: cover; background-position: center center;">
            <!-- Mask & flexbox options-->
            <div class="mask rgba-gradient align-items-center">
              <!-- Content -->
              <div class="container">
                <!--Grid row-->
                <div class="row">
                  <!--Grid column-->
                  <div class="col-md-6 white-text text-center text-md-left mt-xl-5 mb-5 wow fadeInLeft" data-wow-delay="0.3s">
                    <h1 class="h1-responsive font-weight-bold mt-sm-5">Make purchases with A<i class="fas fa-globe-americas"></i>U </h1>
                    <hr class="hr-light">
                    <h6 class="mb-4">We help you in your celebrations. Get unprecedented offers with our application. We also help business to connect with customers. </h6>
                    <a href="${pageContext.request.contextPath}/register/userRegistrationForm?role=2" class="btn btn-white">New User</a>
                    <a href="${pageContext.request.contextPath}/register/userRegistrationForm?role=3" class="btn btn-outline-white">New Vendor</a>
                  </div>
                  <!--Grid column-->
                  <!--Grid column-->
                  <div class="col-md-6 col-xl-5 mt-xl-5 wow fadeInRight" data-wow-delay="0.3s">
                  <!--    <img src="https://mdbootstrap.com/img/Mockups/Transparent/Small/admin-new.png" alt="" class="img-fluid"> -->
                  </div>
                  <!--Grid column-->
                </div>
                <!--Grid row-->
              </div>
              <!-- Content -->
            </div>
            <!-- Mask & flexbox options-->
          </div>
          <!-- Full Page Intro -->
        
        <!-- Main navigation -->
        <!--Main Layout-->
       
   

  
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