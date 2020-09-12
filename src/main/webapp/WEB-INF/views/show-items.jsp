<%@ include file="common/header.jsp"%>
<script>
$(document).ready(function() {
	$('.lnkRemove').click(function(){
		
		 $('#statusContainer').removeClass();
		
	if(!(confirm('Are you sure you want to delete this item ?'))) return false;
		$.post("${pageContext.request.contextPath}/Vendor/deleteItem", {itemId : this.id})
		.done(function( data ) {
		if(data == "1"){
			 $('#statusContainer').addClass("alert alert-success")
			 $('#statusContainer').html("Successfully deleted item");
			 
		}	
		if(data == "0"){
			 $('#statusContainer').addClass("alert alert-danger")
			 $('#statusContainer').html("Some issue in deleting the item. Try after some time");
			 
		}	
		if(data == "-1"){
			 $('#statusContainer').addClass("alert alert-warning")
			 $('#statusContainer').html("Cannot delete item. The item is in committed orders list");
			 
		}	
   		
         $("#userActionContainer").load("${pageContext.request.contextPath}/Vendor/showMyProducts");
  		});
		});
	
	});
</script>
<c:choose>
<c:when test="${items == null || fn:length(items) eq 0}">
<div class="alert alert-warning" role="alert">
<i class="fas fa-frown"></i> You are yet to add items.
</div>
</c:when>
<c:otherwise>
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
<img class="card-img-top" style="height:250px" alt="No Image" src="${pageContext.request.contextPath}/Vendor/imageDisplay?itemId=${item.id}">
</c:otherwise>
</c:choose>
 <div class="card-body">
 	<i class="fas fa-dollar-sign"></i>
    ${item.itemPrice}
    <h5 style="padding-top:15px" class="card-title">
   <span style="padding:6px"><i class="fas fa-stroopwafel"></i></span>
    ${item.itemName}  
    </h5>
   <p style="padding-top:10px" class="card-text">
   <span style="padding:6px"><i class="fas fa-mortar-pestle"></i></span>${item.itemDescription}
   </p>
  
<div class="card-footer">
    <a class ="lnkUpdate" id="${item.id}" href="${pageContext.request.contextPath}/Vendor/showItemForUpdate?itemId=${item.id}"><i class="fas fa-edit"></i></a>
    |
    <a class ="lnkRemove" id="${item.id}" href="#"><i style="color:red" class="fas fa-trash-alt"></i></a>
    </div>
  </div>
  </div>
  </div>
</c:forEach>
</div>
</c:otherwise>
</c:choose>