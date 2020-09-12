<%@ include file="common/header.jsp"%>
<script>
$(document).ready(function() {
	 
$('#tblOrderSummary').DataTable({
		"pagingType":"simple",
		
	});
	
	$('.dataTables_length').addClass('bs-select');
	
	
	
});

</script>

<div id="bulkOrderHistory">
<c:choose>
<c:when test="${orderHistList == null || fn:length(orderHistList) eq 0}">
<div class="alert alert-warning" role="alert" style="margin-left:125px">
No order history
</div>
</c:when>
<c:otherwise>
<div>
<table id="tblOrderSummary" class="table">
  <thead class="thead-dark">
    <tr>
     	<th class="th-sm" scope="col">Event Date</th>
      	<th class="th-sm" scope="col">Comment</th>
	  	<th class="th-sm" scope="col">Cart Value</th>
    	<th class="th-sm" scope="col">Order Status</th>
		<th class="th-sm" scope="col">Offer Code</th>
		<th class="th-sm" scope="col">Offer Info</th>
		<th class="th-sm" scope="col">Expiry</th>
		<th class="th-sm" scope="col">Order Summary</th>
	</tr>
  </thead>
  <tbody>
 
	<c:forEach var="bulkOrder" items="${orderHistList}" varStatus="theItemCount">
	
				<tr>
				<td>${fn:substring(bulkOrder.eventDate, 0, 11)}</td>
				<td>${bulkOrder.bulkOrderDesc}</td>
				<td>${bulkOrder.cartValue}</td>
				<td>${bulkOrder.bulkOrderStatus}</td>
				<td>${bulkOrder.offerCode}</td>
				<td>${bulkOrder.offerDesc}</td>
				<td>${fn:substring(bulkOrder.offerExpiry, 0, 11)}</td>
				<td>
				<div>
	<table id="tblOrderSummary" class="table table-striped table-bordered table-sm">
  	<thead class="thead-light">
    <tr>
     	<th class="th-sm" scope="col" >Vendor Name</th>
      	<th class="th-sm" scope="col">Item Name</th>
	  	<th class="th-sm" scope="col">Item Description</th>
    	<th class="th-sm" scope="col">Quantity</th>
		
		
	</tr>
  </thead>
  <tbody>
 
	<c:forEach var="order" items="${bulkOrder.orderList}" varStatus="theItemCount">
	
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
</div>