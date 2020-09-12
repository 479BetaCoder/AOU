<%@ include file="common/header.jsp"%>

<c:choose>
<c:when test="${orders == null || fn:length(orders) eq 0}">
<div class="alert alert-warning" role="alert">
<i class="fas fa-frown"></i> Sorry you have no orders under processing at this moment
</div>
</c:when>
<c:otherwise>
<div class="row">
<c:forEach var="order" items="${orders}">
<c:choose>
<c:when test="${fn:length(orders) lt 3}">
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
<img class="card-img-top" style="height:250px" alt="No Image" src="${pageContext.request.contextPath}/Vendor/imageDisplay?itemId=${order.orderItem.id}">
</c:otherwise>
</c:choose>
 <div class="card-body">
 	<h5 style="padding-top:15px" class="card-title">
   <span style="padding:6px"><i class="fas fa-stroopwafel"></i></span> ${order.orderItem.itemName}  
    </h5>
 	 <p style="padding-top:10px" class="card-text">
   <span style="padding:6px"><i class="fas fa-mortar-pestle"></i></span>${order.orderItem.itemDescription}
   </p>
   <p style="padding-top:10px" class="card-text">
 	<span style="padding:6px"><i class="fas fa-user"></i></span> ${order.bulkId.user.userName}   
  </p>
	<div class="card-footer">
	
    <span style="padding:6px"><i class="fas fa-balance-scale"></i></span> ${order.orderQuantity}
    </div>
  </div>
  </div>
  </div>
</c:forEach>
</div>
 </c:otherwise>
</c:choose>
