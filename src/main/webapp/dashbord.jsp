<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BizTrack - Income and Expenses Tracker</title>
     <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
      crossorigin="anonymous"
    />
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
      /* General Reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Body Styling */
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f6f9;
    color: #333;
    line-height: 1.6;
    margin: 0;
}

/* Header */
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

/* Main Section */
main {
    padding: 30px;
}

/* Summary Cards */
.summary {
    display: flex;
    justify-content: space-around;
    margin-bottom: 30px;
    gap: 20px;
}

.summary .card {
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
    padding: 20px;
    text-align: center;
    flex: 1;
}

.summary .card h3 {
    font-size: 18px;
    margin-bottom: 10px;
    color: #007bff;
}

.summary .card p {
    font-size: 24px;
    font-weight: bold;
    color: #333;
}

/* Recent Transactions */
.transactions {
    margin-bottom: 30px;
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
    padding: 20px;
}

.transactions h2 {
    font-size: 20px;
    margin-bottom: 15px;
    color: #007bff;
}

.transactions ul {
    list-style-type: none;
}

.transactions ul li {
    padding: 10px 0;
    border-bottom: 1px solid #eee;
    font-size: 16px;
}

.transactions ul li:last-child {
    border-bottom: none;
}

/* Chart Section */
.chart {
    background: #fff;
    border: 1px solid #ddd;
    border-radius: 8px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
    padding: 20px;
    text-align: center;
}

.chart h2 {
    font-size: 20px;
    margin-bottom: 15px;
    color: #007bff;
}

/* Footer */
footer {
    background-color: #007bff;
    color: #fff;
    text-align: center;
    padding: 10px 0;
    margin-top: 30px;
}

footer p {
    font-size: 14px;
}
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <div class="logo">BizTrack</div>
        <nav>
            <a href="dashbord.jsp">Dashboard</a>
            <a href="expenses.jsp">Manage Expenses</a>
            <a href="income.jsp">Manage Income</a>
            <a href="login.jsp">Logout</a>
        </nav>
    </header>

    <!-- Main Section -->
      <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
		  <strong>Success!</strong>  ${successMessage}
		  <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
    </c:if>

    <main>
        <section class="summary">
            <div class="card">
                <h3>Total Income</h3>
                <p id="totalIncome">Loading....</p>
            </div>
            <div class="card">
                <h3>Total Expenses</h3>
                <p id="totalExpenses">Loading....</p>
            </div>
            <div class="card">
                <h3>Balance</h3>
                <p id="totalBalance">Loading...</p>
            </div>
        </section>
        <section class="summary">
    		<div class="card">
    		     <h2>Download Monthly Transaction Data</h2>
			    <form action="report" method="get">
			        <label for="month">Select Month:</label>
			        <input type="month" id="month" name="month" required>
			        <button type="submit" id = "add-note-btn" class="btn btn-primary ">Download PDF</button>
			    </form>
    		</div>
        </section>
 
        <section class="chart">
            <h2>Income vs Expenses</h2>
            <canvas id="myChart"></canvas>
        </section>
    </main>

    <!-- Footer -->
    <footer>
        <p>&copy; 2025 BizTrack. All rights reserved.</p>
    </footer>

    <script>
        // Fetch data from the servlet
        fetch('ChartDataServlet')
            .then(response => response.json())
            .then(data => {
                // Extract totals
                document.getElementById('totalIncome').innerText = data.totalIncome.toFixed(2);
                document.getElementById('totalExpenses').innerText = data.totalExpense.toFixed(2);
                document.getElementById('totalBalance').innerText = data.balance.toFixed(2);
                // Extract chart data
                const labels = [];
                const incomeData = [];
                const expenseData = [];

                data.chartData.forEach(item => {
                    labels.push('Month ' + item.month); // Month number as label
                    incomeData.push(item.total_income); // Total income for the month
                    expenseData.push(item.total_expense); // Total expense for the month
                });

                // Render the chart using Chart.js
                const ctx = document.getElementById('myChart').getContext('2d');
                const myChart = new Chart(ctx, {
                    type: 'bar',
                    data: {
                        labels: labels,
                        datasets: [
                            {
                                label: 'Income',
                                data: incomeData,
                                backgroundColor: 'rgba(75, 192, 192, 0.5)',
                                borderColor: 'rgba(75, 192, 192, 1)',
                                borderWidth: 1
                            },
                            {
                                label: 'Expenses',
                                data: expenseData,
                                backgroundColor: 'rgba(255, 99, 132, 0.5)',
                                borderColor: 'rgba(255, 99, 132, 1)',
                                borderWidth: 1
                            }
                        ]
                    },
                    options: {
                        responsive: true,
                        plugins: {
                            legend: {
                                position: 'top',
                            },
                        },
                        scales: {
                            y: {
                                beginAtZero: true
                            }
                        }
                    }
                });
            })
            .catch(error => console.error('Error fetching data:', error));
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>