<%@ include file="common/header.jsp" %>
<!-- Start your project here-->
<head>
<style>
.dashNav { grid-area: header; }
.dashMenu { grid-area: menu; }
.dashAction { grid-area: main; }

.grid-container {
  display: grid;
  grid-template-areas:
    'header header header header header header'
    'menu main main main right right'
    'menu footer footer footer footer footer';
  grid-gap: 10px;
  padding: 10px;
}

.grid-container > div {
  text-align: center;
  padding: 20px 0;
  
}
</style>
</head>

<div class="grid-container" style="margin-top:3%">
<header>
          <!--Navbar-->
          <nav class="navbar navbar-expand-lg navbar-dark fixed-top scrolling-navbar dashNav" id="dashNavBar" style="background:black">
            <div class="container">
              <a class="navbar-brand" href="#">
               <strong>A<i class="fas fa-globe-americas"></i>U</strong>
              </a>
              <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-7" aria-controls="navbarSupportedContent-7" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
              </button>
              <div class="collapse navbar-collapse" id="navbarSupportedContent-7">
                <ul class="navbar-nav mr-auto">
                  <li class="nav-item">
                    <a class="nav-link" href="${pageContext.request.contextPath}">Home</a>
                  </ul>
                  
               </div>
            </div>
          </nav>
          </header>
<div class="alert alert-success" role="alert" style="margin-top:15%;width: 400px;margin-left: 35%;text-align:center;">
<i class="far fa-frown"></i>
Some issue with the request. Please try after some time.
<br><br><a href="${pageContext.request.contextPath}/Login" class="btn btn-warning">Login</a>
</div>
</div>
</html>