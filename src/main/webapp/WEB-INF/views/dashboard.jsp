<%@ include file="common/header.jsp" %>
<!-- Start your project here-->
<head>
<style>
.dashNav { grid-area: header; }
.dashMenu { grid-area: menu; }
.dashAction { grid-area: main; }

.grid-container {
  display: grid;
  grid-template-areas:
    'header header header header header header'
    'menu main main main right right'
    'menu footer footer footer footer footer';
  grid-gap: 10px;
  padding: 10px;
}

.grid-container > div {
  text-align: center;
  padding: 20px 0;
  
}
</style>
</head>

<div class="grid-container" style="margin-top:3%">
<header>
          <!--Navbar-->
          <nav class="navbar navbar-expand-lg navbar-dark fixed-top scrolling-navbar dashNav" id="dashNavBar" style="background:black">
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
                   <span class="sr-only">(current)</span>
                   </li>
                   </ul>
                   <ul class="navbar-nav">
                   <li class="nav-item">
                   <strong class="nav-link"><i> Hello! </i>${user.userName}</strong>
                   </li>
                   </ul>
               
              </div>
            </div>
          </nav>
          </header>

<div class="dashMenu" style="padding-right:50px">

<!-- Greet User.Place left side, corner -->
	

	<!-- display profile left/right side of the screen -->
	
	
	<div class="card" style="width: 16rem;">
  <c:choose>
	<c:when test="${empty user.userDp}">  
  <img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/default-user-image.png" alt="No image">
  </c:when>
<c:otherwise>
<img class="card-img-top" alt="No Image" src="${pageContext.request.contextPath}/register/imageDisplay">
</c:otherwise>
</c:choose>
 <div class="card-body">
    <h5 class="card-title">${user.userName} <a href="${pageContext.request.contextPath}/register/updateMyInfo" class="card-link" id="lnkUpdateInfo"><i class="fas fa-user-edit"></i></a></h5>
     <ul class="list-group list-group-flush">
    <li class="list-group-item"><i class="fas fa-envelope"></i> ${user.email}</li>
    <li class="list-group-item"><i class="fas fa-map-marker-alt"></i> ${user.zipCode}</li>
    <!-- show details of vendor  -->
	<security:authorize access="hasRole('VENDOR')">
	<li class="list-group-item"><i class="fas fa-briefcase"></i> ${user.vendorCategory}</li>
    </security:authorize>
  </ul>
  <div class="card-body">
     <a href="#" class="card-link">
    <form:form action="${pageContext.request.contextPath}/logout"
		method="POST"><input type="submit" class="btn btn-primary" value="Logout" /></form:form></a>
  </div>
</div>
</div>
</div>
<div class="dashAction">
<!-- Tabs -->
<section id="tabs">
	<div class="container">
		<div class="row">
			<div class="col-xs-12 ">
				<nav>
					<div class="nav nav-tabs nav-fill" id="nav-tab" role="tablist">
					 <!-- For Admin -->
	 
	 					<security:authorize access="hasRole('ADMIN')">
	 					
	 					<a role="tab" data-toggle="tab" class="nav-item nav-link" id="lnkGetVendors" href="#">Show Vendors</a>
	 					<a role="tab" data-toggle="tab" class="nav-item nav-link" id="lnkActiveBulkOrders" href="#">Show Bulk Orders</a>
						<a role="tab" data-toggle="tab" class="nav-item nav-link" id="lnkClearOrders" href="#">Clear Orders</a>
	 
						</security:authorize>
						
						<!-- For Vendors  -->
						<security:authorize access="hasRole('VENDOR')">
	 					
	 					<a class="nav-item nav-link" id="lnkAddProducts" href="${pageContext.request.contextPath}/Vendor/showProductForm">Add Products</a>
	 					<a role="tab" data-toggle="tab" class="nav-item nav-link" id="lnkViewProdcuts" href="#">View Products</a>
						<a role="tab" data-toggle="tab" class="nav-item nav-link" id="lnkViewVendorOrders" href="#">My Orders</a>
	 
						</security:authorize>
						
						<!-- For Vendors  -->
						<security:authorize access="hasRole('USER')">
	 					
	 					<a role="tab" data-toggle="tab" class="nav-item nav-link" id="lnkShowBulkOrderDiv" href="#">Bulk Order</a>
	 					<a role="tab" data-toggle="tab" class="nav-item nav-link" id="lnkMyOrders" href="#">My Cart</a>
						<a role="tab" data-toggle="tab" class="nav-item nav-link" id="lnkMyOrderHistory" href="#">Order History</a>
	 
						</security:authorize>
					
					
					
						
					</div>
				</nav>
				
				<div class="tab-content py-3 px-3 px-sm-0" id="nav-tabContent">
				<div id = "statusContainer"  role="alert" style="padding-top:4px;width:500px;margin-left:25%"></div>
					<div class="tab-pane fade show active" id="userActionContainer" role="tabpanel">
					
					</div>
				</div>
			
			</div>
		</div>
	</div>
</section>
</div>
</div>
	
	
<!-- SCRIPTS -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/mdb.min.js"></script>
<script>
$(document).ready(function() {
	
	/* For Admin  */
	$('#lnkGetVendors').click(function() {
	$('#statusContainer').html("");
	 $('#statusContainer').removeClass();
	$.ajax({
         type: "GET",
         cache: false,
         url: "${pageContext.request.contextPath}/Admin/getVendors",
         data: "",
         success: function(response){
             $('#userActionContainer').html(response);
         }
    });
});

	$('#lnkActiveBulkOrders').click(function() {
		$('#statusContainer').html("");
		 $('#statusContainer').removeClass();
		$.ajax({
	         type: "GET",
	         cache: false,
	         url: "${pageContext.request.contextPath}/Admin/showActiveBulkOrders",
	         data: "",
	         success: function(response){
	             $('#userActionContainer').html(response);
	         }
	    });
	});
	
	$('#lnkClearOrders').click(function() {
		$('#statusContainer').html("");
		 $('#statusContainer').removeClass();
		$.ajax({
	         type: "GET",
	         cache: false,
	         url: "${pageContext.request.contextPath}/Admin/showExpiredBulkOrders",
	         data: "",
	         success: function(response){
	             $('#userActionContainer').html(response);
	         }
	    });
	});
	
	// For Vendor

	$('#lnkViewProdcuts').click(function() {
		
		$('#statusContainer').html("");
		 $('#statusContainer').removeClass();
		$.ajax({
	         type: "GET",
	         cache: false,
	         url: "${pageContext.request.contextPath}/Vendor/showMyProducts",
	         data: "",
	         success: function(response){
	             $('#userActionContainer').html(response);
	         }
	    });
	});
	
	$('#lnkViewVendorOrders').click(function() {
		
		$('#statusContainer').html("");
		 $('#statusContainer').removeClass();
		$.ajax({
	         type: "GET",
	         cache: false,
	         url: "${pageContext.request.contextPath}/Vendor/showMyOrders",
	         data: "",
	         success: function(response){
	             $('#userActionContainer').html(response);
	         }
	    });
	});
	
	
		

	/* For Users  */

	$('#lnkMyOrders').click(function() {
		
	$('#statusContainer').html("");
	 $('#statusContainer').removeClass();
	$.ajax({
         type: "GET",
         cache: false,
         url: "${pageContext.request.contextPath}/User/showMyCart",
         data: "",
         success: function(response){
             $('#userActionContainer').html(response);
         }
    });
});

$('#lnkMyOrderHistory').on('click',function(e) {
	e.preventDefault();
	$('#statusContainer').html("");
	 $('#statusContainer').removeClass();
	$.ajax({
         type: "GET",
         
         url: "${pageContext.request.contextPath}/User/showOrderHist",
         data: "",
         success: function(response){
             $('#userActionContainer').html(response);
         }
    });
});


	
$('#lnkShowBulkOrderDiv').on('click',function(e) {
	e.preventDefault();
	$('#statusContainer').html("");
	 $('#statusContainer').removeClass();
	$.ajax({
         type: "GET",
         cache: false,
         url: "${pageContext.request.contextPath}/User/showBulkOrderForm",
         data: "",
         success: function(response){
             $('#userActionContainer').html(response);
         }
    });
});

});
</script>

</html>








