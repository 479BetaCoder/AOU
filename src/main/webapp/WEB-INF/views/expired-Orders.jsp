<%@ include file="common/header.jsp"%>
<script>
$(document).ready(function() {
	 
	$('.lnkGiveOffer').click(function(){
		
		$('#statusContainer').html("");
		
		$.get("${pageContext.request.contextPath}/Admin/showOfferForm", {bulkOrderId: this.id})
		.done(function( data ) {
   		 $('#userActionContainer').html(data);
       
  		});
		});
	
	$('#lnkDeleteAll').click(function(){
		$('#statusContainer').html("");
		$('#statusContainer').removeClass();
		$.get("${pageContext.request.contextPath}/Admin/deleteExpiredOrders")
		.done(function( data ) {
			
			if(data == "1"){
				 $('#statusContainer').addClass("alert alert-success")
				 $('#statusContainer').html("Successfully Deleted Expired Orders");
				 
			}	
			
			if(data == "-1"){
				 $('#statusContainer').addClass("alert alert-warning")
				 $('#statusContainer').html("Some issue in deleting expired orders. Please try after some time");
				 
			}		
			
		$('#userActionContainer').load("${pageContext.request.contextPath}/Admin/showExpiredBulkOrders");
       
  		});
		});
	
	$('#tblExpiredOrders').DataTable({
		"pagingType":"simple",
		
	});
	
	$('.dataTables_length').addClass('bs-select');
	
	
	
});

</script>
<c:choose>
<c:when test="${theExpiredBulkOrders == null || fn:length(theExpiredBulkOrders) eq 0}">
<div class="alert alert-warning" role="alert" style="margin-left:125px">
No Expired orders at the moment.
</div>
</c:when>
<c:otherwise>
<div>

<div  class="alert alert-danger" role="alert">
<a id="lnkDeleteAll" class="btn btn-danger" href="#">Delete All</a>
</div>

<table id="tblExpiredOrders" class="table">
  <thead class="thead-dark">
    <tr>
     	<th class="th-sm" scope="col">Event Date</th>
      	<th class="th-sm"  scope="col">Comment</th>
	  	<th class="th-sm"  scope="col">Cart Value</th>
    	<th class="th-sm"  scope="col">Order Summary</th>
    	
	</tr>
  </thead>
  <tbody>
 
	<c:forEach var="expiredBulkOrder" items="${theExpiredBulkOrders}" varStatus="theItemCount">
	
				<tr>
				<td>${fn:substring(expiredBulkOrder.eventDate, 0, 11)}</td>
				<td>${expiredBulkOrder.bulkOrderDesc}</td>
				<td>${expiredBulkOrder.cartValue}</td>
				<td>
				<div>
	<table id="tblOrderSummary" class="table">
  	<thead class="thead-light">
    <tr>
     	<th class="th-sm" scope="col">Vendor Name</th>
      	<th class="th-sm" scope="col">Item Name</th>
	  	<th class="th-sm" scope="col">Item Description</th>
    	<th class="th-sm" scope="col">Quantity</th>
	</tr>
  </thead>
  <tbody>
 
	<c:forEach var="order" items="${expiredBulkOrder.orderList}" varStatus="theItemCount">
	
				<tr>
				<td>${order.orderItem.vendor.userName}</td>
				<td>${order.orderItem.itemName}</td>
				<td>${order.orderItem.itemDescription}</td>
				<td>${order.orderQuantity}</td>
				
	</c:forEach>
   
  </tbody>
  </table>
 </div>
</td>
</tr>
</c:forEach> 
 </tbody>
 </table>
 </div>
 </c:otherwise>
</c:choose>
