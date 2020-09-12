<%@ include file="common/header.jsp"%>
<script>

$(document).ready(function() {
	$('.lnkRemove').click(function(){
	$('#statusContainer').removeClass();
	if(!(confirm('Are you sure you want to delete this vendor ?'))) return false;
		$.post("${pageContext.request.contextPath}/Admin/deleteVendor", {vendorId: this.id})
		.done(function( data ) {
		
			if(data == "1"){
				 $('#statusContainer').addClass("alert alert-success")
				 $('#statusContainer').html("Successfully deleted vendor");
				 
			}	
			if(data == "0"){
				 $('#statusContainer').addClass("alert alert-danger")
				 $('#statusContainer').html("Some issue in deleting the vendor. Try after some time");
				 
			}	
			if(data == "-1"){
				 $('#statusContainer').addClass("alert alert-warning")
				 $('#statusContainer').html("Cannot delete Vendor. Selected Vendor is in committed orders list");
				 
			}		
			 $("#userActionContainer").load("${pageContext.request.contextPath}/Admin/getVendors");
  		});
		});
	
	$('#tblVendors').DataTable({
		"pagingType":"simple",
		
	});
	
	$('.dataTables_length').addClass('bs-select');
	
	
});


</script>
<c:choose>
<c:when test="${empty vendors}">
<div class="alert alert-warning" role="alert">
<i class="fas fa-frown"></i> No Vendors at the moment.
</div>
</c:when>
<c:otherwise>
<div id="vendorsContainer">
	 <table id="tblVendors" class="table">
	 <thead class="thead-dark">
	 
				<tr>
					<th class="th-sm" scope="col">Name</th>
					<th class="th-sm" scope="col">Email</th>
					<th class="th-sm" scope="col">Business Category</th>
					<th class="th-sm" scope="col">Action</th>
				
				</tr>
				</thead>
				<tbody>

				<!-- loop over and print our inActive -->
				<c:forEach var="vendor" items="${vendors}">
				<tr>	<td>${vendor.userName}</td>
						<td>${vendor.email}</td>
						<td>${vendor.vendorCategory}</td>
						<td><a class ="lnkRemove" id="${vendor.id}" href="#"><i style="color:red" class="fas fa-trash-alt"></i></a></td>
					</tr>

				</c:forEach>
 			</tbody>
			</table>
	 </div>
</c:otherwise>
</c:choose>