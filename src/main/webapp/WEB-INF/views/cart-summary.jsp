<%@ include file="common/header.jsp"%>

<script>
$(document).ready(function() {
	 
	$('.lnkDeleteOrder').click(function(){
		 $('#statusContainer').removeClass();
		if(!(confirm('Are you sure you want to delete this Item from cart ?'))) return false;
		$.post("${pageContext.request.contextPath}/User/deleteOrder", {orderIndex: this.id})
		.done(function( data ) {
			if(data == "1"){
				 $('#statusContainer').addClass("alert alert-success")
				 $('#statusContainer').html("Successfully deleted item from cart");
				 
			}	
			if(data == "0"){
				 $('#statusContainer').addClass("alert alert-warning")
				 $('#statusContainer').html("Some issue in deleting the item. Try after some time");
				 
			}	
			if(data == "-1"){
				 $('#statusContainer').addClass("alert alert-danger")
				 $('#statusContainer').html("Cannot delete item. Please try after some time ");
				 
			}		
   		 $("#userActionContainer").load("${pageContext.request.contextPath}/User/showMyCart");
  		});
		});
	
	$('#btnPlaceOrder').click(function(){
		 $('#statusContainer').html("");
		 $('#statusContainer').removeClass();
			$.get("${pageContext.request.contextPath}/User/placeOrder")
			.done(function( data ) {
				$('#userActionContainer').html(data);
				
	  		});
			});
	
});



</script>


<div id="bulkOrderContainer">

<c:choose>
<c:when test="${bulkOrder == null || fn:length(bulkOrder.orderList) eq 0}">
<div class="alert alert-warning" role="alert">
<i class="fas fa-frown"></i> No orders in your cart at the moment. Please start ordering
</div>
</c:when>
<c:otherwise>
<div>
<i class="fas fa-shopping-cart"></i> | <i class="fas fa-dollar-sign"></i> ${bulkOrder.bulkOrderCost} | <button id="btnPlaceOrder" class="btn btn-success" >Place Order</button>
</div>
<div class="row">
<c:forEach var="order" items="${bulkOrder.orderList}" varStatus="theItemCount">
<c:choose>
<c:when test="${fn:length(bulkOrder.orderList) lt 3}">
<% String  csclass = "col-sm-6 py-2"; %>
</c:when>
<c:otherwise>
<% String  csclass = "col-sm-4 py-2"; %>
</c:otherwise>
</c:choose>
<div class="${csclass}" style="padding-right:20px;padding-top:10px">
<div class="card h-100" style="width: 18rem">
 <c:choose>
<c:when test="${empty order.orderItem.itemPic}">   
<img class="card-img-top" style="height:250px" src="${pageContext.request.contextPath}/resources/images/default_food.jpg" alt="No image">
 </c:when>
<c:otherwise>
<img class="card-img-top" style="height:250px" alt="No Image" src="${pageContext.request.contextPath}/User/imageDisplay?itemId=${order.orderItem.id}">
</c:otherwise>
</c:choose>
<div class="card-body">
 	<i class="fas fa-dollar-sign"></i>
   ${order.orderItem.itemPrice}
    <h5 style="padding-top:15px" class="card-title">
   <span style="padding:6px"><i class="fas fa-stroopwafel"></i></span>
    ${order.orderItem.itemName}  | ${order.orderItem.vendor.userName}
    </h5>
   <p style="padding-top:10px" class="card-text">
   <span style="padding:6px"><i class="fas fa-mortar-pestle"></i></span>${order.orderItem.itemDescription}
   </p>
  
<div class="card-footer">
	${order.orderQuantity} | <i style="padding-left:2px" class="fas fa-money-bill-wave"></i> ${order.orderCost} |
   <a class ="lnkDeleteOrder" id="${theItemCount.index}" href="#"><i style="color:red" class="fas fa-trash-alt"></i></a>
    </div>
  </div>
  </div>
  </div>
</c:forEach>
</div>
 </c:otherwise>
</c:choose>
</div>