<%@ include file="common/header.jsp"%>

<script>

$(document).ready(function () {
	
	
	    $(".lnkGetItems").click(function() {
	    $('#statusContainer').removeClass();	
		var category = $("#selCategory option:selected").val();
		var selAouFilter = $("#selDistance option:selected").val();
		$.ajax({
	         type: "GET",
	         cache: false,
	         url: "${pageContext.request.contextPath}/User/showFilteredBulkOrder",
	         data: {selCategory:category,aouFilter:selAouFilter},
	         success: function(response){
	        	 $('#userActionContainer').html(response);
	        	 $("#selCategory").val(category);
	        	 $("#selDistance").val(selAouFilter);
	       		
	        	 
	         }
	    });
	});	
	
	$('.lnkAddItemToCart').click(function() {
	$('#statusContainer').removeClass();
	var itemId = this.id;
	var quantity = $('#' + itemId).val()
	$.ajax({
         type: "POST",
         cache: false,
         url: "${pageContext.request.contextPath}/User/addOrder",
         data: {selItemId: itemId,selQuantity:quantity},
         success: function(data){
        	 if(data == "1"){
    			 $('#statusContainer').addClass("alert alert-success")
    			 $('#statusContainer').html("Successfully added item to cart");
    			 
    		}	
    		if(data == "-1"){
    			 $('#statusContainer').addClass("alert alert-danger")
    			 $('#statusContainer').html("Cannot add item. Please try again later");
    			 
    		}	
            
           
         }
    });
	
});


});
</script>

<div style="margin-bottom: 25px" class="input-group" style="display:inline-block">
<div style="padding-top:4px">
<i class="fas fa-utensils"></i>
</div>
<div id="categorySelector" style="padding-left:10px">


	 	<select id="selCategory" class="form-control">
		<option value="Restaurant">Restaurant</option>
 	 	<option value="Grocery">Grocery</option>
 	 	</select>
 	 	</div>
 
<div style="padding-top:4px;padding-left:15px">
<i class="fas fa-walking"></i>
</div>	 	

<div id="aouToggler" style="padding-left:10px">

<select id="selDistance" class="form-control">
		<option value="ALL">ALL</option>
 	 	<option value="AOU">AOU</option>
 	 	</select>
</div> 
<div style="padding-left:25px;padding-top:2px">
 <a  class="lnkGetItems" href="#"><i class="fa-2x fas fa-store"></i></a>
</div>
</div>


<c:choose>
<c:when test="${items != null && fn:length(items) gt 0}">
<div class="row">
<c:forEach var="item" items="${items}">
<c:choose>
<c:when test="${fn:length(items) lt 3}">
<% String  csclass = "col-sm-6 py-2"; %>
</c:when>
<c:otherwise>
<% String  csclass = "col-sm-4 py-2"; %>
</c:otherwise>
</c:choose>
<div class="${csclass}" style="padding-right:20px;padding-top:10px">
<div class="card h-100" style="width: 18rem">
  <c:choose>
  <c:when test="${empty item.itemPic}">   
  <img class="card-img-top" style="height:250px" src="${pageContext.request.contextPath}/resources/images/default_food.jpg" alt="No image">
  </c:when>
<c:otherwise>
<img class="card-img-top" style="height:250px" alt="No Image" src="${pageContext.request.contextPath}/User/imageDisplay?itemId=${item.id}">
</c:otherwise>
</c:choose>
<div class="card-body">
 	<i class="fas fa-dollar-sign"></i>
    ${item.itemPrice}
    <h5 style="padding-top:15px" class="card-title">
   <span style="padding:6px"><i class="fas fa-stroopwafel"></i></span>
    ${item.itemName}  | ${item.vendor.userName}
    </h5>
   <p style="padding-top:10px" class="card-text">
   <span style="padding:6px"><i class="fas fa-mortar-pestle"></i></span>${item.itemDescription}
   </p>
   <div class="card-footer">
 	<select id="${item.id}">
  		<option value=20>20</option>
 	 	<option value=40>40</option>
 	 	<option value=60>60</option>
 	 	<option value=80>80</option>
 	 	</select>
 	 	 <a style="padding-left:4px" id="${item.id}" class="lnkAddItemToCart" href="#"><i style="color:green" class="fas fa-plus-circle"></i></a>
    </div>
  </div>
  </div>
  </div>
 
  </c:forEach>
   
 
 </div> 
</c:when>
<c:when test="${items != null && fn:length(items) eq 0}">
<div class="alert alert-warning" role="alert">
<i class="fas fa-frown"></i> No Vendors are currently offering based on your selection.
</div>
<div>

</div>
</c:when>
</c:choose>
