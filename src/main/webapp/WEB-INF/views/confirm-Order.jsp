<%@ include file="common/header.jsp"%>
<script>
$(document).ready(function() {
	
		$("#bulkOrderForm").on( "submit", function( event ) {
			$('#statusContainer').removeClass();
		 event.preventDefault();
		 
		$.post("${pageContext.request.contextPath}/User/confirmBulkOrder", $( this ).serialize())
		.done(function( data ) {
			if(data == "1"){
				 $('#statusContainer').addClass("alert alert-success")
				 $('#statusContainer').html("Confirmed Order. You will be receiving a quote shortly. Thank you for using AOU.");
				 
			}	
			if(data == "0"){
				 $('#statusContainer').addClass("alert alert-warning")
				 $('#statusContainer').html("Some binding errors.");
				 
			}	
			if(data == "-1"){
				 $('#statusContainer').addClass("alert alert-danger")
				 $('#statusContainer').html("Some issue while confirming your order. Please try after some time. ");
				 
			}		
			$("#userActionContainer").html("");
	   		});
		});
		
		//var dateToday = new Date();
		 $( "#datepicker" ).datepicker({
			minDate: addDays(new Date(),7)
		});
		   
		
});


</script>
<div id= "confirmOrderContainer">
<div class="panel panel-primary">

				<div class="panel-heading">
				<div class="panel-title text-center"><strong style="color: cadetblue;
    font-weight: 500;
    font-size: larger;">Confirm Order</strong></div>
    
    <div style="padding-top: 30px" class="panel-body">
	
						<form:form name = "myBulkOrderForm" id= "bulkOrderForm" method="POST" 
						action="${pageContext.request.contextPath}/User/confirmBulkOrder" modelAttribute="myBulkOrder"
						class="form-horizontal">
						<!-- Item name -->
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:10px"><i class="fas fa-calendar-alt"></i></span>
						<form:input type="text" id="datepicker" name = "eventDate" path="eventDate" placeholder="eventDate (*)"
								class="form-control" required="required" />
						</div>

						<!-- Order Desc -->
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:10px"><i class="fas fa-mortar-pestle"></i></span>
							<form:textarea name = "bulkOrderDesc" rows="4" cols="20" path="bulkOrderDesc" placeholder="Comment"
								class="form-control"></form:textarea>
						</div>
						
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:10px"><i class="fas fa-dollar-sign"></i></span>
						<form:input type="number" name = "cartValue" disabled="true"  path="cartValue" value = "${bulkOrder.bulkOrderCost}"
								class="form-control" />
						</div>

						<!-- Add Button -->
						<div style="margin-top:10px;float:right" class="form-group">
							<div class="col-sm-6 controls">
								<button id="btnConfirmOrder" type="submit" class="btn btn-success">Confirm</button>
							</div>
						</div>

					</form:form>

</div>
</div>
</div>
</div>


</html>