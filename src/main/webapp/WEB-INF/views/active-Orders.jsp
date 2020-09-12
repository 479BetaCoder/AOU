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
	
	$('#tblActiveOrders').DataTable({
		"pagingType":"simple",
		
	});
	
	$('.dataTables_length').addClass('bs-select');
	
	
});

</script>

<div id="activeBulkOrders">
<c:choose>
<c:when test="${activeOrders == null || fn:length(activeOrders) eq 0}">
<div class="alert alert-warning" role="alert">
<i class="fas fa-frown"></i> No Active orders at the moment
</div>
</c:when>
<c:otherwise>
<div>
<table id="tblActiveOrders" class="table">
  <thead class="thead-light">
    <tr>
     	<th class="th-sm" scope="col">Event Date</th>
      	<th class="th-sm" scope="col">Comment</th>
	  	<th class="th-sm" scope="col">Cart Value</th>
    	<th class="th-sm" scope="col">Order Summary</th>
    	<th class="th-sm" scope="col">Action</th>
	</tr>
  </thead>
  <tbody>
 
	<c:forEach var="activeBulkOrder" items="${activeOrders}" varStatus="theItemCount">
	
				<tr>
				<td>${fn:substring(activeBulkOrder.eventDate, 0, 11)}</td>
				<td>${activeBulkOrder.bulkOrderDesc}</td>
				<td>${activeBulkOrder.cartValue}</td>
				<td>
				<div>
	<table id="tblOrderSummary" class="table table-striped table-bordered table-sm">
  	<thead>
    <tr>
     	<th class="th-sm">Vendor Name</th>
      	<th class="th-sm">Item Name</th>
	  	<th class="th-sm">Item Description</th>
    	<th class="th-sm">Quantity</th>
	</tr>
  </thead>
  <tbody>
 
	<c:forEach var="order" items="${activeBulkOrder.orderList}" varStatus="theItemCount">
	
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
<td>
<div style="padding:30px">
<a href="#" title="Give Offer" class = "lnkGiveOffer" id="${activeBulkOrder.id}"><i class="fas fa-gift"></i></a>
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