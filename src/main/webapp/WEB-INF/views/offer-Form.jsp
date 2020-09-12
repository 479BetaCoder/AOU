<%@ include file="common/header.jsp"%>
<script>
$(document).ready(function() {
	
		$("#addOfferForm").on( "submit", function( event ) {
		
		  event.preventDefault();
		 
		  $.post("${pageContext.request.contextPath}/Admin/saveOffer", $(this).serialize())
			.done(function(data) {
				if(data == "1"){
					 $('#statusContainer').addClass("alert alert-success")
					 $('#statusContainer').html("An offer is successfully made");
					 
				}	
				if(data == "0"){
					 $('#statusContainer').addClass("alert alert-danger")
					 $('#statusContainer').html("Some issue in offering the user. Try after some time");
					 
				}	
				if(data == "-1"){
					 $('#statusContainer').addClass("alert alert-warning")
					 $('#statusContainer').html("Cannot offer user. Make sure you are logged in");
					 
				}
	         $("#userActionContainer").html("");
	  		});
		});
		
		var date = new Date($('#hdnEventDate').val());
		
		 $( "#datepicker" ).datepicker({
			 minDate:new Date(),
			 maxDate: addDays(date,-2)
		});
		 
});


</script>
<c:choose>
<c:when test="${theBulkOrder eq null}">
<div class="alert alert-warning" role="alert" style="margin-left:125px">
Some issue in accessing the resource. Please try again.
</div>
</c:when>
<c:otherwise>


<div id= "offerFormContainer">
				<div class="panel panel-primary">

				<div class="panel-heading">
				<div class="panel-title text-center"><strong style="color: cadetblue;
    font-weight: 500;
    font-size: larger;">Offer Form</strong></div>
    
    <div style="padding-top: 30px" class="panel-body">
	
						<form:form name = "myOfferForm" id= "addOfferForm" method="POST" 
						action="${pageContext.request.contextPath}/Admin/saveOffer" modelAttribute="theBulkOrder"
						class="form-horizontal">
						<form:hidden name ="id" path="id"/>
						<input type="hidden" id="hdnEventDate" value="<fmt:formatDate pattern="yyyy-MM-dd" value="${theBulkOrder.eventDate}"/>"/>
						<!-- Item name -->
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:10px"><i class="far fa-user"></i></span>  
						<input type="text" disabled name = "userName" value="${theBulkOrder.user.userName}" 
								class="form-control" />
						</div>
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:10px"><i class="fas fa-calendar-alt"></i></span>  
						<input type="text" id="eventDate" disabled name = "eventDate" value="${fn:substring(theBulkOrder.eventDate, 0, 11)}" 
								class="form-control" />
						</div>

						<!-- offer code -->
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:10px"><i class="fas fa-qrcode"></i></span>
							<form:input name = "offerCode" path="offerCode" required="required" placeholder="offerCode (*)"
								class="form-control" />
						</div>
						
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:10px"><i class="fas fa-mortar-pestle"></i></span>
						<form:textarea rows="3" cols="4" name = "offerDesc" required="required" path="offerDesc" placeholder="offerDescription (*)"
								class="form-control"></form:textarea>
						</div>
						
						<div style="margin-bottom: 25px" class="input-group">
						<span style="padding:10px"><i class="fas fa-clock"></i></span>
						<form:input name = "offerExpiry" id="datepicker" required="required" path="offerExpiry" placeholder="offerExpiry (*)"
								class="form-control" />
						</div>

						<!-- Add Button -->
						<div style="margin-top:10px;float:right" class="form-group">
							<div class="col-sm-6 controls">
								<button id="btnSaveOffer" style="width:100px" type="submit" class="btn btn-primary">Save Offer</button>
							</div>
						</div>

					</form:form>
					</div>

			</div>

		</div>

	</div>
	</c:otherwise>
</c:choose>

