<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
      <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"
    />
    <title>Expenses</title>
    <style>
    
    header {
    background-color: #007bff;
    color: #fff;
    padding: 20px 0;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 0 30px;
}

header .logo {
    font-size: 24px;
    font-weight: bold;
}

header nav {
    display: flex;
    gap: 15px;
}

header nav a {
    text-decoration: none;
    color: #fff;
    font-size: 16px;
    transition: color 0.3s;
}

header nav a:hover {
    color: #ffdd57;
}
    
    </style>
  </head>
  <body>
	<header>
        <div class="logo">BizTrack</div>
        <nav>
        	<a href="expenses.jsp">Manage Expenses</a>
        	<a href="income.jsp">Manage Income</a>
            <a href="dashbord.jsp">Dashboard</a>
            <a href="login.jsp">Logout</a>
        </nav>
    </header>
     <!-- Record Added  -->
          <c:if test="${not empty AddMessage}">
	        <div class="alert alert-success alert-dismissible fade show" role="alert">
			  <strong>Success!</strong>  ${AddMessage}
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
    	</c:if>
    	 <!-- Record Updated -->
    	<c:if test="${not empty UpdateMessage}">
	        <div class="alert alert-info alert-dismissible fade show" role="alert">
			  <strong>Success!</strong>  ${UpdateMessage}
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
    	</c:if>
  		<!-- Record Deleted -->
    	<c:if test="${not empty DeleteMessage}">
	        <div class="alert alert-warning alert-dismissible fade show" role="alert">
			  <strong> ${DeleteMessage}</strong> 
			  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
			</div>
    	</c:if>
    <div class="container my-3">
      <h2 class="text-center">Add New Expense</h2>
      <form action="expensesServlet" method = "post">
   
        <div class="form-group">
          <label for="title">Add Expenses</label>
          <input type="text" class="form-control" id="expense" name="expense" aria-describedby="emailHelp">
        </div>
        <div class="form-group">
          <label for="title">Catagory</label>
          <input type="text" class="form-control" id="catagory" name="catagory" aria-describedby="emailHelp">
        </div>
        <div class="form-group">
          <label for="title">Ammount</label>
          <input type="text" class="form-control" id="amount" name="amount" aria-describedby="emailHelp">
        </div>
        <div class="form-group">
          <label for="title">Date</label>
          <input type="date" class="form-control" id="date" name="date" aria-describedby="emailHelp">
        </div>
        <button type="submit" id = "add-note-btn" name = "action" value = "add" class="btn btn-primary mt-4">Add Note</button>
        <button type="submit" id = "add-note-btn" name = "action" value = "read" class="btn btn-primary mt-4">View all Expenses</button>
      </form>
    </div>

    <div class="container">
      <h3 class="text-center">Expense History</h3>
      <table class="table table-bordered border-dark">
          <thead>
            <tr class="text-center">
              <th scope="col">Sr No</th>
              <th scope="col">Exception</th>
              <th scope="col">Catagory</th>
              <th scope="col">Ammount</th>
              <th scope="col">Date</th>
              <th scope="col">Edit</th>
            </tr>
          </thead>
          <tbody id="table-body">
          
          <c:forEach var="ex" items="${list}">
          	<tr class="text-center">
              <th scope="row">${ex.id}</th>
              <td>${ex.expense}</td>
              <td>${ex.catagory}</td>
              <td>${ex.amount}</td>
              <td>${ex.date}</td>
              <td>	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#Update${ex.id}">
				  Update</button>
				<button type="button" class="btn btn-danger " value = "delete" data-bs-toggle="modal" data-bs-target="#Delete${ex.id}">
				  Delete</button>
            </tr>
            
            	<!--Uppdate Modal -->
				<div class="modal fade" id="Update${ex.id}" tabindex="-1" aria-labelledby="updateModalLabel${ex.id}" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="updateModalLabel${ex.id}">Update Record</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
						  <form action="expensesServlet" method = "post">
						   <input type="hidden" class="form-control" name ="id" value = "${ex.id}" aria-describedby="emailHelp">
						    <div class="form-group">
					          <label for="title">Add Expenses</label>
					          <input type="text" class="form-control" id="expense" name="expense" value = "${ex.expense}" aria-describedby="emailHelp">
					        </div>
					        <div class="form-group">
					          <label for="title">Catagory</label>
					          <input type="text" class="form-control" id="catagory" name="catagory" value = "${ex.catagory}" aria-describedby="emailHelp">
					        </div>
					        <div class="form-group">
					          <label for="title">Ammount</label>
					          <input type="text" class="form-control" id="amount" name="amount" value = "${ex.amount}" aria-describedby="emailHelp">
					        </div>
					        <div class="form-group">
					          <label for="title">Date</label>
					          <input type="date" class="form-control" id="date" name="date" value = "${ex.date}" aria-describedby="emailHelp">
					        </div>
				      
				      		<div class="modal-footer">
				        		<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				        		<button type="submit"  name = "action" value = "update" class="btn btn-primary">Save changes</button>
				      		</div>
				      	</form>
				      </div>
				    </div>
				  </div>
				</div>
	
		<!--Delete Modal -->
			<div class="modal fade" id="Delete${ex.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">Delete Record</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <form action="expensesServlet" method="post">
				      <div class="modal-body">
				       <input type="hidden" class="form-control" name ="id" value = "${ex.id}" aria-describedby="emailHelp">
				       <p>Do you realy want to delete this record</p>
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
				        <button type="submit" name = "action" value = "delete" class="btn btn-danger">Delete</button>
				      </div>
			      </form>
			    </div>
			  </div>
			</div>
            
          </c:forEach>
          </tbody>
        </table>
    </div>

    <!-- Option 1: Bootstrap Bundle with Popper -->
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
      crossorigin="anonymous"
    ></script>
    <!-- Option 2: Separate Popper and Bootstrap JS -->
    <!--
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
    -->
  </body>
</html>