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
    <title>Income</title>
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
    <div class="container my-3">
      <h2 class="text-center">Add New Income</h2>
      <form action="incomeServlet2" method = "post" id="form">
   
        <div class="form-group">
          <label for="title">Customer Name</label>
          <input type="text" class="form-control" id="customer" name="customer" aria-describedby="emailHelp">
        </div>
        <div class="form-group">
          <label for="title">Amount</label>
          <input type="text" class="form-control" id="Amount" name="amount" aria-describedby="emailHelp">
        </div>
        <div class="form-group">
          <label for="title">Payment Method</label>
          <input type="text" class="form-control" id="method" name="method" aria-describedby="emailHelp">
        </div>
        <div class="form-group">
          <label for="title">Date</label>
          <input type="date" class="form-control" id="date" name="date" aria-describedby="emailHelp">
        </div>
        <button type="submit" id = "add-note-btn" name = "action" value = "add" class="btn btn-primary mt-4">Add Income</button>
        <button type="submit" id = "add-note-btn" name = "action" value = "read" onclick = "loadIncomeChart()" class="btn btn-primary mt-4">View all Incomes</button>
      </form>
    </div>

    <div class="container">
      <h3 class="text-center">All Incomes</h3>
      <table class="table table-bordered border-dark">
          <thead>
            <tr class="text-center">
              <th scope="col">Sr No</th>
              <th scope="col">Customer Name</th>
              <th scope="col">Amount</th>
              <th scope="col">Payment Method</th>
              <th scope="col">Date</th>
              <th scope="col">Edit</th>
            </tr>
          </thead>
          <tbody id="table-body">
          
          <c:forEach var="in" items="${list}">
          	<tr class="text-center">
              <th scope="row">${in.id}</th>
              <td>${in.customer}</td>
              <td>${in.amount}</td>
              <td>${in.payment_method}</td>
              <td>${in.date}</td>
              <td>	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#Update${in.id}">
				  Update</button>
				<button type="button" class="btn btn-danger " value = "delete" data-bs-toggle="modal" data-bs-target="#Delete${in.id}">
				  Delete</button>
            </tr>
            
            	<!--Uppdate Modal -->
				<div class="modal fade" id="Update${in.id}" tabindex="-1" aria-labelledby="updateModalLabel${in.id}" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="updateModalLabel${in.id}">Update Record</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
						  <form action="incomeServlet2" method = "post" id="form">
						   <input type="hidden" class="form-control" name ="id" value = "${in.id}" aria-describedby="emailHelp">
						    <div class="form-group">
					          <label for="title">Customer Name</label>
					          <input type="text" class="form-control" id="customer" name="customer" aria-describedby="emailHelp">
					        </div>
					        <div class="form-group">
					          <label for="title">Amount</label>
					          <input type="text" class="form-control" id="amount" name="amount" aria-describedby="emailHelp">
					        </div>
					        <div class="form-group">
					          <label for="title">Payment Method</label>
					          <input type="text" class="form-control" id="method" name="method" aria-describedby="emailHelp">
					        </div>
					        <div class="form-group">
					          <label for="title">Date</label>
					          <input type="date" class="form-control" id="date" name="date" aria-describedby="emailHelp">
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
			<div class="modal fade" id="Delete${in.id}" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			  <div class="modal-dialog">
			    <div class="modal-content">
			      <div class="modal-header">
			        <h5 class="modal-title" id="exampleModalLabel">Delete Record</h5>
			        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
			      </div>
			      <form action="incomeServlet2" method="post">
				      <div class="modal-body">
				       <input type="hidden" class="form-control" name ="id" value = "${in.id}" aria-describedby="emailHelp">
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
	<script>
		let form = document.getElementById("form");
		function submit()
		{
			form.reset();
		}
	</script>
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